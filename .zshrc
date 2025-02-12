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

# Source local environment variables
# Example: API_KEY (will be available if set in ~/.env or ~/.env.hostname)
# echo "API_KEY is $API_KEY"
#
if [ -f ~/.env ]; then
    export $(grep -v '^#' ~/.env | xargs)
fi

export PATH="$HOME/.local/bin:$HOME/.dotnet/tools:$HOME/.local/share/bob/nvim-bin:$HOME/.pulumi/bin:$PATH"

# Define aliases.
alias tree='tree -a -I .git'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias nv='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# starship
eval "$(starship init zsh)"

fastfetch

# Load Angular CLI autocompletion.
source <(ng completion script)
