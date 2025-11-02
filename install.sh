#!/usr/bin/env bash

echo "This will install all the dotfiles from this repository. It will ERASE existing files:"
echo "~/.bashrc"
echo "~/.inputrc"
echo "~/.gitconfig"
read -p "Continue? (y/N): " confirm && [[ $confirm =~ ^[yY](es)?$ ]] || exit 1

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo "Linking dotfiles..."

declare -A DOTFILES=(
    [".bashrc"]="$HOME/.bashrc"
    [".inputrc"]="$HOME/.inputrc"
    [".gitconfig"]="$HOME/.gitconfig"
)

for file in "${!DOTFILES[@]}"; do
    src="$SCRIPT_DIR/dots/$file"
    dest="${DOTFILES[$file]}"
    ln -sf "$src" "$dest"
done

echo "Done"
