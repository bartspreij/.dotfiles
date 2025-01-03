if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec Hyprland >/dev/null 2>&1
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install



autoload -Uz +X compinit && compinit

## case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select


export PATH="$HOME/.local/bin:$HOME/.dotnet/tools:$HOME/.local/share/bob/nvim-bin:$HOME/.pulumi/bin:$PATH"
export DB_URL="postgres://postgres:postgres@localhost:5432/betterfeel"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

fastfetch

source /usr/share/nvm/init-nvm.sh

# Define aliases.
alias tree='tree -a -I .git'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias nv='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"


eval "$(starship init zsh)"
