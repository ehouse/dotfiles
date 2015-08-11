SSH_KEY=$(HOME)/.ssh/id_rsa
all: clean zsh vim tmux ssh

vim:
	@ln -sf $(HOME)/dotfiles/vim/vimrc $(HOME)/.vimrc
	@ln -sf $(HOME)/dotfiles/vim/vim $(HOME)/.vim
	@mkdir -p $(HOME)/dotfiles/vim/bundle
	@git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/dotfiles/vim/vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
	@echo symlinked .vim

zsh: 
	@git clone --recursive https://github.com/sorin-ionescu/prezto.git "$(HOME)/.zprezto"
	@ln -sf $(HOME)/.zprezto/runcoms/zlogin $(HOME)/.zlogin
	@ln -sf $(HOME)/.zprezto/runcoms/zlogout $(HOME)/.zlogout
	@ln -sf $(HOME)/.zprezto/runcoms/zpreztorc $(HOME)/.zpreztorc
	@ln -sf $(HOME)/.zprezto/runcoms/zprofile $(HOME)/.zprofile
	@ln -sf $(HOME)/.zprezto/runcoms/zshenv $(HOME)/.zshenv
	@ln -sf $(HOME)/dotfiles/zsh/zshrc $(HOME)/.zshrc
	@echo symlinked .zshrc

tmux: 
	@ln -sf $(HOME)/dotfiles/tmux/tmux.conf $(HOME)/.tmux.conf
	@echo symlinked .tmux

ssh:
	@mkdir -p $(HOME)/.ssh
	@ln -sf $(HOME)/dotfiles/ssh/config $(HOME)/.ssh/config
	@echo SSH config setup
	@if [ ! -f $(SSH_KEY) ]; then ssh-keygen && echo "SSH key generated"; fi

i3: 
	@mkdir -p $(HOME)/.i3
	@ln -sf $(HOME)/dotfiles/i3/config $(HOME)/.i3/config
	@echo symlinked .i3

mutt:
	@ln -sf $(HOME)/dotfiles/mutt/muttrc $(HOME)/.muttrc
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

.PHONY: vim zsh tmux clean purge i3 ssh mutt emacs
