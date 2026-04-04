<div align="center">
    <h2>⛥  Ritualistic Dotfiles ⛦</h2>
</div>

![screen](https://raw.githubusercontent.com/roosta/assets/master/dotfiles/ritual_screen.png)

A [Srcery](https://srcery.sh) themed collection of dotfiles comprising my [Ritual
desktop shell](#ritual-shell) for [Arch Linux](https://archlinux.org/). Designed for
usability, 4k gaming, and use with multiple monitors. This is my daily driver for
keyboard-driven development, while allowing for a more relaxed mouse focused
"couch mode".

![GitHub last commit](https://img.shields.io/github/last-commit/roosta/dotfiles?style=flat-square&logo=git&logoColor=%23FCE8C3&labelColor=%23312F2C&color=%232C78BF&link=https%3A%2F%2Fgithub.com%2Froosta%2Fdotfiles%2Ftree%2Fmain)
![GitHub commit activity](https://img.shields.io/github/commit-activity/t/roosta/dotfiles?style=flat-square&logo=git&logoColor=%23FCE8C3&labelColor=%23312F2C&color=%230AAEB3)
![GitHub repo size](https://img.shields.io/github/repo-size/roosta/dotfiles?style=flat-square&logo=gitbook&logoColor=%23FCE8C3&labelColor=%23312F2C&color=%23519F50)

## Notable Configuration

Things in here often gets replaced and/or
[deprecated](https://github.com/roosta/dotfiles/tree/deprecated), but there are
some mainstays:

| Software | Description | Config |
|----|----|----|
| [Zsh](https://www.zsh.org/) | I do most of my work in here | [dir](.zsh.d), [config](.zshrc)  |
| [Nvim](https://neovim.io/) | Neovim is my primary editor used in the terminal | [dir](.config/nvim) |
| [Hyprland](https://hypr.land/) | The compositor that handles monitors, windows, workspaces, etc | [dir](.config/hypr) |
| [Scripts](https://github.com/roosta/scripts) | My shell scripts, these control various aspects of the ritual desktop shell | [repo](https://github.com/roosta/scripts) |
| [Kando](https://kando.menu/) | Pie menu used for mouse controls, with a custom theme | [dir](.config/kando), [theme](.config/kando/menu-themes/ritual) |
| [Quickshell](https://quickshell.org/) | Launcher, bar, and widgets all made with quickshell | [dir](.config/quickshell), [config](.config/quickshell/config/Config.qml) |


## Install

My dotfiles are managed using the method described in the [Arch wiki dotfiles
article](https://wiki.archlinux.org/title/Dotfiles).

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
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface font-name 'Iosevka 10'
gsettings set org.gnome.desktop.interface icon-theme ritual-icons
gsettings set org.gnome.desktop.interface gtk-theme 'Breeze'
```

### QT

Settings are stored in [.config/kdeglobals](.config/kdeglobals), and uses a
custom color scheme built atop the [Breeze theme](https://kde.org/plasma-desktop/).

>[!TIP]
> To Access color settings among others install the optional dependency `plasma-integration`

## Ritual desktop shell

<video src="https://github.com/user-attachments/assets/63304a4e-1961-4533-91ca-aec0c2b92a6f" controls width="800"></video>

[Hyprland](https://hypr.land/) and [Quickshell](https://quickshell.org/) is
used for the custom desktop shell based on the [Srcery](https://srcery.sh/)
colorscheme. This is a constant work-in-progress and gets frequently updated
and changed based on my needs using it.

### Attribution

I've been heavily inspired by, learned a lot from, and copied portions of code from:

- [end-4/dots-hyprland: Usability-first dotfiles](https://github.com/end-4/dots-hyprland)
- [caelestia-dots/shell: ‼️ No waybar here ‼️](https://github.com/caelestia-dots/shell)

> Code copied will be clearly marked with a permalink and modification notice.

>[!NOTE]
Code is licensed with [GPLv3](LICENSE)

### Inspiration

- [AvengeMedia/DankMaterialShell: Desktop shell for wayland compositors built with Quickshell & GO, optimized for niri & hyprland. Check out the niri community Discord below.](https://github.com/AvengeMedia/DankMaterialShell)
- [Axenide/Ambxst: An Axtremely customizable shell.](https://github.com/Axenide/Ambxst?tab=readme-ov-file)
- [caelestia-dots/caelestia: A very segsy rice](https://github.com/caelestia-dots/caelestia)
- [catdeal3r/fibreglass: Fibreglass is a custom desktop shell created in quickshell.](https://github.com/catdeal3r/fibreglass)
- [cxOrz/dotfiles-hyprland: Hyprland dotfiles on Arch Linux.](https://github.com/cxOrz/dotfiles-hyprland)
- [debuggyo/Exo: A Material 3 inspired desktop shell for Niri and Hyprland created with Ignis.](https://github.com/debuggyo/Exo?tab=readme-ov-file)
- [imarkoff/Marble-shell-theme: Shell theme for GNOME DE](https://github.com/imarkoff/Marble-shell-theme)
- [noctalia-dev/noctalia-shell: A sleek and minimal desktop shell thoughtfully crafted for Wayland.](https://github.com/noctalia-dev/noctalia-shell)
- [xfcasio/amadeus: Amadeus desktop](https://github.com/xfcasio/amadeus?tab=readme-ov-file)
- [xZepyx/nucleus-shell: A shell built to get things done.](https://github.com/xZepyx/nucleus-shell?tab=readme-ov-file)

### Configuration

Per-host Quickshell configuration is kept in
[.config/quickshell/config/Config.qml](.config/quickshell/config/Config.qml)
and Hyprland config also requires host configuration for the monitor setup
located at [.config/hypr/monitors](.config/hypr/monitors).

## Disclamer

These dotfiles are provided **as-is** with no warranty or guarantee of
functionality. They are tailored specifically for my personal setup and
workflow, and are not intended to work out-of-the-box on other systems.

Feel free to browse, fork, or borrow ideas, but please review and understand
any code before running it on your own machine. Use at your own risk.

## License

Copyright (c) 2015 Daniel Berg

License unless otherwise stated is [GPLv3](LICENSE).
