.PHONY: default update links install min min-update min-install min-links install-yay install-aur-packages install-packages user-fs update-zsh-plugins update-libs init-vim update-vim update-src link-misc link-conf link-local set-shell update-spacemacs i3 rofi update-tmux save-originals rustup exa update-rust
HOST ?= $(shell hostname)
NOW = $(shell date +"%Y-%m-%dT%T")
VARS = ~/etc/local/$(HOST)/variables.mk
GLOBAL_VERSION = "6.6.3"

ifneq ("$(wildcard $(VARS))","")
include $(VARS)
endif

default: links update i3 rofi dunst

update: update-zsh-plugins update-libs update-tmux update-vim update-rust

links: link-conf link-misc link-local

install: user-fs install-yay install-packages install-aur-packages save-originals ~/.emacs.d set-shell update-src update-libs update-zsh-plugins ~/.tmux/plugins/tpm links ~/.zplug cleanup

min: min-install save-originals user-fs update-libs set-shell update-zsh-plugins min-links init-vim init-tmux cleanup

min-update: update-libs update-zsh-plugins update-tmux update-vim

min-install:
	sudo apt-get install < min_packages.txt

min-links:
	stow zsh git tmux vim bash -R -t ~ -d conf

~/etc/build:
	-mkdir -p ~/etc/build

cleanup:
	@echo -e "\033[0;33mCleaning up...\033[0m"
	-rm -rf ~/etc/build

~/.terminfo/x/xterm-termite: ~/etc/build
	wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo ~/etc/build/
	tic -x ~/etc/build/termite.terminfo

global: ~/etc/build
	wget http://tamacom.com/global/global-$(GLOBAL_VERSION).tar.gz -O ~/etc/build/global-$(GLOBAL_VERSION).tar.gz
	cd ~/etc/build && tar xvf global-$(GLOBAL_VERSION).tar.gz
	cd ~/etc/build/global-$(GLOBAL_VERSION) && \
		./configure --with-exuberant-ctags=/usr/bin/ctags && \
		make && \
		sudo make install

install-yay: ~/etc/build
	@echo -e "\033[0;33mBuilding and installing yay...\033[0m"
	-cd ~/etc/build && git clone https://aur.archlinux.org/yay.git
	-cd ~/etc/build/yay && makepkg -si --noconfirm --needed

install-paru: ~/etc/build
	@echo -e "\033[0;33mBuilding and installing paru...\033[0m"
	-cd ~/etc/build && git clone https://aur.archlinux.org/paru.git
	-cd ~/etc/build/paru && makepkg -si --noconfirm --needed

# add-pacman-repositories:
# 	@echo -e "\033[0;33mAdding pacman repositories...\033[0m"
# 	cat pacman_repositories.txt | sudo tee -a /etc/pacman.conf

install-aur-packages: install-yay
	@echo -e "\033[0;33mInstalling AUR packages...\033[0m"
	yay -S --needed --noconfirm - < aur_packages.txt

install-packages:
	@echo -e "\033[0;33mInstalling packages...\033[0m"
	sudo pacman --needed -S - < pacman_packages.txt

# .PHONY: enable-services
# enable-services: init-emacs
# 	@echo -e "\033[0;33mInitialize emacs...\033[0m"
# 	systemctl --user enable emacs && systemctl --user start emacs

# Scaffold user fs structure.
# @ stops the command from being echoed to stdout.
# - means that make will keep going in the case of an error.
user-fs: ~/src ~/lib ~/mnt ~/tmp ~/bin ~/sbin ~/var/log ~/var/vim/undo ~/.cache/zsh ~/backup ~/.cache/zsh/dirs ~/var/emacs/undo ~/var/emacs/backup ~/.local/share ~/.mozilla/firefox/roosta
	@echo -e "\033[0;33mCreate user fs...\033[0m"

~/src:
	-mkdir ~/src
~/lib:
	-mkdir ~/lib
~/mnt:
	-mkdir ~/mnt
~/tmp:
	-mkdir ~/tmp
~/bin:
	-mkdir ~/bin
~/sbin:
	-mkdir ~/sbin
~/var/log:
	-mkdir -p ~/var/log
~/var/vim/undo:
	-mkdir -p ~/var/vim/undo
~/var/emacs/backup:
	-mkdir -p ~/var/emacs/backup
~/.cache/zsh:
	-mkdir -p ~/.cache/zsh
~/backup:
	-mkdir -p ~/backup
~/.cache/zsh/dirs:
	-touch ~/.cache/zsh/dirs
~/.local/share:
	-mkdir -p ~/.local/share
~/.mozilla/firefox/roosta:
	-mkdir -p ~/.mozilla/firefox/roosta

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

~/org:
	@echo -e "\033[0;33mCloning org...\033[0m"
	# ssh-add -l &>/dev/null || ssh-add ~/.ssh/id_rsa
	git clone git@github.com:roosta/org.git ~/org

link-misc: ~/scripts ~/colors ~/bin/emacs-file-opener ~/bin/ftl ~/bin/touchpad-toggle ~/bin/tmain ~/bin/tupd
	@echo -e "\033[0;33mSymlinking misc files...\033[0m"

~/scripts: user-fs update-src
	-ln -f -s $(HOME)/src/scripts $(HOME) &>/dev/null

~/colors: user-fs update-src
	-ln -f -s $(HOME)/src/colors $(HOME) &>/dev/null

~/bin/emacs-file-opener: user-fs update-src
	-ln -f -s $(HOME)/src/scripts/emacs-file-opener.sh $(HOME)/bin/emacs-file-opener &>/dev/null

~/bin/ftl: user-fs update-src
	-ln -f -s $(HOME)/etc/scripts/ftl.sh $(HOME)/bin/ftl &>/dev/null

~/bin/touchpad-toggle: user-fs update-src
	-ln -f -s $(HOME)/src/scripts/touchpad-toggle.sh $(HOME)/bin/touchpad-toggle &>/dev/null

~/bin/tmain: user-fs update-src
	-ln -f -s $(HOME)/scripts/tmux-main.sh $(HOME)/bin/tmain &>/dev/null

~/bin/tmusic: user-fs update-src
	-ln -f -s $(HOME)/scripts/tmux-music.sh $(HOME)/bin/tmusic &>/dev/null

~/bin/tupd: user-fs update-src
	-ln -f -s $(HOME)/scripts/tmux-update-window.sh $(HOME)/bin/tupd &>/dev/null

~/bin/tssh: user-fs update-src
	-ln -f -s $(HOME)/scripts/tmux-ssh.sh $(HOME)/bin/tssh &>/dev/null

~/bin/rxtx: user-fs update-src
	-ln -f -s $(HOME)/scripts/rxtx.sh $(HOME)/bin/rxtx &>/dev/null

~/bin/loadavg: user-fs update-src
	-ln -f -s $(HOME)/scripts/loadavg.sh $(HOME)/bin/loadavg &>/dev/null

link-conf: user-fs
	@echo -e "\033[0;33mSymlinking conf...\033[0m"
	stow $(shell ls conf) -R -t ~ -d conf --ignore="md|org|firefox"

link-local:
	@echo -e "\033[0;33mSymlinking local...\033[0m"
	stow $(shell ls local/$(HOST)/conf) -R -t ~ -d local/$(HOST)/conf

set-shell:
	@echo -e "\033[0;33mSetting shell to zsh...\033[0m"
	chsh -s `which zsh`

update-spacemacs:
	@echo -e "\033[0;33mUpdating spacemacs...\033[0m"
	cd ~/.emacs.d && git pull --rebase

# ~/.emacs.d: link-conf install-packages ~/var/emacs/undo ~/var/emacs/backup
# 	@echo -e "\033[0;33mInitialize spacemacs...\033[0m"
# 	git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

~/var/emacs/undo:
	mkdir -p ~/var/emacs/undo

~/.dircolors: update-libs
	-ln -s $(HOME)/lib/LS_COLORS/LS_COLORS $(HOME)/.dircolors

~/bin/vidir: update-libs
	-ln -s $(HOME)/lib/vidir/bin/vidir $(HOME)/bin/vidir

~/.i3/config: link-conf ~/etc/local/$(HOST)/variables.mk ~/etc/templates/i3/*.i3
	@echo -e "\033[0;33mCreating i3 config...\033[0m"
	cd ~/etc/templates/i3 && cat *.i3 > ~/.i3/config
ifdef primary_monitor
	@echo "set \$$primary_monitor $(primary_monitor)" >> ~/.i3/config
endif
ifdef secondary_monitor
	@echo "set \$$secondary_monitor $(secondary_monitor)" >> ~/.i3/config
endif
ifdef tertiary_monitor
	@echo "set \$$tertiary_monitor $(tertiary_monitor)" >> ~/.i3/config
endif

i3: ~/.i3/config
	@echo -e "\033[0;33mReload i3 config...\033[0m"
	i3-msg reload
	@echo -e "\033[1;32mi3 config reloaded!\033[0m"

# clear-rofi:
# 	rm ~/.config/rofi/config -f

dunst: ~/.config/dunst/dunstrc
	@echo -e "\033[0;33mCreating dunst config...\033[0m"

~/.config/dunst:
	mkdir -p ~/.config/dunst

~/.config/dunst/dunstrc: ~/etc/templates/dunst/config.dunst ~/etc/local/$(HOST)/variables.mk ~/.config/dunst
	cat ~/etc/templates/dunst/config.dunst > ~/.config/dunst/dunstrc
ifdef font
	sed -ri 's/font = (.*)/font = $(font)/' ~/.config/dunst/dunstrc
endif

ifdef dunst_geometry
	sed -ri 's/geometry = (.*)/geometry = $(dunst_geometry)/' ~/.config/dunst/dunstrc
endif

~/.config/rofi/config: ~/etc/templates/rofi/config.rofi ~/etc/local/$(HOST)/variables.mk
	cat ~/etc/templates/rofi/*.rofi > ~/.config/rofi/config.rasi
ifdef bar_height
	sed -i '$$s/}/\n  yoffset: $(bar_height);\n}/' ~/.config/rofi/config.rasi
endif
ifdef lines
	sed -i '$$s/}/\n  lines: $(lines);\n}/' ~/.config/rofi/config.rasi
endif
ifdef font
	sed -i '$$s/}/\n  font: $(font);\n}/' ~/.config/rofi/config.rasi
endif

rofi: ~/.config/rofi/config
	@echo -e "\033[0;33mCreating rofi config...\033[0m"

update-tmux:
	@echo -e "\033[0;33mUpdating tmux plugins...\033[0m"
	. ~/.tmux/plugins/tpm/bin/update_plugins all

~/.tmux/plugins/tpm: link-conf
	@echo -e "\033[0;33mInitialize tmux...\033[0m"
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins

save-originals:
	mkdir ~/backup/original-system-files@$(NOW)
	mv ~/.bash* ~/backup/original-system-files@$(NOW)

rustup:
	rustup install stable
	rustup install nightly
	rustup default stable

exa: install-packages rustup
	cargo install exa

update-rust:
	rustup update

~/bin/cht.sh:
	curl https://cht.sh/:cht.sh > ~/bin/cht.sh
	chmod +x ~/bin/cht.sh

~/.fasd/fasd.log:
	 -mkdir ~/.fasd && touch ~/.fasd/fasd.log

~/bin/bakc: update-src
	ln -s ~/src/bakc/bakc.sh ~/bin/bakc

i3wsr:
	cargo install i3wsr

npm-packages: links
	npm install -g tern eslint js-beutify npx

~/.zplug:
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
