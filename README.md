# vim setup

## requirements

* neovim
* Homebrew or Linuxbrew

## install vim-plug

use vim-plug for installing plugins and runtime files.

```shell
mkdir -p ~/.vim/autoload ~/.vim/backup ~/.vim/bundle ~/.vim/colors
cp -r ./vim/ ~/.vim/
cp -r ./config/ ~/.config/
```

## install dotfiles

```shell
cp .vimrc ~
cp .ctags ~
```

## reattach-to-user-namespace

for system clipboard access on macos

```shell
brew install reattach-to-user-namespace
```

## install vim plugins
Open nvim and run `:PlugInstall`

## ale linting support

Ale is an asynchronous linting engine.

Install eslint in your local project (or globally)
and setup a default eslint config for ale to use

```shell
npm install eslint --save-dev
eslint --init
```

it also supports prettier!

Install prettier-eslint in your project (or globally)

```shell
npm install prettier-eslint --save-dev
```

For ruby linting, make sure rubocop is on your path.

For yaml linting, you need to install `yamlint`

```shell
brew install yamllint
```

## fzf

fzf is a command-line fuzzy finder.
It is a replacement for ctrl+p.

```shell
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

use ripgrep for searching since it supports ignoring directories like 'node_modules'

```shell
brew install ripgrep
```

or see ripgrep [installation](https://github.com/BurntSushi/ripgrep#installation)

then add the following to ~/.fzf.bash or ~/.fzf.zsh

```shell
# set fzf source to ripgrep and ignore some dirs
# see https://github.com/junegunn/fzf#respecting-gitignore
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,coverage}/*" 2> /dev/null'
```

## ctags

```shell
#macos
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

#linux
sudo apt install universal-ctags
```

## go binaries

In vim, type
```
:GoInstallBinaries
```

## remap capslock

To map capslock to ctrl, add this to .bashrc

```shell
#linux
setxkbmap -layout us -option ctrl:nocaps
```

## key mappings

```shell
'jj'      leave insert mode (same as esc)
'v'       leave visual mode
'esc+esc' no highlight
'\s'      save
'ctrl+d'  scroll down
'ctrl+e'  scroll down 1/4 page
'ctrl+u'  scroll up
'ctrl+y'  scroll up 1/4 page
\rtw      remove trailing whitespace
\rts      remove trailing whitespace
\cp       copy the file path of the current buffer to the clipboard
```

## bufexplorer key mappings

```shell
'\be'     open buffer explorer (normal)
'\bs'     open buffer explorer (horiz split)
'\bv'     open buffer explorer (vert split)
'\bf'     buffer forward
'\bb'     buffer backwards
'\bc'     buffer close
```

## nerdtree key mappings

```shell
'\n'      toggle nerdtree
```

## fzf key mappings

```shell
'\ff'     fuzzy find files
'\fc'     fuzzy find git commits
```

## ripgrep commands

```shell
':Rg'     <string|pattern>
':RgRoot' show root search dir
```

## vim bookmarks commands

```shell
'mm'   Add/remove bookmark at current line
'mi'   Add/edit/remove annotation at current line
'mn'   Jump to next bookmark in buffer
'mp'   Jump to previous bookmark in buffer
'ma'   Show all bookmarks (toggle)
'mc'   Clear bookmarks in current buffer only
'mx'   Clear bookmarks in all buffers
```

## vim session commands

```shell
'\ss'  Start a session
'\sr'  Restore a session
'\sp'  Pause a session
'\sx'  Destroy a session
```

## JSON Tools

```shell
:PrettyPrintJSON  Prettify JSON
:PrettyJSON       Alias to above
:PrettyJson       Alias to above
:FormatJSON       Alias to above
:FormatJson       Alias to above
```

## resources

* [ale](https://github.com/w0rp/ale)
* [bclose](https://github.com/rbgrouleff/bclose.vim)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [CamelCaseMotion](https://github.com/bkad/CamelCaseMotion)
* [fzf.vim](https://github.com/junegunn/fzf.vim)
* [indentline](https://github.com/Yggdroot/indentLine)
* [lightline](https://github.com/itchyny/lightline.vim)
* [nerdtree](https://github.com/scrooloose/nerdtree)
* [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vimcompletesme](https://github.com/ajh17/VimCompletesMe)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [vim-go](https://github.com/fatih/vim-go)
* [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags.git)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-obsession](https://github.com/tpope/vim-obsession)
* [vim-rails](https://github.com/tpope/vim-rails)
* [vim-rhubarb](https://github.com/tpope/vim-rhubarb)
* [vim-ripgrep](https://github.com/jremmen/vim-ripgrep)
* [vim-solarized8](https://github.com/lifepillar/vim-solarized8)
