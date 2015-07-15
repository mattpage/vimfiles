" This option stops vim from behaving in a strongly vi -compatible way.
set nocompatible

" Show line numbers
set number

"  add a line / column display in the bottom right-hand section of the screen.
set ruler

" --- Pathogen ----
execute pathogen#infect()

" turn on syntax highlighting
syntax on

" if has('gui_running')
    set background=light
"else
"    set background=dark
"endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

" if a given file type (perl, ruby, python, c, etc) has its own special auto-indentation rules, use them
filetype plugin indent on

" Set file encoding
set encoding=utf-8

" --- Whitespace stuff ---
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" backspace should delete over line breaks and such
set backspace=indent,eol,start

" The command :set list displays whitespace, while :set nolist displays normally.
set nolist

" --- Search related ---
set hlsearch   " highlight search matches
set incsearch  " enable incremental searching
set ignorecase " searching is not case sensitive
set smartcase  " When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not.
set gdefault   " search globally by default

" --- command line completion ----
" Pressing Tab (repeatedly) will autocomplete in command mode
set wildmenu
set wildmode=list:longest,list:full
"do not autocomplete the following
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,node_modules

" allow switching away from modified buffers. will keep the changes to the buffer without writing them to the file
set hidden

" Status bar - always show
set laststatus=2

" lightly highlight the current line on which the cursor is placed (turn this off if it gets annoying)
set cursorline

" lightly highlight the current column in which the cursor is placed (turn this off if it gets annoying)
" set cursorcolumn

" tell vim to scan the file for a modeline that contains in-line vim commands and options, just for that file
set modeline
set modelines=10

" Enable indent folding
set foldenable
set fdm=indent
set nofoldenable
set foldnestmax=10
set foldlevel=1

"Set space to toggle a fold
" nnoremap <space> za

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Show (partial) command in the status line
set showcmd

" set font and increase size for readability
set gfn=Menlo\ Regular:h14

" --- Syntastic ---
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_debug = 3
let g:syntastic_check_on_open=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_javascript_eslint_args = '--config ~/.eslintrc'

" Disable Arrow Keys
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Use jj to leave insert mode
inoremap jj <Esc>

" Use v to leave insert mode while in visual mode
vnoremap v <esc>

" --- NERDTree ---
"  map leader+n to toggle the tree
map <Leader>n :NERDTreeToggle<CR>

" --- NERDCommenter ---
" map <Leader>c :NERDCommenterToggle<CR>

" --- Buffer switching --"
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>
map <C-S-Q> :Bclose<cr>

" --- Shift+Enter in normal mode should insert a line above the current --- "
nmap <s-cr> 0i<cr><Esc>

" --- ShowMarks ---
if has("gui_running")
let g:showmarks_enable=1
else
let g:showmarks_enable=0
let loaded_showmarks=1
endif

let g:showmarks_include="abcdefghijklmnopqrstuvwxyz"
let g:showmarks_hlline_lower=1
let g:showmarks_hlline_upper=1
let g:showmarks_hlline_other=1

if has("autocmd")
  fun! FixShowmarksColours()
    if has('gui')
      hi ShowMarksHLl gui=bold guifg=#a0a0e0 guibg=#dddddd
      hi ShowMarksHLu gui=none guifg=#a0a0e0 guibg=#dddddd
      hi ShowMarksHLo gui=none guifg=#a0a0e0 guibg=#dddddd
      hi ShowMarksHLm gui=none guifg=#a0a0e0 guibg=#dddddd
      hi SignColumn gui=none guifg=#f0f0f8 guibg=#dddddd
    endif
  endfun
  if v:version >= 700
    autocmd VimEnter,Syntax,ColorScheme * call FixShowmarksColours()
  else
    autocmd VimEnter,Syntax * call FixShowmarksColours()
  endif
endif

" highlight trailing whitespace as errors
match ErrorMsg '\s\+$'

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
" remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" unhilight on escape
nnoremap <esc> :noh<return><esc>

if has("autocmd")
  autocmd FileWritePre    * :call TrimWhiteSpace()
  autocmd FileAppendPre   * :call TrimWhiteSpace()
  autocmd FilterWritePre  * :call TrimWhiteSpace()
  autocmd BufWritePre     * :call TrimWhiteSpace()
endif

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 "setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

