![title](https://raw.githubusercontent.com/roosta/assets/master/etc/title.png)

A collection of config files I use on a daily basis on multiple hosts. My OS of
choice is [Arch Linux](https://www.archlinux.org/), and my dotfiles are managed
by [Make](https://www.gnu.org/software/make/) and
[Stow](https://www.gnu.org/software/stow/).

Companion repos for these dotfiles:

- [srcery-colors/srcery-vim: vim colorscheme](https://github.com/srcery-colors/srcery-vim)
- [srcery-colors/srcery-terminal: terminal colorschemes](https://github.com/srcery-colors/srcery-terminal)
- [roosta/scripts: collection of various shell scripts](https://github.com/roosta/scripts)

## Installation

**Warning**: As with most dotfiles, cherry-picking configs might be a better
choice than attempting to run the full install steps. There are dragons in
there.

First of this repo needs to be cloned, and assuming you are running Arch Linux
calling `make install` should in theory setup a fresh system, but I haven't
tested this rule in a while so it probably needs some attention.
```shell
git clone https://github.com/roosta/etc && cd etc && make install
```

git needs to be installed prior to the setup.

## Main Makefile rules

I list the basics here, there are a bunch of rules and they are in constant
flux, for details on each see the [Makefile](Makefile).

### default

`prerequisites: links update i3 rofi post-install`

Main rule run on a daily basis. Re-links, updates repos, generate configs. This
is my goto and my daily routine is pulling any updates, then calling `make`
with no arguments.

### update

`prerequisites: update-zsh-plugins update-libs update-spacemacs update-tmux update-vim post-install`

Runs through the update routine. I keep a bunch of 'lib' repos that isn't part
of a package manager updated on my system. Located in `~/lib` by default and
the source for these libs are [lib_repositories.txt](lib_repositories.txt)
which is just a flat file with the repository URL.

I made a helper script for this process that either clones a repo or pulls if
it is already present See the [git_update.sh](scripts/git_update.sh)
script for details.

### links

`prerequisites link-conf link-misc link-local post-install`

Links all the config files using [Stow](https://www.gnu.org/software/stow/). If
you are unfamiliar with stow, have a look at the
[manual](https://www.gnu.org/software/stow/manual/), but the concept is fairly
straightforward. All config is kept in `./conf`, and each program gets it's own
folder. Contents in this folder mirror where you want the config placed with
your home(~) as the root.

So for example, my `.vimrc` I want linked to my home root `~/.vimrc`, so its
placed in the `vim` folder with no additional folder structure inside. Another
example would be my termite config which should be linked to:
`~/.config/termite/config` so I mirror that folder structure in
`conf/qermite/.config/termite/config` where `conf/termite` would correspond to
home root.

### install

`prerequisites: user-fs install-pacaur install-packages install-aur-packages save-originals init-spacemacs set-shell clone-source i3 rofi init-tmux links post-install`

This is the fragile install rule, that sets up a fresh system. It basically
runs through the lot, and additionally installs packages, and clones various
repos.

### min

`prerequisites: min-install save-originals user-fs update-libs set-shell update-zsh-plugins min-links init-vim init-tmux`

Setup a minimal system. I use this if I spin up a VM or something and just want
some basic conf present like vimrc, tmux and etc.

## Favorites

There are a bunch of config files here, and some are not worth mentioning in
detail, but here are some of my favorites:

- [i3](https://github.com/roosta/etc/tree/master/conf/i3)
- [firefox](https://github.com/roosta/etc/tree/master/conf/firefox)
- [git](https://github.com/roosta/etc/tree/master/conf/git)
- [polybar](https://github.com/roosta/etc/tree/master/conf/polybar)
- rofi
- termite
- tmux
- vim
- x
- zsh
- dunst


## Screenshots

###  Clean i3

![clean](https://raw.githubusercontent.com/roosta/assets/master/etc/clean.jpg)

### Busy tmux

![busy](https://raw.githubusercontent.com/roosta/assets/master/etc/busy.png)

### Busy i3

![busy2](https://raw.githubusercontent.com/roosta/assets/master/etc/busy2.png)

### Firefox

![firefox](https://raw.githubusercontent.com/roosta/assets/master/etc/firefox.png)
