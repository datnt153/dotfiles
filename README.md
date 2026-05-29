# Datnt114's dotfiles

Dotfiles + Ansible automation cho workstation/dev machine.

## Quick Setup

```bash
# 1. Cài Ansible
sudo apt install -y ansible

# 2. Clone dotfiles
git clone https://github.com/datnt153/dotfiles.git ~/dotfiles

# 3. Chạy setup
cd ~/dotfiles/ansible && ansible-playbook playbooks/setup_workstation.yml --ask-become-pass
```

> Chi tiết: [docs/SERVER_SETUP.md](docs/SERVER_SETUP.md)

## Configs

| Config | Path | Mô tả |
|--------|------|--------|
| zsh | `.zshrc` | Antigen, p10k, fzf, aliases |
| tmux | `.tmux.conf` | Tokyo Night theme, TPM plugins |
| kitty | `.config/kitty/` | GPU terminal emulator |
| alacritty | `.config/alacritty/` | Terminal emulator |
| Claude Code | `.claude/` | Settings, hooks, CLAUDE.md |
| Amp | `.config/amp/` | AI coding assistant |
| Factory | `.factory/` | Droid AI assistant |

## AI Tools — Co-author Disabled

Tất cả AI tools đều tắt co-author trong commit messages:

- **Claude Code**: `CLAUDE.md` → `Dont have co-auth`
- **Amp**: `"amp.git.commit.coauthor.enabled": false`
- **Factory**: `"includeCoAuthoredByDroid": false`

## Ansible Roles

| Role | Packages |
|------|----------|
| common | curl, wget, htop, tree, ncdu, duf, rsync, zip, unzip, neofetch, stow, jq, dust |
| dev_tools | git, gh (GitHub CLI), zsh, tmux, neovim, python3, uv, TPM, antigen, build-essential, postgresql-client (psql) |
| docker | docker-ce, docker-ce-cli, containerd.io, docker-buildx-plugin, docker-compose-plugin (+ thêm user vào group `docker`) |
| media_tools | ffmpeg |
| dotfiles | Clone repo + `stow --adopt .` |

## Requirements

- Ubuntu/Debian
- [Nerd Font](https://www.nerdfonts.com/font-downloads) (cho icons)

## Manual Stow (không dùng Ansible)

```bash
cd ~/dotfiles && stow .
```

## Reference

- [nikolovlazar dotfiles](https://github.com/nikolovlazar/dotfiles/)
- [tokyo-night-tmux](https://github.com/janoamaral/tokyo-night-tmux)
