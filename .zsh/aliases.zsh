# Add shortcuts for dotfiles bare repo
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dfs="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME status"
alias dfa="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add"
alias dfc="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit"
alias dfpom="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME push origin main"

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

# Navigation aliases
alias hm="cd ~"
alias dl="cd ~/Downloads"
mygit() {
  cd ~/Developer/workspace/github.com/Fepozopo/
}

# Alias to open Visual Studio Code Insiders
alias code="code-insiders"

# Lazygit and Lazydocker alias
alias lzg="lazygit"
alias lzd="lazydocker"

# Alias to make it easier to create/activate/deactivate a Python virtual environment
alias venv-i="python3 -m venv venv"
alias venv-a="source venv/bin/activate"
alias venv-d="deactivate"

# Alias to simplify use of Python UV
uv-i() {
	uv init
	uv venv
}
alias uv-a="source .venv/bin/activate"
alias uv-d="deactivate"

# Alias for common git commands
"gfs"() {
    git fetch
    git status
}
alias "gs"="git status"
alias "ga"="git add"
alias "gc"="git commit"
alias "gb"="git branch"
alias "gco"="git checkout"
alias "gp"="git push"
alias "gpo"="git push origin"
alias "gpl"="git pull"
alias "gplo"="git pull origin"
alias "gl"="git log --oneline --graph --decorate"

# Disk usage human readable and summary for the current directory
alias dus="du -hs"
# Disk usage for directories AND files in human readable format with the grand total, sorted by size
duf() {
    du -ahc "${1}" | sort -h
}
# Disk usage human readable with the grand total, for a specific directory recursively up to a specified depth, sorted by size
dur() {
    du -hc -d "${1}" "${2}" | sort -h
}

# Create a directory and cd into it
mkcd() {
    mkdir -p "${1}"
    cd "${1}"
}

# Create a directory and a file within
mktouch() {
	mkdir -p "${1}"
	touch "${1}/${2}"
}

# Shell wraper that provides the ability to change the current working
# directory when wxiting Yazi
function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
