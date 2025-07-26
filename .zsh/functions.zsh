# Function to show Git branch/status on the left
git_prompt_info() {
  # If inside a Git repo…
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    # branch name
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    # dirty marker
    local dirty=$(git status --porcelain 2>/dev/null | wc -l)
    if (( dirty > 0 )); then
      echo "%B%F{blue}git:(%F{red}$branch%F{blue}) %F{yellow}* %b%f"
    else
      echo "%F{blue}git:(%F{red}$branch%F{blue}) %f"
    fi
  fi
}

# Case insensitive completion
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

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

# Quickly navigate to my git repos
mygit() {
  cd ~/Developer/workspace/github.com/Fepozopo/
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
