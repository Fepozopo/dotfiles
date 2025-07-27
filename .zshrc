# ~/.zshrc

# Start profile zsh
# zmodload zsh/zprof

# Exports
export PATH=$PATH:$HOME/go/bin
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="$HOME/Developer/scripts:$PATH" # Export for custom scripts

# Source custom Zsh configurations
source "$HOME/.zsh/aliases.zsh"
source "$HOME/.zsh/keymap.zsh"
source "$HOME/.zsh/git.zsh" # This must happen before appearance.zsh
source "$HOME/.zsh/appearance.zsh"
source "$HOME/.zsh/completion.zsh" # This should happen last

# github.com/zdharma-continuum/fast-syntax-highlighting
source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# End profile zsh
# Run this command to time shell startup: time zsh -i -c exit
# zprof 
