SSH_KEY=$(HOME)/.ssh/id_rsa
all: zsh vim tmux ssh mutt

vim:
	@ln -sf $(HOME)/dotfiles/vim/vimrc $(HOME)/.vimrc
	@ln -sf $(HOME)/dotfiles/vim/vim $(HOME)/.vim
	@mkdir -p $(HOME)/dotfiles/vim/bundle
	@git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/dotfiles/vim/vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
	@echo symlinked .vim

zsh: 
	@git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 
	@ln -sf $(HOME)/dotfiles/zsh/zshrc $(HOME)/.zshrc
	@echo installed oh-my-zsh
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

clean:
	rm -f $(HOME)/.tmux.conf
	rm -rf $(HOME)/.i3
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.zshrc

purge: clean
	rm -rf $(HOME)/.vim*
	rm -rf $(HOME)/.oh-my-zsh*
	rm -rf $(HOME)/.zsh*
	rm -rf $(HOME)/dotfiles/vim/vim/bundle

.PHONY: vim zsh tmux clean purge i3 ssh mutt
