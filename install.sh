#!/bin/sh
set -e

DOTFILES="$HOME/dotfiles"
SSH_KEY="$HOME/.ssh/id_rsa"

# ── Helpers ────────────────────────────────────────────────────────────────────

info()  { printf '  \033[0;34m→\033[0m %s\n' "$1"; }
ok()    { printf '  \033[0;32m✓\033[0m %s\n' "$1"; }
err()   { printf '  \033[0;31m✗\033[0m %s\n' "$1" >&2; }
die()   { err "$1"; exit 1; }

symlink() {
    ln -sf "$1" "$2"
    ok "symlinked $(basename "$2")"
}

require() {
    command -v "$1" > /dev/null 2>&1 || die "$1 is required for this task"
}

# ── Tasks ──────────────────────────────────────────────────────────────────────

task_git() {
    info "Setting up git..."
    symlink "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
}

task_vim() {
    info "Setting up vim..."
    require vim
    symlink "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
    if [ ! -d "$HOME/.vim" ]; then
        symlink "$DOTFILES/vim/vim" "$HOME/.vim"
    fi
    mkdir -p "$DOTFILES/vim/vim/bundle"
    if [ ! -d "$DOTFILES/vim/vim/bundle/Vundle.vim" ]; then
        info "Cloning Vundle..."
        git clone https://github.com/VundleVim/Vundle.vim.git "$DOTFILES/vim/vim/bundle/Vundle.vim"
    fi
    vim +PluginInstall +qall
    ok "vim plugins installed"
}

task_zsh() {
    info "Setting up zsh..."
    symlink "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
}

task_tmux() {
    info "Setting up tmux..."
    symlink "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
}

task_ssh() {
    info "Setting up SSH..."
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    cp -f "$DOTFILES/ssh/config" "$HOME/.ssh/config"
    ok "SSH config copied"
    if [ ! -f "$SSH_KEY" ]; then
        ssh-keygen -t ed25519 -f "$SSH_KEY"
        ok "SSH key generated"
    fi
}

task_mutt() {
    info "Setting up mutt..."
    symlink "$DOTFILES/mutt/muttrc" "$HOME/.muttrc"
}

task_isync() {
    info "Setting up isync..."
    symlink "$DOTFILES/isync/mbsyncrc" "$HOME/.mbsyncrc"
    mkdir -p "$HOME/Mail/fastmail"
}

task_zed() {
    info "Setting up Zed..."
    mkdir -p "$HOME/.config/zed"
    symlink "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"
}

task_vdirsyncer() {
    info "Setting up vdirsyncer..."
    mkdir -p "$HOME/.vdirsyncer/status"
    mkdir -p "$HOME/.contacts/fastmail"
    mkdir -p "$HOME/.calendars/fastmail"
    symlink "$DOTFILES/vdirsyncer/config" "$HOME/.vdirsyncer/config"
    ok "run 'vdirsyncer discover' then 'vdirsyncer sync' to populate"
}

task_brew() {
    info "Setting up Homebrew..."
    if [ "$(uname)" != "Darwin" ]; then
        err "Homebrew is only supported on macOS — skipping"
        return
    fi
    if command -v brew > /dev/null 2>&1; then
        ok "Homebrew already installed"
        return
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ok "Homebrew installed"
}

task_ansible_vm() {
    info "Running Ansible for VM..."
    require ansible
    ansible-playbook -K -i "localhost," -c local "$DOTFILES/ansible/dev-vm.yml"
    ok "Ansible VM playbook complete"
}

task_ansible_laptop() {
    info "Running Ansible for laptop..."
    require ansible
    ansible-playbook -K -i "localhost," -c local "$DOTFILES/ansible/dev-laptop.yml"
    ok "Ansible laptop playbook complete"
}

task_clean() {
    info "Cleaning up symlinks and bundles..."
    rm -f "$HOME/.gitconfig" "$HOME/.vimrc" "$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.muttrc" "$HOME/.config/zed/settings.json"
    rm -rf "$HOME/.vim"
    rm -rf "$DOTFILES/vim/vim/bundle"
    ok "cleaned"
}

# ── Bundles ────────────────────────────────────────────────────────────────────

bundle_dev_vm() {
    task_git
    task_vim
    task_ssh
}

bundle_dev() {
    task_brew
    task_git
    task_vim
    task_zsh
    task_tmux
    task_ssh
    task_zed
}

bundle_mail() {
    info "Setting up mail..."
    if command -v brew > /dev/null 2>&1; then
        brew install isync vdirsyncer mutt
    fi
    task_mutt
    task_isync
    task_vdirsyncer
}

# ── Help & Dispatch ────────────────────────────────────────────────────────────

usage() {
    cat <<EOF

Usage: ./install.sh <command>

Bundles
  dev-vm          Git, vim, and SSH setup
  dev             Git, vim, zsh, tmux, SSH, and Zed setup
  mail            Install and configure mutt, isync, and vdirsyncer

Ansible
  ansible-vm      Run Ansible install playbook for dev VMs
  ansible-laptop  Run Ansible install playbook for laptops

Tasks
  brew            Install Homebrew (macOS only)
  git             Symlink gitconfig
  vim             Symlink vimrc, install Vundle and plugins
  zsh             Symlink zshrc
  tmux            Symlink tmux.conf
  ssh             Copy SSH config, generate key if missing
  zed             Symlink Zed settings.json

Mail
  mutt            Symlink muttrc
  isync           Symlink mbsyncrc, create mail directories
  vdirsyncer      Symlink vdirsyncer config, create contact/calendar directories

Utilities
  clean           Remove all symlinks and vim bundles

EOF
}

case "${1:-}" in
    dev-vm)         bundle_dev_vm ;;
    dev)            bundle_dev ;;
    mail)           bundle_mail ;;
    ansible-vm)     task_ansible_vm ;;
    ansible-laptop) task_ansible_laptop ;;
    brew)           task_brew ;;
    git)            task_git ;;
    vim)            task_vim ;;
    zsh)            task_zsh ;;
    tmux)           task_tmux ;;
    ssh)            task_ssh ;;
    mutt)           task_mutt ;;
    isync)          task_isync ;;
    vdirsyncer)     task_vdirsyncer ;;
    zed)            task_zed ;;
    clean)          task_clean ;;
    *)              usage ;;
esac
