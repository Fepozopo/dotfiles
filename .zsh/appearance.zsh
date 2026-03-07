# Sets color variable such as $fg, $bg, $color and $reset_color
autoload -U colors && colors

# Expand variables and commands in PROMPT variables
setopt prompt_subst

# Second-line content
PROMPT_SECOND='$(git_prompt_info)%(?.. %B%F{red}(%?%)%f) %(?.%F{green}➜ .%F{red}➜ )'

# Build a two-line prompt where:
#  - top line: connector + full path + a horizontal rule that fills the terminal
#  - bottom line: connector + the second-line prompt content
build_two_line_prompt() {
  # printable path (no color escapes) used to compute widths
  local raw_path=$(print -Pn "%~")

  # terminal width
  local cols=${COLUMNS:-$(tput cols)}

  # left-side connectors
  local top_left_char='┌'
  local bottom_left_char='└'

  # a small space between path and the rule
  local spacer=' '

  # compute printable length consumed on the top-left: connector + path + spacer
  local left_len=$(( ${#raw_path} + 1 + ${#spacer} ))

  # number of '─' characters to draw
  local fill_count=$(( cols - left_len ))
  (( fill_count < 0 )) && fill_count=0

  local fill=''
  if (( fill_count > 0 )); then
    # build repeated '─' characters; seq exists on macOS
    fill=$(printf '─%.0s' $(seq 1 $fill_count))
  fi

  # color sequences for the path
  local colored_path="%B%F{cyan}%~%f"

  # Assemble PROMPT: top connector + colored path + fill, newline, bottom connector + second-line content
  PROMPT="%B%F{blue}${top_left_char}%b${colored_path}%B%F{blue}${fill}"$'\n'"%B%F{blue}${bottom_left_char}%b${PROMPT_SECOND}"
}

# Run before each prompt so it adapts to changes/resizes
precmd_functions+=(build_two_line_prompt)

# TRAPWINCH: handle terminal resizes so the two-line prompt keeps its layout.
TRAPWINCH() {
  emulate -L zsh

  # Update LINES and COLUMNS in a robust way
  local rows cols
  if read -r rows cols < <(stty size 2>/dev/null); then
    LINES=$rows
    COLUMNS=$cols
  else
    # fallback to tput if stty failed
    COLUMNS=$(tput cols 2>/dev/null || ${COLUMNS:-80})
  fi

  # Rebuild the prompt string using the new width so fill-count is correct.
  # This updates $PROMPT for the next render and ensures fill calculation uses current $COLUMNS.
  if typeset -f build_two_line_prompt >/dev/null 2>&1; then
    build_two_line_prompt
  fi

  # If we're inside the ZLE line editor (i.e. the interactive prompt is visible),
  # ask it to redraw the prompt immediately. Guarding so we don't call zle when not available.
  if [[ -o zle ]] 2>/dev/null || [[ -n ${ZLE_STATE-} ]] 2>/dev/null; then
    # Try the common widget to refresh the prompt. It may fail silently in some contexts.
    zle reset-prompt 2>/dev/null || zle -R 2>/dev/null || true
  fi
}

# Use diff --color if available
if command diff --color /dev/null{,} &>/dev/null; then
  function diff {
    command diff --color "$@"
  }
fi

# Don't set ls coloring if disabled
[[ "$DISABLE_LS_COLORS" != true ]] || return 0

# Default coloring for BSD-based ls
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Default coloring for GNU-based ls
if [[ -z "$LS_COLORS" ]]; then
  # Define LS_COLORS via dircolors if available. Otherwise, set a default
  # equivalent to LSCOLORS (generated via https://geoff.greer.fm/lscolors)
  if (( $+commands[dircolors] )); then
    [[ -f "$HOME/.dircolors" ]] \
      && source <(dircolors -b "$HOME/.dircolors") \
      || source <(dircolors -b)
  else
    export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  fi
fi

function test-ls-args {
  local cmd="$1"          # ls, gls, colorls, ...
  local args="${@[2,-1]}" # arguments except the first one
  command "$cmd" "$args" /dev/null &>/dev/null
}
