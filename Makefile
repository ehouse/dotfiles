.PHONY: vim zsh tmux clean purge rzsh rvim rcurl rbash rstow rssh

all: clean zsh vim ssh tmux

vim: rstow rbash rvim
	stow -d $(HOME)/dotfiles vim
	curl -L http://j.mp/spf13-vim3 | sh

zsh: rcurl rstow rzsh
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	stow -d $(HOME)/dotfiles -t $(HOME)/.oh-my-zsh/custom zsh

tmux:
	stow -d $(HOME)/dotfiles tmux

ssh: rssh
	ssh-keygen

clean:
	rm -f $(HOME)/.tmux.conf
	rm -f $(HOME)/.vimrc.local
	rm -f $(HOME)/.oh-my-zsh/custom/override.zsh

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
