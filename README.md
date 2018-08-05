# vim setup

## requirements
* Vim 8+ with scripting support (vim-nox on debian)
* Node.js

## install pathogen

use pathogen for installing plugins and runtime files.
```
mkdir -p ~/.vim/autoload ~/.vim/backup ~/.vim/bundle
git clone https://github.com/tpope/vim-pathogen.git
cp vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/
```

## install dotfiles
```
cp .vimrc ~
cp .ctags ~
```

## install vim plugins
```
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized &&
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree &&
git clone https://github.com/vim-scripts/bufexplorer.zip.git ~/.vim/bundle/bufexplorer.zip &&
git clone https://github.com/rbgrouleff/bclose.vim.git ~/.vim/bundle/bclose.vim &&
git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale &&
git clone https://github.com/junegunn/fzf.vim ~/.vim/bundle/fzf.vim &&
git clone https://github.com/tpope/vim-commentary.git ~/.vim/bundle/vim-commentary &&
git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript &&
git clone https://github.com/mxw/vim-jsx.git ~/.vim/bundle/vim-jsx &&
git clone https://github.com/ajh17/VimCompletesMe.git ~/.vim/bundle/VimCompletesMe &&
git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/bundle/vim-gutentags &&
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
```

## ale linting support
Ale is an asynchronous linting engine.

Install eslint in your local project (or globally)
and setup a default eslint config for ale to use
```
npm install eslint --save-dev
eslint --init
```

it also supports prettier!

Install prettier-eslint in your project (or globally)
```
npm install prettier-eslint --save-dev
```

## fzf
fzf is a command-line fuzzy finder. 
It is a replacement for ctrl+p.

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

use ripgrep for searching since it supports ignoring directories (node_modules)
```
# osx
brew install ripgrep
```

then add the following to ~/.fzf.bash or ~/.fzf.zsh
```
# set fzf source to ripgrep and ignore some dirs
# see https://github.com/junegunn/fzf#respecting-gitignore
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,coverage}/*" 2> /dev/null'
```

## ctags
```
#osx
brew install ctags --HEAD
```

## remap capslock
To map capslock to ctrl, add this to .bashrc
```
#debian
setxkbmap -layout us -option ctrl:nocaps

```

## key mappings
```
'jj'      leave insert mode (same as esc)
'v'       leave visual mode
'esc+esc' no highlight
'\s'      save
'ctrl+d'  scroll down 
'ctrl+e'  scroll down 1/4 page
'ctrl+u'  scroll up 
'ctrl+y'  scroll up 1/4 page 
```

### bufexplorer key mappings
```
'\be'     open buffer explorer (normal)
'\bs'     open buffer explorer (horiz split)
'\bv'     open buffer explorer (vert split)
'\bf'     buffer forward
'\bb'     buffer backwards
'\bc'     buffer close
```

### nerdtree key mappings
```
'\n'      toggle nerdtree
```

### fzf key mappings
```
'\ff'     fuzzy find files
'\fc'     fuzzy find git commits
```

# resources
* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
* [nerdtree](https://github.com/scrooloose/nerdtree)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [bclose](https://github.com/rbgrouleff/bclose.vim)
* [ale](https://github.com/w0rp/ale)
* [fzf](https://github.com/junegunn/fzf)
* [fzf.vim](https://github.com/junegunn/fzf.vim)
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-jsx](https://github.com/mxw/vim-jsx)
* [vimcompletesme](https://github.com/ajh17/VimCompletesMe)
* [ctags-patterns-for-javascript](https://github.com/romainl/ctags-patterns-for-javascript)

