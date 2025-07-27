# Add shortcuts for dotfiles bare repo
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dfs="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME status"
alias dfa="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add"
alias dfau="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add -u"  # stages modified and deleted files only, NOT new files
alias dfc="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit"
alias dfcm="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -m"

# Automatically add the verbose flag to commands
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"

# Aliases for ls
alias ls="lsd"
alias lsa="lsd -a"
alias lst="lsd --tree"
alias lsta="lsd -a --tree"
alias lsl="lsd -l"
alias lsla="lsd -la"

# Alias to default Visual Studio Code Insiders
alias code="code-insiders"

# Alias to shorten python3 to python
alias python="python3"

# Alias to make it easier to create/activate/deactivate a Python virtual environment
alias venv-c="python3 -m venv venv"
alias venv-a="source venv/bin/activate"
alias venv-d="deactivate"

# Alias to simplify use of UV
uv-c() {
	uv init
	uv venv
}
alias uv-a="source .venv/bin/activate"
alias uv-d="deactivate"

# Alias for common git commands
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gcm="git commit -m"
alias gl="git log --oneline --graph --decorate"

