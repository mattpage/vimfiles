# vim setup

## requirements

* neovim
* Homebrew or Linuxbrew

## installation

### install vim-plug

use vim-plug for installing plugins and runtime files.

```bash
mkdir -p ~/.vim/autoload ~/.vim/backup ~/.vim/bundle ~/.vim/colors
cp -r ./vim/ ~/.vim/
cp -r ./config/ ~/.config/
```

### install dotfiles

```bash
cp .vimrc ~
cp .ctags ~
```

### install vim plugins
Open nvim and run `:PlugInstall`

### install fzf and ripgrep

fzf is a command-line fuzzy finder.
It is a replacement for ctrl+p.

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

use ripgrep for searching since it supports ignoring directories like 'node_modules'

```bash
brew install ripgrep
```

or see ripgrep [installation](https://github.com/BurntSushi/ripgrep#installation)

then add the following to ~/.fzf.bash or ~/.fzf.zsh

```bash
# set fzf source to ripgrep and ignore some dirs
# see https://github.com/junegunn/fzf#respecting-gitignore
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,coverage}/*" 2> /dev/null'
```

If you want to be able to search for devdocs using fzf:

```bash
mkdir ~/.local/share/devdocs
chmod +x update-devdocs.sh
cp update-devdocs.sh ~/.local/share/devdocs/
```

You can then generate an index by either running that script or using `:DevDocsUpdate` in vim.
You can change the type of docs indexed by editing the script.

### install ctags

```bash
#macos
brew install universal-ctags

#linux
sudo apt install universal-ctags
```

### remap capslock

To map capslock to ctrl, add this to .bashrc

```bash
#linux
setxkbmap -layout us -option ctrl:nocaps
```

## language support

### C/C++

```bash
brew install cppcheck
brew install clang-format
```

### go

```bash
brew install go
```

In vim, type
```
:GoInstallBinaries
```

### javascript

```bash
npm install eslint --save-dev
eslint --init
npm install prettier-eslint --save-dev
```

### ruby
For ruby linting, make sure rubocop is on your path.

### yaml

```bash
brew install yamllint
```

## key mappings and commands

```bash
'jj'      leave insert mode (same as esc)
'v'       leave visual mode
'esc+esc' no highlight
'\s'      save
'ctrl+d'  scroll down
'ctrl+u'  scroll up
'\rtw'    remove trailing whitespace
'\rts'    remove trailing whitespace
'\cp'     copy the file path of the current buffer to the clipboard
']q'      next item in quickfix
'[q'      prev item in quickfix
'\y'      yank to system clipboard
'\p'      paste from system clipboard
'\d'      delete to system clipboard
```

### a.vim

```bash
'\o'    toggle between source and header file
'\os'   toggle and open in a split
'\ov'   toggle and open in a vertical split
'\ot'   toggle and open in a tab
```

### bookmarks

```bash
'mm'   Add/remove bookmark at current line
'mi'   Add/edit/remove annotation at current line
'mn'   Jump to next bookmark in buffer
'mp'   Jump to previous bookmark in buffer
'ma'   Show all bookmarks (toggle)
'mc'   Clear bookmarks in current buffer only
'mx'   Clear bookmarks in all buffers
```

### buffer and bufexplorer

```bash
'\be'       open buffer explorer (normal)
'\bs'       open buffer explorer (horiz split)
'\bv'       open buffer explorer (vert split)
'\bf'       buffer forward
'\bb'       buffer back
'\bn'       buffer next
'\bp'       buffer previous
'\bc'       buffer close - deletes buffer w/o closing window
'\bd'       buffer delete - same as above
'\buf'      same as :buf commands below.
':buf file' autocomplete filename with <Tab>
':buf + n'  where n is the buffer number
```

### camelCaseMotion

```bash
'\w'        move forward an inner-word
'\b'        move back an inner-word
'\e'        move to the end of the next inner-word
'\ge'       move back to the end of the previous inner-word
```

### find/replace all

```bash
'/fr'     Prompts for Find/Replace text then does a ripgrep search followed by 'cfdo %s/<find>/<replace>/gc | update'
```

### fzf

```bash
'\fb'     fuzzy find buffers
'\fc'     fuzzy find git commits
'\ff'     fuzzy find files
'\fl'     fuzzy find lines
'\ft'     fuzzy find tags
```

#### fzf search syntax

```
foo       Fuzzy match (default)
^foo      Starts with 'foo'
bar$      Ends with 'bar'
'baz      Must Include the term 'baz'
'baz'     Matches 'baz' at word boundary
foo|bar   Logical OR operator. Matches 'foo' or 'bar'
!baz      Inverse exact match. Items that do not include 'baz'
!^foo     Inverse starts with. Items that do not start with 'foo'
!bar$     Inverse ends with. Items that do not end with 'bar'
```

#### fzf devdocs support

```bash
'\fd'               fuzzy find devdoc and open in browser
':DevDocsUpdate'    generate a devdocs index
```

### JSON commands

```bash
':PrettyPrintJSON'  Prettify JSON
':PrettyJSON'       Alias to above
':PrettyJson'       Alias to above
':FormatJSON'       Alias to above
':FormatJson'       Alias to above
```

### nerdtree

```bash
'\n'      toggle nerdtree
```

### registers

```bash
'"0p'   Paste what was last yanked from the yank register
'"1-9p' Paste what was last changed or deleted from most recent 1 to oldest 9
```

### ripgrep

```bash
':Rg'     <string|pattern>
':RgRoot' show root search dir
```

### snipmate commands

```bash
'\vv'  Insert
'\vb'  Back
'\vs'  Show available snippets based on previous text
```

### tagbar

```bash
'\tt' Toggle Tagbar
```

### Treesitter mappings
```bash
# Motions
']m'	next function start
'[m'	previous function start
']M'	next function end
'[M'	previous function end
']]'	next class/module start (class in Ruby, type/interface in Go, class in JS, struct in C)
'[['	previous class/module start
']['	next class/module end
'[]'	previous class/module end

# Text Objects
'vaf'	around function
'vif'	inside function
'vac'	around class/module (Ruby: class/module; Go: type; JS: class; C: struct/union)
'vic'	inside class/module
'vab'	around block ({ ... } or do/end in Ruby)
'vib'	inside block
'vap'	around parameter list
'vip'	inside parameter list
'vas'	around statement (if, for, return, etc.)
'vis'	inside statement

# Incremental Selection
'gnn'	start Treesitter selection at cursor
'grn'	expand to next node
'grc'	expand to outer scope (function/class/module)
'grm'	shrink selection
```

### vim-commentary

Comment and uncomment this or that

```bash
'gcc' to comment out a line
'5gcc' comment 5 lines
'gc{motiion}'
```

### vim-fugitive

Use `:Git` or `:G` followed by any git command

```bash
':Git status'
':Git pull'
':Git log --oneline'
':Git diff'
':GBrowse' open a web page for the current file at your git host (github, gitlab, etc)
```

### vim-go

Go development

```bash

# navigation
':GoAlternate'  switch between file.go and file_test.go
':GoDef'        goto symbol/declaration
':GoDefType'    goto type definition for the identifier under the cursor

# build, run, debug
':GoBuild'      build it
':GoRun'        run it
':GoDebugStart' debug it w/ Delve

# code quality
':GoCoverage'   generate coverage for the current file
':GoErrCheck'   check for unchecked errors in the current package
':GoFmt'        format the current buffer
':GoLint'       lint the current file directory
':GoTest'       test it
':GoTestFile'   test the current file
':GoTestFunc'   test a single func
':GoVet'        vet the current file directory

# meta
':GoDeps'       show dependencies for the current package
':GoDoc'        lookup documentation
':GoFiles'      show source files for the current package
':GoInfo'       info about the identifier under the cursor
```

### vim-obsession

Session commands

```bash
'\ss'  Start a session
'\sr'  Restore a session
'\sp'  Pause a session
'\sx'  Destroy a session
```

### vim-peekaboo

Extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers in a sidebar.
This is similar to tagbar but for displaying the contents of the registers.

### vim-rails

```bash
`gf`    Enhanced version of goto file
`:A`    Jump to the "alternate" file
`:AS`   Jump to the alternate in a split
`:AV`   Jump to the alternate in a vertical split
`:R`    Jump to the "related" file
`:RS`   Jump to the "related" file in a split
`:RV`   Jump to the "related" file in a split
```

### vim-surround

```bash
#add
`ys{motion}{char}`  Add a surrounding {char} to {motion}, e.g., `ysw[`

#delete
`ds{char}`          Delete a surrounding {char}, e.g., `ds(`

#change
`cs{char}{char}`    Change a surrounding {char} to {char}, e.g., `cs([`
```

### window commands

```bash
'Ctrl-W H'          Moves the cursor to the left window
'Ctrl-W J'          Moves the cursor to the window below
'Ctrl-W K'          Moves the cursor to the window upper
'Ctrl-W L'          Moves the cursor to the right window
'Ctrl-W V'          Opens a new vertical split
'Ctrl-W S'          Opens a new horizontal split
'Ctrl-W C'          Closes a window
'Ctrl-W O'          Makes the current window the only one on screen and closes other windows
'Ctrl-W V'          Opens a new vertical split
'Ctrl-W S'          Opens a new horizontal split
'Ctrl-W C'          Closes a window
'Ctrl-W O'          Makes the current window the only one on screen and closes other windows
':vsplit filename'  Split window vertically
':split filename'   Split window horizontally
':new filename'     Create new window
```

## resources

* [ale](https://github.com/w0rp/ale)
* [a.vim](https://github.com/vim-scripts/a.vim)
* [bclose](https://github.com/rbgrouleff/bclose.vim)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [CamelCaseMotion](https://github.com/bkad/CamelCaseMotion)
* [Delve cli](https://github.com/go-delve/delve/tree/master/Documentation/cli)
* [fzf.vim](https://github.com/junegunn/fzf.vim)
* [indentline](https://github.com/Yggdroot/indentLine)
* [lightline](https://github.com/itchyny/lightline.vim)
* [nerdtree](https://github.com/scrooloose/nerdtree)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* [tagbar](https://github.com/preservim/tagbar)
* [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vimcompletesme](https://github.com/vim-scripts/VimCompletesMe)
* [vim-endwise](https://github.com/tpope/vim-endwise)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [vim-go](https://github.com/fatih/vim-go)
* [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags.git)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-obsession](https://github.com/tpope/vim-obsession)
* [vim-oscyank](https://github.com/ojroques/vim-oscyank)
* [vim-peekaboo](https://github.com/junegunn/vim-peekaboo)
* [vim-rails](https://github.com/tpope/vim-rails)
* [vim-rhubarb](https://github.com/tpope/vim-rhubarb)
* [vim-ripgrep](https://github.com/jremmen/vim-ripgrep)
* [vim-snipmate](https://github.com/garbas/vim-snipmate)
* [vim-surround](https://github.com/tpope/vim-surround)
* [vim-solarized8](https://github.com/lifepillar/vim-solarized8)
