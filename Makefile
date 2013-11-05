.PHONY: vim zsh tmux clean purge rzsh rvim rcurl rbash rstow rssh
SSH_KEY=$(HOME)/.ssh/id_rsa

all: clean zsh vim

root: all

vim: rstow rbash rvim
	stow -d $(HOME)/dotfiles vim

zsh: rcurl rstow rzsh
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
	stow -d $(HOME)/dotfiles -t $(HOME)/.oh-my-zsh/custom zsh

tmux: rstow
	stow -d $(HOME)/dotfiles tmux

ssh: rssh
	@if [ ! -f $(SSH_KEY) ]; then ssh-keygen; fi

i3: rstow
	stow -d $(HOME)/dotfiles i3

clean:
	rm -f $(HOME)/.tmux.conf
	rm -f $(HOME)/.vimrc.local
	rm -f $(HOME)/.vimrc.bundles.local
	rm -f $(HOME)/.oh-my-zsh/custom/override.zsh
	rm -rf $(HOME)/.i3*

purge: clean
	rm -rf $(HOME)/.vim*
	rm -rf $(HOME)/.oh-my-zsh*
	rm -rf $(HOME)/.zsh*
	rm -rf $(HOME)/.spf13-vim-3*

### Check Dependencies Requirement
rzsh:
	@which zsh >/dev/null

rvim:
	@which vim >/dev/null

rcurl:
	@which curl >/dev/null

rbash:
	@which bash >/dev/null

rstow:
	@which stow >/dev/null

rssh:
	@which ssh-keygen >/dev/null
