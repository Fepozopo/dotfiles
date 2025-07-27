# ~/.zshrc

# Source custom Zsh configurations
if [ -d "$HOME/.zsh" ]; then
  # Source aliases
  if [ -f "$HOME/.zsh/aliases.zsh" ]; then
    source "$HOME/.zsh/aliases.zsh"
  fi

  # Source settings 
  if [ -f "$HOME/.zsh/settings.zsh" ]; then
    source "$HOME/.zsh/settings.zsh"
  fi

  # Source functions (This must happen before appearance.zsh)
  if [ -f "$HOME/.zsh/functions.zsh" ]; then
    source "$HOME/.zsh/functions.zsh"
  fi

  # Source appearance
  if [ -f "$HOME/.zsh/appearance.zsh" ]; then
    source "$HOME/.zsh/appearance.zsh"
  fi
fi

# Exports
export PATH=$PATH:$HOME/go/bin
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="$HOME/Developer/scripts:$PATH" # Export for custom scripts

