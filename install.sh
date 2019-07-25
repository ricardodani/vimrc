#!/bin/sh

if [ -f ~/.vim/bundle ]; then
    echo "Creating plugin directory..."
    mkdir -p ~/.vim/bundle
fi

if [ ! -d ~/.vim/bundle/Vundle.vim  ]; then
    echo "Installing vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ -d ~/.vimrc.backup ]; then
    echo "Creating backup folder..."
    mkdir -p ~/.vimrc.backup
fi

if [ -f ~/.vimrc ]; then
    echo "Backing up old vim configuration..."
    mv ~/.vimrc ~/.vimrc.backup/
fi

if [ -f ~/.vimrc.bundles ]; then
    echo "Backing up old plugins configuration ..."
    mv ~/.vimrc.bundles ~/.vimrc.backup/
fi

echo "Installing .vimrc and .vimrc.bundles..."
ln -Trsf vimrc ~/.vimrc
ln -Trsf vimrc.bundles ~/.vimrc.bundles

echo "Installing vundle plugins..."
vim +PluginInstall +qall

echo "*** Installation succeded! =) ***"
echo "Vim configuration located at ~/.vimrc, plugin configuration located at ~/.vimrc.bundles."
echo "Last backup located at ~/.vimrc.backup"
