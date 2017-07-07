HOST ?= $(shell hostname)
NOW = $(shell date +"%Y-%m-%d@%T")

include ~/etc/local/$(HOST)/variables.mk

default: link update i3 rofi post-install

update: update-zsh-plugins update-libs update-spacemacs update-tmux update-vim post-install

link: link-conf link-misc link-local post-install

install: link init-spacemacs set-shell i3 init-tmux add-pacman-repositories install-pacaur install-packages install-aur-packages update post-install

min: min-install save-originals user-fs update-libs set-shell update-zsh-plugins min-link init-vim init-tmux
	-@ln -s $(HOME)/lib/LS_COLORS/LS_COLORS $(HOME)/.dircolors

pull:
	git pull --rebase

min-install:
	sudo apt-get install < min_packages.txt

min-link: 
	stow zsh git tmux vim bash -R -t ~ -d conf

install-pacaur:
	@echo -e "\033[0;33mBuild and install pacur...\033[0m"
	mkdir ~/etc/build
	cd ~/etc/build && git clone https://aur.archlinux.org/pacaur.git
	cd ~/etc/build/pacaur && makepkg -si --noconfirm --needed
	rm -rf ~/etc/build

# add-pacman-repositories:
# 	@echo -e "\033[0;33mAdding pacman repositories...\033[0m"
# 	cat pacman_repositories.txt | sudo tee -a /etc/pacman.conf

install-aur-packages: install-pacaur
	@echo -e "\033[0;33mInstalling AUR packages...\033[0m"
	pacaur -S --needed --noconfirm - < aur_packages.txt

install-packages:
	@echo -e "\033[0;33mInstalling packages...\033[0m"
	sudo pacman --needed -S - < pkglist.txt

enable-services: init-emacs
	@echo -e "\033[0;33mInitialize emacs...\033[0m"
	systemctl --user enable emacs && systemctl --user start emacs

# Scaffold user fs structure.
# Don't echo to stdout and continue in case of error (-@)
user-fs:
	@echo -e "\033[0;33mCreate user fs...\033[0m"
	-@mkdir ~/src
	-@mkdir ~/lib
	-@mkdir ~/mnt
	-@mkdir ~/tmp
	-@mkdir ~/bin
	-@mkdir ~/sbin
	-@mkdir -p ~/var/log
	-@mkdir -p ~/var/undo
	-@mkdir -p ~/.cache/zsh
	-@mkdir -p ~/backup
	-@touch ~/.cache/zsh/dirs

update-zsh-plugins:
	@echo -e "\033[0;33mUpdating zsh plugins...\033[0m"
	./scripts/git_update.sh ~/.zsh.d/plugins ~/etc/zsh_plugins.txt

update-libs:
	@./scripts/git_update.sh ~/lib ~/etc/lib_repositories.txt

init-vim: ~/.vim/autoload/plug.vim
	@echo -e "\033[0;33mInitialize Vim...\033[0m"
	@vim -c "exec InstallAndExit()"

update-vim: ~/.vim/autoload/plug.vim
	@echo -e "\033[0;33mUpdating Vim packages...\033[0m"
	@vim -c "exec UpdateAndExit()"

~/.vim/autoload/plug.vim:
	@echo -e "\033[0;33mGetting plugin manager for Vim...\033[0m"
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

clone-src:
	@echo -e "\033[0;33mCloning src...\033[0m"
	@ssh-add -l &>/dev/null || ssh-add ~/.ssh/id_rsa
	@./scripts/git_update.sh ~/src ~/etc/src_repositories.txt

clone-org:
	@echo -e "\033[0;33mCloning org...\033[0m"
	@ssh-add -l &>/dev/null || ssh-add ~/.ssh/id_rsa
	@git clone git@github.com:roosta/org.git $(HOME)

link-misc:
	@echo -e "\033[0;33mSymlinking misc files...\033[0m"
	-@ln -f -s $(HOME)/src/utils $(HOME) &>/dev/null
	-@ln -f -s $(HOME)/src/colors $(HOME) &>/dev/null
	-@ln -f -s $(HOME)/src/utils/emacs_file_opener.sh $(HOME)/bin/emacs_file_opener &>/dev/null
	-@ln -f -s $(HOME)/etc/scripts/ftl.sh $(HOME)/bin/ftl &>/dev/null
	-@ln -f -s $(HOME)/lib/LS_COLORS/LS_COLORS $(HOME)/.dircolors &>/dev/null
	-@ln -f -s $(HOME)/src/utils/chdisp_nvidia.sh $(HOME)/bin/chdisp &>/dev/null
	-@ln -f -s $(HOME)/src/utils/touchpad_toggle.sh $(HOME)/bin/touchpad_toggle &>/dev/null
	-@ln -f -s $(HOME)/utils/locker.sh $(HOME)/bin/locker &>/dev/null
	-@ln -f -s $(HOME)/utils/tmux-dev-session.sh $(HOME)/bin/tdev &>/dev/null

link-conf:
	@echo -e "\033[0;33mSymlinking conf...\033[0m"
	@stow $(shell ls conf) -R -t ~ -d conf --ignore="md|org"

link-local:
	@echo -e "\033[0;33mSymlinking local...\033[0m"
	@stow $(shell ls local/$(HOST)/conf) -R -t ~ -d local/$(HOST)/conf

set-shell:
	@echo -e "\033[0;33mSetting shell to zsh...\033[0m"
	chsh -s `which zsh`

update-spacemacs:
	@echo -e "\033[0;33mUpdating spacemacs...\033[0m"
	@cd ~/.emacs.d && git pull --rebase

init-spacemacs: link-conf
	@echo -e "\033[0;33mInitialize spacemacs...\033[0m"
	sudo pacman -S emacs
	git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

~/.i3/config: link-conf
	@echo -e "\033[0;33mCreating i3 config...\033[0m"
	@rm ~/.i3/config -f
	@cd ~/etc/templates/i3 && cat *.i3 > ~/.i3/config
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
	@i3-msg reload
	@echo -e "\033[1;32mAll done!\033[0m"

clear-rofi:
	@rm ~/.config/rofi/config -f

~/.config/rofi/config: clear-rofi
	@cd ~/etc/templates/rofi && cat *.rofi > ~/.config/rofi/config
ifdef dpi
	@echo  "rofi.dpi: $(dpi)" >> ~/.config/rofi/config
endif
ifdef bar_height
	@echo  "rofi.yoffset: $(bar_height)" >> ~/.config/rofi/config
endif
ifdef lines
	@echo "rofi.lines: $(lines)" >> ~/.config/rofi/config
endif

rofi: ~/.config/rofi/config
	@echo -e "\033[0;33mCreating rofi config...\033[0m"

update-tmux:
	@echo -e "\033[0;33mUpdating tmux plugins...\033[0m"
	@. ~/.tmux/plugins/tpm/bin/update_plugins all

init-tmux:
	@echo -e "\033[0;33mInitialize tmux...\033[0m"
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins

install-ls--: update-libs
	@cpan Term::ExtendedColor
	@cd ~/lib/ls-- && perl Makefile.PL && make && make install

save-originals:
	@mkdir ~/backup/original-system-files@$(NOW)
	@mv ~/.bash* ~/backup/original-system-files@$(NOW)

post-install:
	@echo -e "\033[1;32mAll done!\033[0m"
