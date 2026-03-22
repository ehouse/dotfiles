dotfiles
========

Personal dotfiles and system bootstrap scripts for macOS and RedHat-based Linux.

Setup
-----

```sh
./install.sh <command>
```

**Bundles**

| Command | Description |
|---------|-------------|
| `dev` | Full setup: Homebrew (macOS), git, vim, zsh, tmux, SSH |
| `dev-vm` | Minimal setup for VMs: git, vim, SSH |

**Individual Tasks**

| Command | Description |
|---------|-------------|
| `brew` | Install Homebrew (macOS only) |
| `git` | Symlink gitconfig |
| `vim` | Symlink vimrc, install Vundle and plugins |
| `zsh` | Symlink zshrc |
| `tmux` | Symlink tmux.conf |
| `ssh` | Copy SSH config, generate key if missing |
| `mutt` | Symlink muttrc |

**Ansible**

| Command | Description |
|---------|-------------|
| `ansible-vm` | Run package install playbook for dev VMs |
| `ansible-laptop` | Run package install playbook for laptops |

**Utilities**

| Command | Description |
|---------|-------------|
| `clean` | Remove all symlinks and vim bundles |

What's Included
---------------

- **zsh** — prompt, completion, history, aliases, virtualenv support
- **vim** — Vundle plugin manager with gitgutter, NERDTree, tabular, vim-markdown
- **git** — aliases, colors, editor
- **tmux** — 256-color theme, scrollback history
- **ssh** — client config
- **mutt** — email client config
- **ansible** — package install playbooks for RedHat-based systems

Archived
--------

Configs that are no longer actively used but kept for reference are in `archived/`.
