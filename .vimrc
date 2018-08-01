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
endif

" if a given file type (perl, ruby, python, c, etc) has its own special auto-indentation rules, use them
filetype plugin indent on

" Set file encoding
set encoding=utf-8

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
let g:ale_linters = {'javascript': ['eslint']}

" :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {'javascript': ['prettier-eslint', 'eslint']}

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

" --- YouCompleteMe ---

" GoToDefinition
" This command tries to perform the 'most sensible' GoTo operation it can.
" Currently, this means that it tries to look up the symbol under the cursor and
" jumps to its definition if possible; if the definition is not accessible from
" the current translation unit, jumps to the symbol's declaration. 
map <Leader>go :YcmCompleter GoTo<CR>

" GetType
" Echos the type of the variable or method under the cursor, and where it
" differs, the derived type.
" map <Leader>type :YcmCompleter GetType<CR>

" GetDoc
"Displays the preview window populated with quick info about the identifier under
"the cursor. 
" map <Leader>doc :YcmCompleter GetDoc<CR>

" FixIt
" Where available, attempts to make changes to the buffer to correct diagnostics
" on the current line. Where multiple suggestions are available (such as when
" there are multiple ways to resolve a given warning, or where multiple
" diagnostics are reported for the current line), the options are presented and
" one can be selected.
map <Leader>fix :YcmCompleter FixIt<CR>

" RefactorRename
" This command attempts to perform a semantic rename of the identifier under the
" cursor. This includes renaming declarations, definitions and usages of the
" identifier, or any other language-appropriate action. 
map <Leader>ren :YcmCompleter RefactorRename<CR>

" Format
" This command formats the whole buffer or some part of it according to the
" value of the Vim options shiftwidth and expandtab (see :h 'sw' and :h et
" respectively). To format a specific part of your document, you can either
" select it in one of Vim's visual modes (see :h visual-use) and run the command
" or directly enter the range on the command line, e.g. :2,5YcmCompleter Format
" to format it from line 2 to line 5.
map <Leader>format :YcmCompleter Format<CR>

" OrganizeImports
" This command removes unused imports and sorts imports in the current file. 
" map <Leader>org :YcmCompleter OrganizeImports<CR>

" RestartServer
" Restarts the semantic-engine-as-localhost-server for those semantic engines
" that work as separate servers that YCM talks to.
map <Leader>restart :YcmCompleter RestartServer<CR>

" ReloadSolution
" Instruct the Omnisharp server to clear its cache and reload all files from
" disk. This is useful when files are added, removed, or renamed in the
" solution, files are changed outside of Vim, or whenever Omnisharp cache is
" out-of-sync.
map <Leader>reload :YcmCompleter ReloadSolution<CR>

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
