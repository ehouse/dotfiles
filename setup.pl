#!/usr/bin/perl
use strict;
use warnings;

system("cd ~");

my $user = $ENV{'LOGNAME'};
my $homedir = $ENV{'HOME'};

system("git clone git://github.com/ehouse/dotfiles.git $homedir/dotfiles");
#system("curl http://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh");
system("curl -L http://j.mp/spf13-vim3 | sh");
system("curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh");

print("Ctr-C to cancle stow");
<>;

unlink("$homedir/.tmux.conf");
unlink("$homedir/.vimrc.local");
unlink("$homedir/.oh-my-zsh/custom/override.zsh");

# Trying out GNU Stow
system("stow -d dotfiles tmux");
system("stow -d dotfiles vim");
system("stow -d dotfiles -t .oh-my-zsh/custom/ zsh");

#system("ln -s $homedir/dotfiles/vim/vimrc.local $homedir/.vimrc.local");
#system("ln -s $homedir/dotfiles/zsh/override.zsh $homedir/.oh-my-zsh/custom/override.zsh");
