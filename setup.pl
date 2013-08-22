#!/usr/bin/perl
use strict;
use warnings;

my $user = $ENV{'LOGNAME'};
my $homedir = $ENV{'HOME'};

system("git clone git://github.com/ehouse/dotfiles.git $homedir/dotfiles");
system("curl http://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh");
system("curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh");

system("ln -s $homedir/dotfiles/vim/vimrc.local $homedir/.vimrc.local");
system("ln -s $homedir/dotfiles/zsh/override.zsh $homedir/.oh-my-zsh/custom/override.zsh");

