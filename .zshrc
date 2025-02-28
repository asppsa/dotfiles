# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# Setup completion
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

autoload -U bashcompinit
bashcompinit

# Add ARM homebrew to path if it exists
if [ -d /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

if ! zgenom saved; then
  echo "Creating a zgenom save"

  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-completions

  # save all to init script
  zgenom save

  # Compile your zsh files
  zgenom compile "$HOME/.zshrc"
fi

# editor
export EDITOR=`which nvim`
alias vi=`which nvim`

# ls
alias ls='ls --color=auto'

# Make word boundary like in bash
autoload -U select-word-style
select-word-style bash
export WORDCHARS=""

if [ $(uname -s) = 'Darwin' ] && [ -z "$NVIM" ]; then
  # Allow alt-arrow to work like Emacs
  bindkey '^[^[[D' backward-word
  bindkey '^[^[[C' forward-word

  # Allow alt- up and down to do a history search
  bindkey "^[^[[A" history-beginning-search-backward
  bindkey "^[^[[B" history-beginning-search-forward
else
  bindkey '^[[1;3C' forward-word
  bindkey '^[[1;3D' backward-word

  # Allow alt- up and down to do a history search
  bindkey '^[[1;3A' history-beginning-search-backward
  bindkey '^[[1;3B' history-beginning-search-forward
fi

# Load work config, if exists
if [ -f "$HOME/.work.zsh" ]; then
  source "$HOME/.work.zsh"
fi

# Prompt - use starship if installed
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  zgenom load spaceship-prompt/spaceship-prompt
fi

# Direnv, if installed
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi
