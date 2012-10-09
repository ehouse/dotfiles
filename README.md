###Written By [Ross Guarno](https://github.com/rosslg)
Installer written by [Ethan House](https://github.com/ehouse)<br />
Includes various files<br />
includes vimrc, zshrc, tmux.conf and install script

###Setup

run the install script<br />
`./bin/installer.pl`<br />
This creates soft links to the correct files in dotfiles folder<br />
If you need a custom zsh location run `chsh` before you run the installer<br />

##Setup Vim
The vim Configuration uses [vundle](https://github.com/gmarik/vundle)<br />
To install bundles:<br />
Start vim<br />
run :BundleInstall<br />
Installing requires [Git](http://git-scm.com) and triggers [Git clone](http://gitref.org/creating/#clone)<br />

###Update
To update run `git pull` form the dotfiles directory<br />
You will need to restart Terminal for the changes to take effect<br />
