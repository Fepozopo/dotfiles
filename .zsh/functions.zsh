# Function to show Git branch/status on the left
git_prompt_info() {
  # If inside a Git repo…
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    # branch name
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    # dirty marker
    local dirty=$(git status --porcelain 2>/dev/null | wc -l)
    # check for upstream
    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
    local ahead="" behind=""
    if [[ -n $upstream ]]; then
      # unpushed commits
      if [[ $(git rev-list --count @{u}..HEAD 2>/dev/null) -gt 0 ]]; then
        ahead="↑"
      fi
      # unpulled commits
      if [[ $(git rev-list --count HEAD..@{u} 2>/dev/null) -gt 0 ]]; then
        behind="↓"
      fi
    fi
    if (( dirty > 0 )); then
      echo "%B%F{blue}(%F{red}$branch%F{yellow}*%F{blue})%F{magenta}$ahead$behind %b%f"
    else
      echo "%B%F{blue}(%F{red}$branch%F{blue})%F{magenta}$ahead$behind %b%f"
    fi
  fi
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
