# Case insensitive completion
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Vim keybindings
bindkey -v

# Wait only 0.01 seconds for the rest of a key sequence
export KEYTIMEOUT=1

