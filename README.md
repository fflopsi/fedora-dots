# Fedora dotfiles and configuration

This contains some important files for my Fedora systems.

## Installation and Usage

To install these dotfiles, you can use the following commands to:

1. Clone the repository
2. Edit the [`.gitconfig`](dots/.gitconfig) file to set your name, email and ssh key location
3. Run the [`install.sh`](install.sh) script

```bash
mkdir -p ~/Documents/Programming/fedora-dots && cd $_
git clone https://github.com/fflopsi/fedora-dots.git ./
nano dots/.gitconfig
chmod +x install.sh
./install.sh
```

To update the dotfiles, simply run `udots` in a terminal. This pulls the latest changes from the repository and installs them.

## Content

The [`install.sh`](install.sh) script does a few different things, each of those can be applied or skipped separately:

1. Link the dotfiles in the [`dots`](dots) directory to your home directory
2. Apply Gnome settings from the [`gnome`](gnome) directory (extensions must be installed separately, my list is in [`gnome/extensions/extensions.md`](gnome/extensions/extensions.md))
3. Copy monitor configuration from your home directory to the gdm directory (apply monitor arrangement, refresh rate, etc. to login screen)
4. Link the script [`files/change-theme`](files/change-theme) to change the global theme to `!/.local/bin/change-theme`
5. Link and activate a systemd service in [`files/copy-latex-snippets.service`](files/copy-latex-snippets.service) and [`files/copy-latex-snippets.path`](files/copy-latex-snippets.path) to observe latex snippets in a folder `~/Documents/Programming/latex-snippets` (two files, `latex-suite-snippets.js` and `latex-suite-variables.js`) and copy them to `~/Documents/Polybox/Obsidian/` when changed
6. Install packages in [`apps/dnf`](apps/dnf)
7. Install packages in [`apps/flatpak`](apps/flatpak)
8. Link Zed configuration files in the [`zed`](zed) directory to the Zed (flatpak version) configuration directory `~/.var/app/dev.zed.Zed/config/zed`
