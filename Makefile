.PHONY: \
	default \
	update \
	links \
	install \
	min \
	min-update \
	min-install \
	min-links \
	install-yay \
	install-aur-packages \
	install-packages \
	user-fs \
	update-zsh-plugins \
	update-libs \
	init-vim \
	update-vim \
	update-src \
	link-misc \
	link-conf \
	link-local \
	set-shell \
	rofi \
	update-tmux \
	save-originals \
	rustup \
	update-rust
HOST ?= $(shell hostname)
NOW = $(shell date +"%Y-%m-%dT%T")
TIMESTAMP=$(shell date +%s)
VARS = ~/etc/local/$(HOST)/variables.mk
CONF = $(shell ls conf)
LOCAL = $(shell ls local/$(HOST)/conf)
DIRS = \
		 ~/src \
		 ~/lib \
		 ~/mnt \
		 ~/tmp \
		 ~/bin \
		 ~/.cache/vim/backup \
		 ~/.cache/zsh \
		 ~/backup \
		 ~/.local/share \
		 ~/.local/share/applications \
		 ~/etc/build

ifneq ("$(wildcard $(VARS))","")
include $(VARS)
endif

default: links update sway rofi

update: update-zsh-plugins update-libs update-tmux update-vim update-rust

links: link-conf link-misc link-local

install: user-fs \
	install-paru \
	install-packages \
	install-aur-packages \
	save-originals \
	set-shell \
	update-src \
	update-libs \
	update-zsh-plugins \
	~/.tmux/plugins/tpm \
	links \
	~/.zplug cleanup

min: min-install \
	save-originals \
	user-fs \
	update-libs \
	set-shell \
	min-links \
	~/src/srcery-vim \
	~/src/srcery-terminal \
	update-zsh-plugins \
	init-vim \
	~/.tmux/plugins/tpm \
	update-tmux \
	cleanup

min-update: update-libs update-zsh-plugins update-tmux update-vim

min-install:
	xargs sudo apt-get install -y < min_packages.txt

min-links:
	stow -R -t ~ -d conf zsh git tmux vim bash nvim

cleanup:
	@echo -e "\033[0;33mCleaning up...\033[0m"
	-rm -rf ~/etc/build

install-yay: ~/etc/build
	@echo -e "\033[0;33mBuilding and installing yay...\033[0m"
	-cd ~/etc/build && git clone https://aur.archlinux.org/yay.git
	-cd ~/etc/build/yay && makepkg -si --noconfirm --needed

install-paru: ~/etc/build
	@echo -e "\033[0;33mBuilding and installing paru...\033[0m"
	-cd ~/etc/build && git clone https://aur.archlinux.org/paru.git
	-cd ~/etc/build/paru && makepkg -si --noconfirm --needed

add-pacman-repositories:
	@echo -e "\033[0;33mAdding pacman repositories...\033[0m"
	cat pacman_repositories.txt | sudo tee -a /etc/pacman.conf

install-aur-packages: install-yay
	@echo -e "\033[0;33mInstalling AUR packages...\033[0m"
	yay -S --needed --noconfirm - < aur_packages.txt

install-packages:
	@echo -e "\033[0;33mInstalling packages...\033[0m"
	sudo pacman --needed -S - < pacman_packages.txt

# Scaffold user fs structure.
user-fs: $(DIRS)
	@echo -e "\033[0;33mCreate user fs...\033[0m"

$(DIRS):
	mkdir -p $@

~/.cache/zsh/dirs:
	-touch ~/.cache/zsh/dirs

update-zsh-plugins: ~/.zplug
	@echo -e "\033[0;33mUpdating zsh plugins...\033[0m"
	./scripts/zsh-update.sh

update-libs:
	./scripts/git_update.sh ~/lib ~/etc/lib_repositories.txt

init-vim: ~/.vim/autoload/plug.vim
	@echo -e "\033[0;33mInitialize Vim...\033[0m"
	vim -c "exec InstallAndExit()"

update-vim: ~/.vim/autoload/plug.vim
	@echo -e "\033[0;33mUpdating Vim packages...\033[0m"
	vim -c "exec UpdateAndExit()"

~/.vim/autoload/plug.vim:
	@echo -e "\033[0;33mGetting plugin manager for Vim...\033[0m"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

update-src:
	@echo -e "\033[0;33mUpdate src...\033[0m"
	# ssh-add -l &>/dev/null || ssh-add ~/.ssh/id_rsa
	./scripts/git_update.sh ~/src ~/etc/src_repositories.txt

link-misc: ~/scripts ~/colors ~/bin/ftl ~/bin/touchpad-toggle ~/bin/tmain ~/bin/tupd
	@echo -e "\033[0;33mSymlinking misc files...\033[0m"

~/scripts: user-fs
	-ln -sf $(HOME)/src/scripts $(HOME)

~/colors: user-fs
	-ln -sf $(HOME)/src/colors $(HOME)

~/bin/ftl: user-fs
	-ln -sf $(HOME)/etc/scripts/ftl.sh $@

~/bin/touchpad-toggle: user-fs update-src
	-ln -sf $(HOME)/src/scripts/touchpad-toggle.sh $@

~/bin/tmain: user-fs
	-ln -sf $(HOME)/scripts/tmux-main.sh $@

~/bin/tupd: user-fs
	-ln -sf $(HOME)/scripts/tmux-update-window.sh $@

link-conf: user-fs
	@echo -e "\033[0;33mSymlinking conf...\033[0m"
	-stow -R -t ~ -d conf --ignore="md|org|firefox" $(CONF) 2>&1 | grep -v "BUG in find_stowed_path" || true

link-local:
	@echo -e "\033[0;33mSymlinking local...\033[0m"
	-stow -R -t ~ -d local/$(HOST)/conf $(LOCAL) 2>&1 | grep -v "BUG in find_stowed_path" || true

set-shell:
	@echo -e "\033[0;33mSetting shell to zsh...\033[0m"
	chsh -s `which zsh`

~/.dircolors: update-libs
	-ln -s $(HOME)/lib/LS_COLORS/LS_COLORS $@

~/.config/sway/config: link-conf ~/etc/local/$(HOST)/variables.mk ~/etc/templates/sway/*.sway
	@mkdir -p $(@D)
	@echo -e "\033[0;33mCreating sway config...\033[0m"
	cd ~/etc/templates/sway && cat *.sway > $@

sway: ~/.config/sway/config
	@echo -e "\033[0;33mReload Sway config...\033[0m"
	swaymsg reload
	@echo -e "\033[1;32mSway config reloaded!\033[0m"

~/.config/rofi/config.rasi: ~/etc/templates/rofi/config.rofi ~/etc/local/$(HOST)/variables.mk
	cat ~/etc/templates/rofi/*.rofi > $@
ifdef font
	sed -i '0,/}/{s//\n font: $(font);\n}/}' $@
endif

rofi: ~/.config/rofi/config.rasi
	@echo -e "\033[0;33mCreating rofi config...\033[0m"

update-tmux:
	@echo -e "\033[0;33mUpdating tmux plugins...\033[0m"
	~/.tmux/plugins/tpm/bin/update_plugins all

~/.tmux/plugins/tpm:
	@echo -e "\033[0;33mInitialize tmux...\033[0m"
	@mkdir -p $(@D)
	-@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins

save-originals:
	mkdir -p ~/backup/original-system-files
	-@mv ~/.bash* ~/backup/original-system-files

rustup:
	rustup install stable
	rustup install nightly
	rustup default stable

update-rust:
	rustup update

~/bin/bakc: update-src
	ln -s ~/src/bakc/bakc.sh ~/bin/bakc

i3wsr:
	cargo install i3wsr

~/.zplug:
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

~/src/srcery-vim:
	@mkdir -p $(@D)
	git clone https://github.com/srcery-colors/srcery-vim ~/src/srcery-vim

~/src/srcery-terminal:
	@mkdir -p $(@D)
	git clone https://github.com/srcery-colors/srcery-terminal ~/src/srcery-terminal
