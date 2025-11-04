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
    [".editorconfig"]="$HOME/.editorconfig"
)

for file in "${!DOTFILES[@]}"; do
    src="$SCRIPT_DIR/dots/$file"
    dest="${DOTFILES[$file]}"
    ln -vsf "$src" "$dest"
done

echo "Done"

read -p "Copy monitor configuration to use for gdm greeter? (y/N): " confirm && [[ $confirm =~ ^[yY](es)?$ ]] || exit 1

sudo cp -v ~/.config/monitors.xml ~gdm/seat0/config/

echo "Done"

read -p "Copy theme changing script? (y/N): " confirm && [[ $confirm =~ ^[yY](es)?$ ]] || exit 1

mkdir -p "$HOME/.local/bin"
cp -v "$SCRIPT_DIR/files/change-theme" "$HOME/.local/bin/change-theme"

echo "Done"
