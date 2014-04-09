.PHONY: vim zsh tmux clean purge rzsh rvim rcurl rbash rssh i3
SSH_KEY=$(HOME)/.ssh/id_rsa

all: zsh vim

root: all

vim: rbash rvim
	@ln -sf $(HOME)/dotfiles/vim/vimrc $(HOME)/.vimrc
	@ln -sf $(HOME)/dotfiles/vim/vim $(HOME)/.vim
	@echo symlinked .vim

zsh: rcurl rzsh
	@ln -sf $(HOME)/dotfiles/zsh/zshrc $(HOME)/.zshrc

tmux: 
	@ln -sf tmux ../.tmux
	@echo symlinked .tmux

ssh: rssh
	@if [ ! -f $(SSH_KEY) ]; then ssh-keygen; fi

i3: 
	@mkdir -p $(HOME)/.i3
	@ln -sf $(HOME)/dotfiles/i3/config $(HOME)/.i3/config
	@echo symlinked .i3

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

rssh:
	@which ssh-keygen >/dev/null
