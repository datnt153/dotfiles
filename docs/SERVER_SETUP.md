# Server & Workstation Setup Guide

Hướng dẫn chi tiết cho AI assistant follow step-by-step khi setup máy mới.

---

## Part 1 — Setup workstation mới (không cần SSH key)

Dùng cho máy hoàn toàn mới, chưa có SSH key, chưa có gì cả.

### Bước 1: Cài Ansible

```bash
sudo apt update && sudo apt install -y ansible
```

### Bước 2: Clone dotfiles qua HTTPS

```bash
git clone https://github.com/datnt153/dotfiles.git ~/dotfiles
```

> HTTPS không cần SSH key — phù hợp cho máy mới.

### Bước 3: Chạy Ansible playbook

```bash
cd ~/dotfiles/ansible && ansible-playbook playbooks/setup_workstation.yml --ask-become-pass
```

Playbook sẽ chạy theo thứ tự:
1. **common** — cài apt packages (curl, wget, htop, stow, jq...)
2. **dev_tools** — cài git, zsh, tmux, neovim, uv, TPM, antigen, tạo SSH key
3. **media_tools** — cài ffmpeg
4. **dotfiles** — clone dotfiles repo + chạy `stow --adopt .` để tạo symlinks

### Bước 4: Mở zsh mới

```bash
exec zsh
```

> Antigen sẽ tự download plugins lần đầu — có thể mất 1-2 phút.

### Bước 5: Add SSH key lên GitHub

SSH public key đã hiện trong output Ansible ở bước 3. Copy và add vào:
- https://github.com/settings/keys

### Bước 6: Đổi remote sang SSH

```bash
cd ~/dotfiles && git remote set-url origin git@github.com:datnt153/dotfiles.git
```

### Bước 7: Tạo `~/.zshrc.local` cho secrets

```bash
cat > ~/.zshrc.local << 'EOF'
# Secrets — KHÔNG commit vào dotfiles
export WANDB_API_KEY=xxx
export ANTHROPIC_API_KEY=xxx
# Thêm các biến môi trường riêng khác ở đây
EOF
```

> File này đã được source trong `.zshrc` (dòng `[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"`).

---

## Part 2 — Setup SEO servers (từ workstation đã setup)

Dùng repo riêng `yt-seo-deploy`, KHÔNG dùng dotfiles repo này.

### Yêu cầu

- SSH key `datnt-hgmedia`: `~/.ssh/id_ed25519_datnt-hgmedia`
- SSH config đã setup để dùng key này cho GitHub hgmedia

### Bước 1: Clone yt-seo-deploy

```bash
git clone git@github-hgmedia:hgai-team/yt-seo-deploy.git ~/yt-seo-deploy
```

### Bước 2: Setup software trên servers

```bash
cd ~/yt-seo-deploy/ansible && ansible-playbook -i inventory/hosts.yml playbooks/setup_software.yml
```

### Bước 3: Sync code lên servers

```bash
cd ~/yt-seo-deploy/ansible && ansible-playbook -i inventory/hosts.yml playbooks/sync_code.yml
```

---

## Part 3 — AI Tools

Configs cho AI tools đã có sẵn trong dotfiles, sẽ được symlink tự động qua Stow.

### Claude Code

- Config: `~/.claude/CLAUDE.md`, `~/.claude/settings.json`
- Hook script: `~/.claude/scripts/validate-bash.sh`
- **Co-author: disabled** — trong `CLAUDE.md`: `Dont have co-auth`

Cài Claude Code:
```bash
npm install -g @anthropic-ai/claude-code
```

### Amp

- Config: `~/.config/amp/settings.json`
- **Co-author: disabled** — `"amp.git.commit.coauthor.enabled": false`

Cài Amp:
```bash
curl -fsSL https://ampcode.com/install.sh | bash
```

### Factory (Droid)

- Config: `~/.factory/settings.json`
- **Co-author: disabled** — `"includeCoAuthoredByDroid": false`

Cài Factory theo hướng dẫn tại https://factory.ai

---

## Troubleshooting

### Stow conflicts

Nếu `stow` báo conflict (file đã tồn tại và không phải symlink):

```bash
# Xem conflict
cd ~/dotfiles && stow -n -v .

# Dùng --adopt để adopt file hiện tại vào dotfiles
cd ~/dotfiles && stow --adopt .

# Hoặc backup thủ công rồi stow lại
mv ~/.zshrc ~/.zshrc.backup
cd ~/dotfiles && stow .
```

### SSH key không được tạo

Nếu Ansible skip bước SSH key (đã tồn tại):
```bash
cat ~/.ssh/id_ed25519.pub
```

### Antigen loading chậm lần đầu

Lần đầu mở zsh, antigen phải download tất cả plugins. Đợi 1-2 phút. Các lần sau sẽ nhanh hơn.

### TPM plugins chưa cài

Trong tmux, nhấn `prefix + I` (Ctrl-b + I) để cài plugins.
