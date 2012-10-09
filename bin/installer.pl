#!/usr/bin/perl
use strict;
use warnings;

my $user = `whoami`;
my $zshloc = `which zsh`, my $zsherr = $?;
my $shell = `echo \$SHELL`;

print "This will remove your ~/.zshrc, ~/.zsh, ~/.vimrc, ~/.vim, and ~/.tmux.conf files.\nAre you Sure? (y/N) ";
die unless <STDIN> =~ m/[Yy]/;

if(!$zsherr){
	if($shell =~ m/zsh/){
		print "No Need to Change your Shell, Winner!\n"
	} else{
		print "Changing Shell to ZSH\n";
		system 'chsh $user -s $zshloc' or die;
	}
}
system 'rm ~/.vimrc ~/.vim ~/.zshrc ~/.zsh ~/dotfiles/zsh/zsh-syntax-highlighting/ ~/.tmux.conf -rf';
system 'ln -s ~/dotfiles/vim ~/.vim';
system 'ln -s ~/dotfiles/vim/vimrc ~/.vimrc';
system 'ln -s ~/dotfiles/zsh/zshrc ~/.zshrc';
system 'ln -s ~/dotfiles/zsh ~/.zsh';
system 'ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf';
system 'git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle';
system 'git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh/zsh-syntax-highlighting';
system 'ln -s ~/dotfiles/zsh/zsh-syntax-highlighting/ ~/.zsh-syntax-highlighting';

print "Setup Complete\n";
print "Please Restart Terminal for Changes to Take Effect\n";

### END OF FILE
