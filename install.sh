#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo -e "\nThis will link all the dotfiles from this repository. It will ERASE existing files:"
echo "~/.bashrc"
echo "~/.inputrc"
echo "~/.gitconfig"
echo "~/.editorconfig"
echo "~/.config/user-dirs.dirs"
read -p "Continue? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  echo "Linking dotfiles..."
  declare -A DOTFILES=(
    [".bashrc"]="$HOME/.bashrc"
    [".inputrc"]="$HOME/.inputrc"
    [".gitconfig"]="$HOME/.gitconfig"
    [".editorconfig"]="$HOME/.editorconfig"
    ["user-dirs.dirs"]="$HOME/.config/user-dirs.dirs"
  )
  for file in "${!DOTFILES[@]}"; do
    src="$SCRIPT_DIR/dots/$file"
    dest="${DOTFILES[$file]}"
    ln -vsf "$src" "$dest"
  done
  source "$HOME/.bashrc"
  echo -e "Done\n"
fi

read -p "Apply Gnome settings? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  FILES=(
    "interface.conf"
    "keybinds.conf"
    "peripherals.conf"
    "nautilus.conf"
    "text-editor.conf"
    "extensions/clipboard-indicator.conf"
    "extensions/gnome-ui-tune.conf"
  )
  for file in "${FILES[@]}"; do
    dconf load / < "$SCRIPT_DIR/gnome/$file"
  done
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

read -p "Link and activate systemd service for copying LaTeX snippets? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  systemctl --user link "$SCRIPT_DIR/files/copy-latex-snippets.service"
  systemctl --user link "$SCRIPT_DIR/files/copy-latex-snippets.path"
  systemctl --user daemon-reload
  systemctl --user enable --now copy-latex-snippets.path
  echo -e "Done\n"
fi

read -p "Install dnf packages? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  sudo dnf install $(cat "$SCRIPT_DIR/apps/dnf")
fi

read -p "Install flatpaks? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  flatpak install fedora com.github.tchx84.Flatseal
  flatpak install flathub $(cat "$SCRIPT_DIR/apps/flatpak")
fi

read -p "Link Zed configuration? (y/N): " confirm
if [[ $confirm =~ ^[yY](es)?$ ]]; then
  mkdir -p "$HOME/.config/zed"
  declare -A ZEDFILES=(
    ["settings.json"]="$HOME/.config/zed/settings.json"
    ["keymap.json"]="$HOME/.config/zed/keymap.json"
  )
  for file in "${!ZEDFILES[@]}"; do
    src="$SCRIPT_DIR/zed/$file"
    dest="${ZEDFILES[$file]}"
    ln -vsf "$src" "$dest"
  done
  echo -e "Done\n"
fi
