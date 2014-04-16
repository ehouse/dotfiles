SSH_KEY=$(HOME)/.ssh/id_rsa
all: zsh vim tmux ssh

vim:
	@ln -sf $(HOME)/dotfiles/vim/vimrc $(HOME)/.vimrc
	@ln -sf $(HOME)/dotfiles/vim/vim $(HOME)/.vim
	@echo symlinked .vim

zsh: 
	@git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 
	@ln -sf $(HOME)/dotfiles/zsh/zshrc $(HOME)/.zshrc
	@echo installed oh-my-zsh
	@echo symlinked .zshrc

tmux: 
	@ln -sf tmux ../.tmux
	@echo symlinked .tmux

ssh:
	@if [ ! -f $(SSH_KEY) ]; then ssh-keygen; fi

i3: 
	@mkdir -p $(HOME)/.i3
	@ln -sf $(HOME)/dotfiles/i3/config $(HOME)/.i3/config
	@echo symlinked .i3

clean:
	rm -f $(HOME)/.tmux.conf
	rm -rf $(HOME)/.i3
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.zshrc

purge: clean
	rm -rf $(HOME)/.vim*
	rm -rf $(HOME)/.oh-my-zsh*
	rm -rf $(HOME)/.zsh*

.PHONY: vim zsh tmux clean purge i3
