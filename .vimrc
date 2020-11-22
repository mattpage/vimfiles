execute pathogen#infect()

" This option stops vim from behaving in a strongly vi -compatible way.
set nocompatible

" turn on syntax highlighting
syntax enable

" solarized colors - background=dark|light
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" change cursor based on mode
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
else
  " Use a blinking vertical bar cursor in insert mode, and a blinking block in normal
  if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
  endif
endif


" if a given file type (perl, ruby, python, c, etc) has its own special auto-indentation rules, use them
filetype plugin indent on

" Set file encoding
set encoding=utf-8

" allow clipboard across platforms
set clipboard^=unnamed,unnamedplus

" Show line numbers
set number

"  add a line / column display in the bottom right-hand section of the screen.
set ruler

" --- Whitespace stuff ---
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" backspace should delete over line breaks and such
set backspace=indent,eol,start

" Do not display whitespace (list/nolist)
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

" enable mouse support - sometimes handy
set mouse=a

" tell vim to scan the file for a modeline that contains in-line vim commands and options, just for that file
set modeline
set modelines=10

" Enable indent folding
set foldenable
set fdm=indent
set nofoldenable
set foldnestmax=10
set foldlevel=1

" Force vim to make backup copy and overwrite original
set backupcopy=yes

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" highlight trailing whitespace as errors
match ErrorMsg '\s\+$'

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" remove trailing whitespace
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
nnoremap <Leader>rtw :call TrimWhiteSpace()<CR>

" if has("autocmd")
"   autocmd FileWritePre    * :call TrimWhiteSpace()
"   autocmd FileAppendPre   * :call TrimWhiteSpace()
"   autocmd FilterWritePre  * :call TrimWhiteSpace()
"   autocmd BufWritePre     * :call TrimWhiteSpace()
" endif

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Show (partial) command in the status line
set showcmd

" Super easy saves
map <leader>s :w<CR>

" Use jj to leave insert mode
inoremap jj <Esc>

" Use v to leave insert mode while in visual mode
vnoremap v <esc>

" NOTE: single escape causes vim to start in insert mode on debian9.
" unhilight on escape escape
nnoremap <esc><esc> :nohl<cr>

" Map Ctrl+Y and Ctrl+E to move Quarter page up/down respectively
" this overrides normal view scrolling behavior, but I never use that
function! ScrollQuarter(move)
  let height=winheight(0)

  if a:move == 'up'
    let key="k"
  else
    let key="j"
  endif

  execute 'normal! ' . height/4 . key
endfunction

nnoremap <C-Y> <up> :call ScrollQuarter('up')<CR>
nnoremap <C-E> <down> :call ScrollQuarter('down')<CR>

" --- NERDTree ---
map leader+n to toggle the tree
map <Leader>n :NERDTreeToggle<CR>

" --- Buffer switching ---
map <Leader>bf :bnext<cr>
map <Leader>bb :bprevious<cr>
map <Leader>bc :Bclose<cr>


" --- ALE ---
let g:ale_ruby_rubocop_executable = 'bin/rubocop'

let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
let g:ale_fixers = { 'javascript': ['prettier-eslint', 'eslint'], 'typescript': ['prettier-eslint', 'eslint'], 'typescriptreact': ['prettier-eslint', 'eslint'], 'ruby': ['rubocop'] }
let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

" use rubocop if there's a config for it
if filereadable(".rubocop.yml")
  let g:ale_linters.ruby = ['mri', 'rubocop']
  let g:ale_fixers.ruby = ['rubocop']
endif

" fix files automatically on save.
let g:ale_fix_on_save = 1

"--- FZF ---
set rtp+=~/.fzf

" map leader+ff to fuzzy find files
map <Leader>ff :Files<CR>

" map leader+fc to find commits
map <Leader>fc :Commits<CR>

"--- vim-commentary ---
map <leader>c gc

"--- vim-javascript ---
" do not syntax highlight jsdocs
let g:javascript_plugin_jsdoc = 0

" --- vim-jsx ---
" jsx extension is not required for syntax highlighting and indenting
let g:jsx_ext_required = 0

" --- vim-gutentags ---
if filereadable('/usr/local/Cellar/universal-ctags/HEAD-5d000b1/bin')
  " homebrew universal-ctags
  let g:gutentags_ctags_executable = '/usr/local/Cellar/universal-ctags/HEAD-5d000b1/bin/ctags'
elseif filereadable('/usr/local/bin/ctags')
  " homebrew
  let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
else
  let g:gutentags_ctags_executable = 'ctags'
endif
set statusline+=%{gutentags#statusline()}


" --- CamelCaseMotion ---
let g:camelcasemotion_key = '<leader>'


"--- enable matchit macro for do...end and various others ---
runtime macros/matchit.vim

" --- pretty print json using python
command! PrettyPrintJSON %!python -m json.tool
command! PrettyJSON PrettyPrintJSON
command! PrettyJson PrettyPrintJSON
command! FormatJSON PrettyPrintJSON
command! FormatJson PrettyPrintJSON
