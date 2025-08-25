# vim setup

## requirements

* neovim
* Homebrew or Linuxbrew

## install vim-plug

use vim-plug for installing plugins and runtime files.

```bash
mkdir -p ~/.vim/autoload ~/.vim/backup ~/.vim/bundle ~/.vim/colors
cp -r ./vim/ ~/.vim/
cp -r ./config/ ~/.config/
```

## install dotfiles

```bash
cp .vimrc ~
cp .ctags ~
```

## install vim plugins
Open nvim and run `:PlugInstall`

## install fzf and ripgrep

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

## install ctags

```bash
#macos
brew install universal-ctags

#linux
sudo apt install universal-ctags
```

## remap capslock

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
```

### a.vim

```bash
'\o'    toggle between source and header file
'\os'   toggle and open in a split
'\ov'   toggle and open in a vertical split
'\ot'   toggle and open in a tab
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

### nerdtree

```bash
'\n'      toggle nerdtree
```

### tagbar

```bash
'\tt' Toggle Tagbar
```

### fzf

```bash
'\fb'     fuzzy find buffers
'\fc'     fuzzy find git commits
'\ff'     fuzzy find files
'\fl'     fuzzy find lines
'\ft'     fuzzy find tags
```

### ripgrep

```bash
':Rg'     <string|pattern>
':RgRoot' show root search dir
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

### session commands

```bash
'\ss'  Start a session
'\sr'  Restore a session
'\sp'  Pause a session
'\sx'  Destroy a session
```

### JSON commands

```bash
':PrettyPrintJSON'  Prettify JSON
':PrettyJSON'       Alias to above
':PrettyJson'       Alias to above
':FormatJSON'       Alias to above
':FormatJson'       Alias to above
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

## resources

* [ale](https://github.com/w0rp/ale)
* [a.vim](https://github.com/vim-scripts/a.vim)
* [bclose](https://github.com/rbgrouleff/bclose.vim)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [CamelCaseMotion](https://github.com/bkad/CamelCaseMotion)
* [fzf.vim](https://github.com/junegunn/fzf.vim)
* [indentline](https://github.com/Yggdroot/indentLine)
* [lightline](https://github.com/itchyny/lightline.vim)
* [nerdtree](https://github.com/scrooloose/nerdtree)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* [tagbar](https://github.com/preservim/tagbar)
* [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vimcompletesme](https://github.com/ajh17/VimCompletesMe)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [vim-go](https://github.com/fatih/vim-go)
* [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags.git)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-obsession](https://github.com/tpope/vim-obsession)
* [vim-oscyank](https://github.com/ojroques/vim-oscyank)
* [vim-rails](https://github.com/tpope/vim-rails)
* [vim-rhubarb](https://github.com/tpope/vim-rhubarb)
* [vim-ripgrep](https://github.com/jremmen/vim-ripgrep)
* [vim-solarized8](https://github.com/lifepillar/vim-solarized8)
