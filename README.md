# my vim config stuff
fwiw, this is what I use

## plugins:
* [ack.vim](https://github.com/mileszs/ack.vim)
* [bufclose](https://github.com/rbgrouleff/bclose.vim)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [ctrlp](https://github.com/kien/ctrlp.vim)
* [DrawIt](https://github.com/vim-scripts/DrawIt)
* [javascript-libraries-syntax](https://github.com/othree/javascript-libraries-syntax.vim)
* [nerdtree](https://github.com/scrooloose/nerdtree)
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [pathogen](https://github.com/tpope/vim-pathogen)
* [python-mode](https://github.com/klen/python-mode)
* [showmarks](https://github.com/vim-scripts/ShowMarks)
* [supertab](https://github.com/ervandew/supertab)
* [syntastic](https://github.com/scrooloose/syntastic)
* [tern for vim](https://github.com/marijnh/tern_for_vim)
* [vim-less](https://github.com/genoma/vim-less)
* [vim-json](https://github.com/elzr/vim-json)
* [vim-sensible](https://github.com/tpope/vim-sensible)
* [vim-snippets](https://github.com/honza/vim-snippets)
* [yajs](https://github.com/othree/yajs.vim)
* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

## also
* [large file support](http://vim.wikia.com/wiki/Faster_loading_of_large_files)

## requirements
A newer version of node.js (>=12.x).

## installation
```shell
git clone https://github.com/mattpage/vimfiles.git
cd vimfiles
cp -r .vim ~
cp .vimrc ~
cp .ackrc ~
cp .eslintrc ~
cp .jshint_config ~
```

for syntastic's eslint support:
```shell
$ npm install eslint eslint-plugin-react babel-eslint -g
```

for YouCompleteMe and tern_for_vim
```
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
brew install cmake
./install.sh
cd ..
cd tern_for_vim
npm install
```

## post-install
run macvim and then :Helptags
