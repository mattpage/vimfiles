" Always disable old vi compatibility
set nocompatible

" make sure homebrew binaries are in the PATH if they exist
if isdirectory('/opt/homebrew/bin') && $PATH !~# '/opt/homebrew/bin'
    let $PATH = '/opt/homebrew/bin:' . $PATH
endif

" Disable concealment globally
set conceallevel=0       " Never hide characters
set concealcursor=       " Cursor won’t reveal hidden characters

" ============================================================================

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'jlanzarotta/bufexplorer'
Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'jremmen/vim-ripgrep'
Plug 'pangloss/vim-javascript'
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
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/VimCompletesMe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

if has('nvim')
  function! UpdateTreesitter()
    if exists(':TSUpdate')
      TSUpdate
    endif
  endfunction
  Plug 'nvim-treesitter/nvim-treesitter', {'do': function('UpdateTreesitter')}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
endif

call plug#end()

" ============================================================================

" turn on syntax highlighting
syntax enable

" setup theme
set termguicolors
colorscheme solarized8_high
set background=dark

augroup SetSolarizedColorScheme
  autocmd!
  autocmd vimenter * ++nested colorscheme solarized8_high
augroup END

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

" Show line numbers
set number

"  add a line / column display in the bottom right-hand section of the screen.
set ruler

" --- Clipboard stuff ---
set clipboard^=unnamed,unnamedplus

" Safe defaults
" Normal deletions/changes go to black hole, not clipboard
nnoremap d "_d
nnoremap D "_D
nnoremap c "_c
nnoremap C "_C

" Small deletions go to local numbered register ("1")
nnoremap x "1x
nnoremap s "1s

" Safe pasting in visual mode
" 'p' in visual mode won't clobber the clipboard.
vnoremap p "_c<C-r><C-o>+

" Explicit clipboard operations
" Use <leader>y/d/p when you *want* to affect the clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p

" --- Whitespace stuff ---
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

augroup SetGoWhitespace
   autocmd!
   autocmd filetype go setlocal noexpandtab
augroup end

" backspace should delete over line breaks and such
set backspace=indent,eol,start

" Do not display whitespace (list/nolist)
set nolist

" Search related
set hlsearch   " highlight search matches
set incsearch  " enable incremental searching
set ignorecase " searching is not case sensitive
set smartcase  " When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not.
set gdefault   " search globally by default

" command line completion
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
set foldnestmax=10
set foldlevel=1

" Force vim to make backup copy and overwrite original
set backupcopy=yes

" Directories for swp files
if !isdirectory(expand('~/.vim/backup'))
    call mkdir(expand('~/.vim/backup'), 'p')
endif
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" map ]q and [q to cnext and cprev in quickfix
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" highlight trailing whitespace as errors
match ErrorMsg '\s\+$'

" Removes trailing spaces
function! TrimWhiteSpace() abort
    %s/\s\+$//e
endfunction

" remove trailing whitespace
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
nnoremap <Leader>rtw :call TrimWhiteSpace()<CR>

" When vimrc is edited, reload it
augroup ReloadVimrcAfterEdit
  autocmd!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" yaml stuff
augroup SetYamlIndent
  autocmd!

  " yaml requires 2 space indenting
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" Show (partial) command in the status line
set showcmd

" Super easy saves
nnoremap <leader>s :w<CR>

" Use jj to leave insert mode
inoremap jj <Esc>

" Use v to leave insert mode while in visual mode
vnoremap v <esc>

" NOTE: single escape causes vim to start in insert mode on debian9.
" unhilight on escape escape
noremap <esc><esc> :nohl<cr>

" --- NERDTree ---
nnoremap <Leader>n :NERDTreeToggle<CR>

" --- Buffer switching ---
nnoremap <Leader>bn :bnext<cr>
nnoremap <Leader>bf :bnext<cr>
nnoremap <Leader>bp :bprevious<cr>
nnoremap <Leader>bb :bprevious<cr>
nnoremap <Leader>bc :Bclose<cr>
nnoremap <Leader>bd :bdelete<cr>
nnoremap <silent> <Leader>buf :buffer

" --- A.vim for header/source toggling --- "
nnoremap <silent> <Leader>o :A<CR>

" Options to open in split, vert-split, and tab
nnoremap <silent> <Leader>os :AS<CR>
nnoremap <silent> <Leader>ov :AV<CR>
nnoremap <silent> <Leader>ot :AT<CR>

" tell vim not to auto resize splits
:set noequalalways
:set winfixwidth

let g:alternateSearchPath = 'src,include'

" --- ALE ---

if isdirectory('bin/rubocop')
  let g:ale_ruby_rubocop_executable = 'bin/rubocop'
else
  let g:ale_ruby_rubocop_executable = 'rubocop'
endif

" only enable explicitly defined linters below
let g:ale_linters_explicit = 1

let g:ale_fixers = {}
let g:ale_c_cc_executable = 'clang'
let g:ale_c_cppcheck_executable = 'cppcheck'

let g:ale_linters = {
\   'c': ['cc','cppcheck'],
\   'cpp': ['cc','cppcheck'],
\   'go': ['gopls'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\   'c': ['clang-format','remove_trailing_lines','trim_whitespace'],
\   'cpp': ['clang-format','remove_trailing_lines','trim_whitespace'],
\   'go': ['gofumpt'],
\   'javascript': ['prettier-eslint', 'eslint'],
\   'ruby': ['rubocop'],
\   'typescript': ['prettier-eslint', 'eslint'],
\   'typescriptreact': ['prettier-eslint', 'eslint'],
\}

let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

" use rubocop if there's a config for it
if filereadable(".rubocop.yml")
  let g:ale_linters.ruby = ['mri', 'rubocop']
  let g:ale_fixers.ruby = ['rubocop']
endif

let g:ale_go_langserver_executable = ''
let g:ale_completion_enabled = 0

" fix files automatically on save.
let g:ale_fix_on_save = 1

"--- FZF ---
set rtp+=~/.fzf

" map leader+ff to fuzzy find files
nnoremap <Leader>ff :Files<CR>

" map leader+fc to find commits
nnoremap <Leader>fc :Commits<CR>

" map leader+fb to fuzzy find buffers
nnoremap <Leader>fb :Buffers<CR>

" map leader+fl to fuzzy find lines
nnoremap <Leader>fl :Lines<CR>

" map leader+ft to fuzzy find tags
nnoremap <Leader>ft :Tags<CR>

"--- FZF devdocs support ---

" open devdocs in browser
function! s:OpenDevDocsUrl(lines)
  if empty(a:lines)
    return
  endif
  let url = split(a:lines[0], '\t')[-1]
  if executable('open')
    call system('open ' . shellescape(url) . ' &')
  elseif executable('xdg-open')
    call system('xdg-open ' . shellescape(url) . ' &')
  else
    echo 'Open this manually: ' . url
  endif
endfunction

" Base directory for DevDocs data
let g:devdocs_data_dir = expand('~/.local/share/devdocs')

function! DevDocsFzf()
  let index = g:devdocs_data_dir . '/devdocs_index.txt'
  if !filereadable(index)
    echoerr "DevDocs index not found. Run :DevDocsUpdate first."
    return
  endif

  " Handler function
  let l:Handler = function('s:OpenDevDocsUrl')

  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . shellescape(index),
        \ 'sink*': l:Handler,
        \ 'options': ['--delimiter', '\t', '--with-nth=1', '--prompt', 'DevDocs> '],
        \ }))
endfunction

" Fuzzy search mapping
nnoremap <leader>fd :call DevDocsFzf()<CR>

" Update command (run local update script)
command! DevDocsUpdate execute '!bash ' . shellescape(g:devdocs_data_dir . '/update-devdocs.sh')


"--- vim-commentary ---
nmap <leader>c gc<CR>

"--- vim-javascript ---
" do not syntax highlight jsdocs
let g:javascript_plugin_jsdoc = 0

" --- vim-go ---
" use the gopls language server
let g:go_gopls_enabled = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Specifies the type of list to use for command outputs (such as errors from builds, results from static analysis commands, etc...
let g:go_list_type="quickfix"

" Use a popup window for Shift+K and :GoDoc rather than preview window
let g:go_doc_popup_window = 1

" Highlight struct and interface names.
let g:go_highlight_types = 1

" Highlight struct field names.
let g:go_highlight_fields = 1

" Highlight function and method declarations.
let g:go_highlight_functions = 1

" Highlight function and method calls.
let g:go_highlight_function_calls = 1

" Highlight operators such as `:=` , `==`, `-=`, etc.
let g:go_highlight_operators = 1

" Highlight commonly used library types (`io.Reader`, etc.).
let g:go_highlight_extra_types = 1

" Highlights build constraints.
let g:go_highlight_build_constraints = 1

" Highlight go:generate directives.
let g:go_highlight_generate_tags = 1

" Highlight printf-style formatting verbs inside string literals.
let g:go_highlight_format_strings = 1

" Highlight variable names in variable declarations (`x` in ` x :=`).
let g:go_highlight_variable_declarations = 1

" Highlight variable names in variable assignments (`x` in `x =`).
let g:go_highlight_variable_assignments = 1

" Highlight diagnostic errors.
let g:go_highlight_diagnostic_errors = 1

" Highlight diagnostic warnings.
let g:go_highlight_diagnostic_warnings = 1

" --- vim-gutentags ---
let g:gutentags_ctags_executable = 'ctags'
set statusline+=%{gutentags#statusline()}

" --- tagbar ---
noremap <leader>tt :TagbarToggle<CR>

" --- indentline ---
let g:indentLine_char = '⦙'
let g:indentLine_fileTypeExclude = ['json']
" Prevent indentLine from forcing conceal
let g:indentLine_setConceal = 0

" --- CamelCaseMotion ---
let g:camelcasemotion_key = '<leader>'

" --- vim-obsession ---
if !isdirectory(expand('~/.vim/sessions'))
    call mkdir(expand('~/.vim/sessions'), 'p')
endif
let g:sessions_dir = expand('~/.vim/sessions')

" start session - displays listing of existing session files.
"                 BS are to delete the  *.vim part after typing it.
exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'

" restore session
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" pause session
nnoremap <Leader>sp :Obsession<CR>

" destroy session
nnoremap <Leader>sx :Obsession!<CR>

" -- vim-snipmate --
" Based on these settings that work with YouCompleteMe:
" https://github.com/ycm-core/YouCompleteMe/issues/47#issuecomment-363369730

imap <expr> <Leader>vv pumvisible() ? '<esc>a<Plug>snipMateNextOrTrigger' : '<Plug>snipMateNextOrTrigger'
smap <Leader>vv <Plug>snipMateNextOrTrigger

" Jump Backward
imap <expr> <Leader>vb pumvisible() ? '<esc>a<Plug>snipMateBack' : '<Plug>snipMateBack'
smap <Leader>vb <Plug>snipMateBack

" Show snippet Menu
imap <expr> <Leader>vs pumvisible() ? '<esc>a<Plug>snipMateShow' : '<Plug>snipMateShow'
smap <Leader>vs <Plug>snipMateShow


"--- enable matchit macro for do...end and various others ---
runtime macros/matchit.vim

" --- pretty print json using python
command! PrettyPrintJSON %!python3 -m json.tool
command! PrettyJSON PrettyPrintJSON
command! PrettyJson PrettyPrintJSON
command! FormatJSON PrettyPrintJSON
command! FormatJson PrettyPrintJSON

" --- Find/Replace All
function! RgFindReplaceAll() abort
  " Ask for find/replace in one prompt
  let l:input = input('Find/Replace (foo/bar): ')
  if empty(l:input) || stridx(l:input, '/') == -1
    echo "Input must be in the form find/replace"
    return
  endif

  " Split into find & replace parts
  let [l:find, l:replace] = split(l:input, '/', 1)

  " Populate quickfix with ripgrep results
  execute 'Rg ' . l:find

  " Open quickfix so we can review matches
  copen

  " Confirmed substitution on each file, save if changed
  execute 'cfdo %s/' . escape(l:find, '/') . '/' . escape(l:replace, '/') . '/gc | update'
endfunction

" Map to <leader>fr for convenience
nnoremap <leader>fr :call RgFindReplaceAll()<CR>

" " --- yank text in visual mode using the ANSI OSC52 sequence ---
vnoremap <leader>y :OSCYankVisual<CR>
vnoremap yy :OSCYankVisual<CR>

" --- copy file path of current buffer to clipboard ---
nnoremap <leader>cp :let @" = expand("%")<cr>:OSCYankRegister "<CR>

if has('nvim')
" --- Lua configuration for nvim-treesitter ---

lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "c",
    "go",
    "javascript",
    "markdown",
    "markdown_inline",
    "ruby",
  },
  auto_install = true,

  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = false,
    -- disable = { "markdown" },
    additional_vim_regex_highlighting = { 'markdown' },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      node_decremental = "grm",
      scope_incremental = "grc",
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- record movements in the jump list
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },

  fold = {
    enable = true,
  },
}

-- Use Treesitter folds
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99

EOF
endif
