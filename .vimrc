" This option stops vim from behaving in a strongly vi -compatible way. 
set nocompatible

" Show line numbers
set number

"  add a line / column display in the bottom right-hand section of the screen.
set ruler

" turn on syntax highlighting
syntax on

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

" --- Tab completion ----
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

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

"Enable indent folding
" set foldenable
" set fdm=indent

"Set space to toggle a fold
" nnoremap <space> za


" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Show (partial) command in the status line
set showcmd

" Set color scheme
colorscheme freya 

" set font and increase size for readability
set gfn=Menlo\ Regular:h14

" Disable Arrow Keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" --- NERDTree ---
"  map leader+n to toggle the tree
map <Leader>n :NERDTreeToggle<CR>

" --- Buffer switching --"
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>

" --- Shift+Enter in normal mode should insert a line above the current --- "
nmap <s-cr> 0i<cr><Esc>

" easy way to get back to normal mode  
inoremap jj <Esc>  

" associate html validator with html files - https://github.com/sorin-ionescu/vim-htmlvalidator
au FileType html compiler html

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

