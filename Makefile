SSH_KEY=$(HOME)/.ssh/id_rsa
all: help

### Macros for collections of tasks

dev-vm: git vim ssh

.PHONY: dev-vm

dev: git vim zsh tmux ssh

.PHONY: dev

ansible-vm:
	@if [ $(shell command -v ansible &> /dev/null; echo $$?) -eq 1 ]; then echo "Error: Ansible required to run this task" && exit 1; fi
	@ansible-playbook -K -i "localhost," -c local $(HOME)/dotfiles/ansible/dev-vm.yml

.PHONY: ansible-vm

ansible-laptop:
	@if [ $(shell command -v ansible &> /dev/null; echo $$?) -eq 1 ]; then echo "Error: Ansible required to run this task" && exit 1; fi
	@ansible-playbook -K -i "localhost," -c local $(HOME)/dotfiles/ansible/dev-laptop.yml

.PHONY: ansible-laptop

### Individual config tasks

git:
	ln -sf $(HOME)/dotfiles/git/gitconfig $(HOME)/.gitconfig

.PHONY: git

vim:
	@if [ $(shell command -v vim &> /dev/null; echo $$?) -eq 1 ]; then echo "Error: Vim required to run this task" && exit 1; fi
	ln -sf $(HOME)/dotfiles/vim/vimrc $(HOME)/.vimrc
	if [ ! -f $(HOME)/.vim ]; then ln -sf $(HOME)/dotfiles/vim/vim $(HOME)/.vim; fi
	@mkdir -p $(HOME)/dotfiles/vim/bundle
	@if [ ! -d $(HOME)/dotfiles/vim/vim/bundle/Vundle.vim ]; then git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/dotfiles/vim/vim/bundle/Vundle.vim; fi
	vim +PluginInstall +qall
	@echo symlinked .vim

.PHONY: vim

zsh:
	ln -sf $(HOME)/dotfiles/zsh/zshrc $(HOME)/.zshrc
	@echo symlinked .zshrc

.PHONY: zsh

tmux:
	ln -sf $(HOME)/dotfiles/tmux/tmux.conf $(HOME)/.tmux.conf
	@echo symlinked .tmux

.PHONY: tmux

ssh:
	@mkdir -p $(HOME)/.ssh
	cp -f $(HOME)/dotfiles/ssh/config $(HOME)/.ssh/config
	@echo SSH config setup
	@if [ ! -f $(SSH_KEY) ]; then ssh-keygen && echo "SSH key generated"; fi

.PHONY: ssh

i3:
	@mkdir -p $(HOME)/.i3
	ln -sf $(HOME)/dotfiles/i3/config $(HOME)/.i3/config
	@echo symlinked .i3

.PHONY: i3

mutt:
	ln -sf $(HOME)/dotfiles/mutt/muttrc $(HOME)/.muttrc
	@echo symlinked .emacs

.PHONY: mutt

help:
	@echo
	@echo "Macros"
	@echo "  dev-vm :: Run through git, vim, and SSH setup"
	@echo "  dev    :: Run through git, vim, zsh, tmux and SSH setup"
	@echo
	@echo "Ansible"
	@echo "  ansible-vm     :: Run Ansible Install Script dev VM's"
	@echo "  ansible-laptop :: Run Ansible Install Script for laptops"
	@echo
	@echo "Tasks"
	@echo "  git    :: Run Ansible Install Script"
	@echo "  vim    :: Run through git, vim, zsh, tmux and SSH setup"
	@echo "  zsh    :: Run Ansible Install Script"
	@echo "  tmux   :: Run through git, vim, zsh, tmux and SSH setup"
	@echo "  ssh    :: Run through git, vim, zsh, tmux and SSH setup"
	@echo "  i3     :: Run through git, vim, zsh, tmux and SSH setup"
	@echo "  mutt   :: Run through git, vim, zsh, tmux and SSH setup"

.PHONY: help

clean:
	rm -f $(HOME)/.tmux.conf
	rm -rf $(HOME)/.i3
	rm -f $(HOME)/.emacs
	rm -rf $(HOME)/.vim*
	rm -rf $(HOME)/.oh-my-zsh*
	rm -rf $(HOME)/.z*
	rm -rf $(HOME)/dotfiles/.zgen
	rm -rf $(HOME)/dotfiles/vim/vim/bundle

.PHONY: clean
