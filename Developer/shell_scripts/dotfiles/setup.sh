#!/bin/bash

set -e

echo "Setting up dotfiles..."

git clone --bare git@github.com:Fepozopo/dotfiles.git $HOME/.dotfiles

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

dotfiles checkout || {
    echo "Backing up pre-existing dotfiles..."
    mkdir -p .dotfiles-backup
    dotfiles checkout 2>&1 | grep -E "\s+" | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
    dotfiles checkout
}

dotfiles config --local status.showUntrackedFiles no
echo "✅ Dotfiles setup complete!"