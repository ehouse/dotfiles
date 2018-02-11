SSH_KEY=$(HOME)/.ssh/id_rsa
all: git vim zsh tmux ssh

dev-vm:
	@if [ $(shell command -v ansible &> /dev/null; echo $$?) -eq 1 ]; then echo "Error: Ansible required to run this task" && exit 1; fi
	@ansible-playbook -K -i "localhost," -c local $(HOME)/dotfiles/ansible/dev-vm.yml

git:
	ln -sf $(HOME)/dotfiles/git/gitconfig $(HOME)/.gitconfig

vim:
	@if [ $(shell command -v vim &> /dev/null; echo $$?) -eq 1 ]; then echo "Error: Vim required to run this task" && exit 1; fi
	ln -sf $(HOME)/dotfiles/vim/vimrc $(HOME)/.vimrc
	if [ -f $(HOME)/.vim ]; then ln -sf $(HOME)/dotfiles/vim/vim $(HOME)/.vim; fi
	@mkdir -p $(HOME)/dotfiles/vim/bundle
	@if [ ! -d $(HOME)/dotfiles/vim/vim/bundle/Vundle.vim ]; then git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/dotfiles/vim/vim/bundle/Vundle.vim; fi
	vim +PluginInstall +qall
	@echo symlinked .vim

zsh:
	ln -sf $(HOME)/dotfiles/zsh/zshrc $(HOME)/.zshrc
	@echo symlinked .zshrc

tmux:
	ln -sf $(HOME)/dotfiles/tmux/tmux.conf $(HOME)/.tmux.conf
	@echo symlinked .tmux

ssh:
	@mkdir -p $(HOME)/.ssh
	cp -f $(HOME)/dotfiles/ssh/config $(HOME)/.ssh/config
	@echo SSH config setup
	@if [ ! -f $(SSH_KEY) ]; then ssh-keygen && echo "SSH key generated"; fi

i3:
	@mkdir -p $(HOME)/.i3
	ln -sf $(HOME)/dotfiles/i3/config $(HOME)/.i3/config
	@echo symlinked .i3

mutt:
	ln -sf $(HOME)/dotfiles/mutt/muttrc $(HOME)/.muttrc
	@echo symlinked .emacs

clean: 
	rm -f $(HOME)/.tmux.conf
	rm -rf $(HOME)/.i3
	rm -f $(HOME)/.emacs
	rm -rf $(HOME)/.vim*
	rm -rf $(HOME)/.oh-my-zsh*
	rm -rf $(HOME)/.z*
	rm -rf $(HOME)/dotfiles/.zgen
	rm -rf $(HOME)/dotfiles/vim/vim/bundle

.PHONY: dev-vm dev-host git vim zsh tmux clean purge i3 ssh mutt emacs
