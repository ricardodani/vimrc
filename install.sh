mkdir -p ~/.vimrc.backup

if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.backup/
fi

if [ -f ~/.vimrc.bundles ]; then
	mv ~/.vimrc.bundles ~/.vimrc.backup/
fi

ln -Trsf vimrc ~/.vimrc
ln -Trsf vimrc.bundles ~/.vimrc.bundles

echo "Versioned .vimrc linked successfully. Backup was made on ~/.vimrc.backup"
