#!/bin/sh

if [ -f ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
fi
echo "Installing vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mkdir -p ~/.vimrc.backup

if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.backup/
fi

if [ -f ~/.vimrc.bundles ]; then
	mv ~/.vimrc.bundles ~/.vimrc.backup/
fi

ln -Trsf vimrc ~/.vimrc
ln -Trsf vimrc.bundles ~/.vimrc.bundles

echo "Installing vundle plugins"

vim +PluginInstall +qall

echo "Versioned .vimrc linked successfully. Backup was made on ~/.vimrc.backup."
