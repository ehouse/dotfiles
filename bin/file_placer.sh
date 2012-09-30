#!/bin/bash

# Written By Ethan House
# Last modified 3/17/2012

if [ -e /bin/zsh ]; then
	if [ "$SHELL" != "/bin/zsh" ];then
		chsh $(whoami) -s /bin/zsh
	elif [ "$SHELL" == "/bin/zsh" ];then
		echo "\$Shell = /bin/zsh. No changing required"
	else
		echo "Error Changing Shell"
	fi
	printf "Do you want to continue? This will erase ALOT of files in your home directory [y/N] "
	read response
	case $response in
		[yY] )
			rm ~/.vimrc -rf
			rm ~/.vim -rf
			rm ~/.zshrc -rf
			rm ~/.zsh -rf
			rm ~/.zsh-syntax-highlighting -rf
			rm ~/dotfiles/zsh/zsh-syntax-highlighting/ -rf
			rm ~/.vim/bundle/* -rf
			rm ~/.tmux.conf -rf

			ln -s ~/dotfiles/vim ~/.vim
			ln -s ~/dotfiles/vim/vimrc ~/.vimrc
			ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
			ln -s ~/dotfiles/zsh ~/.zsh
			ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
			git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
			git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh/zsh-syntax-highlighting
			ln -s ~/dotfiles/zsh/zsh-syntax-highlighting/ ~/.zsh-syntax-highlighting
			echo
			echo " Done Setting up files"
			echo " Due to a stupid issue please restard all terminals to use new rc files"
			echo " If the Prompt still isn't pretty try a full system restart"
			echo
			echo " All bug reports should be sent to /dev/null"
			echo
			;;
		*)
			echo "Canceling file replacement"
			exit
			;;
	esac
else
	echo "ERROR: zsh not found"
fi

