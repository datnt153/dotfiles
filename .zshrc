# Ansible managed
# zsh version: 5.8.1
# antigen version: 

export TERM="xterm-256color"
export PATH="$PATH:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$HOME/.local/bin:$PATH"

# user configs
[[ -r "$HOME/.zshrc.local.pre-p10k" ]] && source "$HOME/.zshrc.local.pre-p10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HIST_STAMPS="yyyy-mm-dd"
UPDATE_ZSH_DAYS="30"
COMPLETION_WAITING_DOTS="true"

# ADOTDIR="$HOME/.antigen"

ANTIGEN_BUNDLES="$HOME/.antigen/bundles"
ANTIGEN_PLUGIN_UPDATE_DAYS="30"
ANTIGEN_SYSTEM_UPDATE_DAYS="30"




source "$HOME/.antigen/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle command-not-found
#antigen bundle brew
#antigen bundle docker
antigen bundle docker-compose
antigen bundle fancy-ctrl-z
antigen bundle git-extras
antigen bundle gnu-utils
antigen bundle httpie
antigen bundle golang
antigen bundle gulp
antigen bundle helm
#antigen bundle kubectl
antigen bundle pip
antigen bundle rake
antigen bundle symfony2
antigen bundle systemd
antigen bundle python
antigen bundle tmux
antigen bundle vagrant
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle popstas/zsh-command-time
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle urbainvaes/fzf-marks
antigen bundle ytet5uy4/fzf-widgets
antigen bundle agkozak/zsh-z
antigen bundle Aloxaf/fzf-tab
# will fixed in zsh-autosuggestion v0.4 - https://github.com/zsh-users/zsh-autosuggestions/pull/218
if (( ZSHRC_LOAD_ONCE++ == 0 )); then
    antigen bundle zdharma-continuum/fast-syntax-highlighting
fi

antigen theme romkatv/powerlevel10k powerlevel10k

antigen apply

###

#unsetopt share_history


autoload -Uz copy-earlier-word
zle -N copy-earlier-word

# hotkeys
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '^@' fzf-select-widget
bindkey '^@.' fzf-edit-dotfiles
bindkey '^@c' fzf-change-directory
bindkey '^@f' fzf-edit-files
bindkey '^@k' fzf-kill-processes
bindkey '^@s' fzf-exec-ssh
bindkey '^\' fzf-change-recent-directory
bindkey '^r' fzf-insert-history
bindkey '^xf' fzf-insert-files
bindkey '^xd' fzf-insert-directory
bindkey '^@g' fzf-select-git-widget
bindkey '^@ga' fzf-git-add-files
bindkey '^@gc' fzf-git-change-repository
bindkey '^@gco' fzf-git-checkout-branch
bindkey '^@gd' fzf-git-delete-branches
bindkey '^@gh' fzf-select-github-widget
bindkey '^@ghi' fzf-github-show-issue
bindkey '^@ghe' fzf-github-edit-issue
bindkey '^@gho' fzf-github-open-issue
bindkey '^@ghc' fzf-github-close-issue
bindkey '^@ghco' fzf-github-comment-issue
bindkey '^@d' fzf-select-docker-widget
bindkey '^@dk' fzf-docker-kill-containers
bindkey '^@dl' fzf-docker-logs-container
bindkey '^@dr' fzf-docker-remove-containers
bindkey '^@dri' fzf-docker-remove-images
bindkey '^@drv' fzf-docker-remove-volumes
bindkey '^@dsa' fzf-docker-start-containers
bindkey '^@dso' fzf-docker-stop-containers

# aliases
alias "apt-update-list-upgrade"="apt update && apt upgrade --dry-run | grep Inst | sort | fzf && apt upgrade"
alias "dfh"="df -h | grep -v docker"
alias "ubuntu-release"="lsb_release -a"

# fzf
export FZF_TMUX=0
export FZF_DEFAULT_OPTS="--height 100% --reverse"

# fzf-widgets: fzf-change-reset-dir
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
declare -p FZF_WIDGETS_OPTS > /dev/null 2>&1 && FZF_WIDGETS_OPTS[insert-history]="--exact"
declare -p FZF_WIDGET_OPTS > /dev/null 2>&1 && FZF_WIDGET_OPTS[insert-history]="--exact"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240" # gray highlight

# SOURCES

# EXPORT VARIABLES

# PATHS
source /etc/profile
source "$HOME/.rye/env"


# user configs
[[ -r /etc/zsh/zshrc.local ]] && source /etc/zsh/zshrc.local
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/hdd/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/hdd/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/hdd/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/hdd/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
#export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
#export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64/bin/java
#export PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Chia sẻ history giữa các phiên shell
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# Ghi lại lịch sử sau mỗi lệnh
#autoload -Uz add-zsh-hook
#add-zsh-hook preexec history -a

