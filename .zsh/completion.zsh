# ~/.zsh/completion.zsh

# ____ ___  __  __ ____  _      _____ _____ ___ ___  _   _
# / ___/ _ \|  \/  | _ \| |    | ____|_  __| _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |    |  _|    | |  | | | | |  \| |
# | |__| |_| | |  | | __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

# +---------+
# | General |
# +---------+

# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

# --- IMPORTANT: Run compinit BEFORE setting options and zstyles ---
# Autoload and initialize completion system
autoload -Uz +X compinit && compinit

# +---------+
# | Options |
# +---------+

# These options should generally be set AFTER compinit has initialized
# the completion system, but before specific zstyles that might rely
# on or interact with these fundamental behaviors.
setopt GLOB_COMPLETE          # Show autocompletion menu with globs
setopt MENU_COMPLETE          # Automatically highlight first element of completion menu
setopt AUTO_LIST              # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD       # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort name 

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Flexible and forgiving tab completion experience
zstyle ':completion:*' keep-prefix true
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
