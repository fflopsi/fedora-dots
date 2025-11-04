#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo -e "\nThis will link all the dotfiles from this repository. It will ERASE existing files:"
echo "~/.bashrc"
echo "~/.inputrc"
echo "~/.gitconfig"
echo "~/.editorconfig"
read -p "Continue? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
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
  echo -e "Done\n"
fi

read -p "Copy monitor configuration to use for gdm greeter? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  sudo cp -v ~/.config/monitors.xml ~gdm/seat0/config/
  echo -e "Done\n"
fi

read -p "Link theme changing script? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  mkdir -p "$HOME/.local/bin"
  ln -vsf "$SCRIPT_DIR/files/change-theme" "$HOME/.local/bin/change-theme"
  echo -e "Done\n"
fi

read -p "Install dnf packages? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  sudo dnf install $(cat "$SCRIPT_DIR/apps/dnf")
fi
