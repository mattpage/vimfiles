" =========================
" Detect OS
" =========================
if has('macunix')
    let g:os = 'mac'
elseif has('unix')
    let g:os = 'linux'
else
    let g:os = 'other'
endif

" =========================
" Vim Plug setup
" =========================
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'itchyny/lightline.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'bkad/CamelCaseMotion'
Plug 'Yggdroot/indentLine'
Plug 'ojroques/vim-oscyank'
if has('nvim')
    Plug 'lifepillar/vim-solarized8', { 'branch': 'neovim' }
else
    Plug 'lifepillar/vim-solarized8'
endif
Plug 'w0rp/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-scripts/VimCompletesMe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rhubarb'

call plug#end()

" =========================
" General Settings
" =========================
syntax enable
set termguicolors
colorscheme solarized8_high
set background=dark
filetype plugin indent on
set encoding=utf-8
set clipboard^=unnamed,unnamedplus
set number
set ruler
set nowrap
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set backspace=indent,eol,start
set nolist
set hlsearch incsearch ignorecase smartcase gdefault
set wildmenu wildmode=list:longest,list:full
set hidden
set laststatus=2
set cursorline
set mouse=a
set modeline modelines=10
set foldenable fdm=indent foldnestmax=10 foldlevel=1
set backupcopy=yes
set showcmd

" =========================
" Directories
" =========================
if !isdirectory(expand('~/.vim/backup'))
    call mkdir(expand('~/.vim/backup'), 'p')
endif
set backupdir=~/.vim/backup
set directory=~/.vim/backup

if !isdirectory(expand('~/.vim/sessions'))
    call mkdir(expand('~/.vim/sessions'), 'p')
endif
let g:sessions_dir = expand('~/.vim/sessions')

" =========================
" Cursor shape
" =========================
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    endif
elseif &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

" =========================
" Whitespace & indentation
" =========================
augroup GoWhitespace
    autocmd!
    autocmd FileType go setlocal noexpandtab
augroup END

augroup YamlIndent
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" =========================
" Mappings
" =========================
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>bf :bnext<CR>
nnoremap <Leader>bb :bprevious<CR>
nnoremap <Leader>bc :Bclose<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fc :Commits<CR>
nnoremap <Leader>s :w<CR>
inoremap jj <Esc>
vnoremap v <Esc>
noremap <esc><esc> :nohl<CR>

" Trim trailing whitespace
function! TrimWhiteSpace() abort
    %s/\s\+$//e
endfunction
nnoremap <Leader>rts :call TrimWhiteSpace()<CR>
nnoremap <Leader>rtw :call TrimWhiteSpace()<CR>

" Yank using OSC52
vnoremap <Leader>y :OSCYankVisual<CR>
vnoremap yy :OSCYankVisual<CR>

" Copy file path
nnoremap <Leader>cp :let @" = expand("%")<CR>:OSCYankRegister "<CR>

" =========================
" ALE configuration
" =========================
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1

if g:os ==# 'mac'
    if isdirectory('/opt/homebrew/bin') && $PATH !~# '/opt/homebrew/bin'
        let $PATH = '/opt/homebrew/bin:' . $PATH
    endif
    if filereadable('/usr/local/bin/ctags')
        let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
    else
        let g:gutentags_ctags_executable = 'ctags'
    endif
elseif g:os ==# 'linux'
    let g:gutentags_ctags_executable = 'ctags'
endif

if executable('rubocop')
    let g:ale_ruby_rubocop_executable = 'rubocop'
endif

" ALE linters/fixers
let g:ale_linters = {
\   'c': ['cc', 'cppcheck'],
\   'cpp': ['cc', 'cppcheck'],
\   'go': ['gopls'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_fixers = {
\   'c': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports', 'trim_whitespace', 'remove_trailing_lines'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

" =========================
" Vim-Go configuration
" =========================
if g:os ==# 'mac'
    let g:go_bin = 'go'
    let g:gopls_bin = 'gopls'
elseif g:os ==# 'linux'
    let g:go_bin = 'go'
    let g:gopls_bin = 'gopls'
endif

let g:go_gopls_enabled = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_list_type = "quickfix"
let g:go_doc_popup_window = 1

" Go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

" Update Go binaries on Vim start if Go exists
autocmd VimEnter * if executable(g:go_bin) | silent! :GoUpdateBinaries | endif

" =========================
" Gutentags
" =========================
set statusline+=%{gutentags#statusline()}

" =========================
" CamelCaseMotion
" =========================
let g:camelcasemotion_key = '<leader>'

" =========================
" Vim sessions
" =========================
nnoremap <Leader>ss :Obsession ~/vim-sessions/*.vim<CR>
nnoremap <Leader>sr :so ~/vim-sessions/*.vim<CR>
nnoremap <Leader>sp :Obsession<CR>
nnoremap <Leader>sx :Obsession!<CR>

" =========================
" FZF runtime path
" =========================
if executable('fzf')
    set rtp+=~/.fzf
endif

" =========================
" Pretty print JSON
" =========================
command! PrettyPrintJSON %!python3 -m json.tool
command! PrettyJSON PrettyPrintJSON
command! PrettyJson PrettyPrintJSON
command! FormatJSON PrettyPrintJSON
command! FormatJson PrettyPrintJSON
