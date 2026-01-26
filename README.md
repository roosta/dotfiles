# Dotfiles

A collection of config files I use on a daily basis on multiple hosts running
[Arch Linux](https://www.archlinux.org/). My dotfiles are managed using the
method described in the [Arch wiki dotfiles article](https://wiki.archlinux.org/title/Dotfiles).

## Install

```bash
git clone --bare git@github.com:roosta/dotfiles.git $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dot checkout
dot config --local status.showUntrackedFiles no
dot submodule update --init --recursive
```

### Conflict

In case there are issues doing `checkout`, due to conflicting stock files, you
can run this script to back move them to the directory `.dotfiles-backup`.

```bash
mkdir -p .dotfiles-backup && \
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dotfiles-backup/{}
```

### Dependencies

Dependencies are tracked in
[.dependencies.yml](https://github.com/roosta/dotfiles/blob/main/.dependencies.yml)
and is installed using
[install-packages.sh](https://github.com/roosta/scripts/blob/main/install-packages.sh)
from the [scripts submodule](https://github.com/roosta/scripts).

#### Requirements

```bash
# Install dependency script requirements
sudo pacman -S --needed git yq base-devel

# Build and install paru
cd ~/build
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

#### Usage

```bash
# Script will default to ~/.dependencies.yml
# Optionally pass a dependency yml file
~/scripts/install-packages.sh
```

### Git hooks

Make sure dependencies `pre-commit` and `gitleaks` are installed via
`.dependencies.yml` or install manually.

```bash
GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME pre-commit install
```

## Configuration
### GKT

```bash
gsettings set org.gnome.desktop.interface adwaita prefer-dark
gsettings set org.gnome.desktop.interface font-name 'Iosevka 10'
gsettings set org.gnome.desktop.interface icon-theme ritual-icons
```

### QT

Should work out of the box, provided the
[Breeze](https://kde.org/plasma-desktop/) theme is installed. There are custom
colors provided in [.config/qt6ct](.config/qt6ct) and [.config/qt5ct](.config/qt5ct) as well as [.config/kdeglobals](.config/kdeglobals).

## Ritual Shell

[Hyprland](https://hypr.land/) and [Quickshell](https://quickshell.org/) is
used for the custom desktop shell based on the [Srcery](https://srcery.sh/)
colorscheme.

### Configuration

Per-host Quickshell configuration is kept in
[.config/quickshell/config/Config.qml](.config/quickshell/config/Config.qml) and Hyprland config also requires host configuration for the monitor setup located at [.config/hypr/monitors](.config/hypr/monitors).

## Disclamer

These dotfiles are provided **as-is** with no warranty or guarantee of
functionality. They are tailored specifically for my personal setup and
workflow, and are not intended to work out-of-the-box on other systems.

Feel free to browse, fork, or borrow ideas, but please review and understand any code before running it on your own machine. Use at your own risk.
## License

Copyright (c) 2015 Daniel Berg

License unless otherwise stated is [GPLv3](LICENSE).
