# ┌───────────────────────────────────────────┐
# │▀▀▀▀▀▀░░█▀█░█░░░▀█▀░█▀█░█▀▀░█▀▀░█▀▀░░▀▀▀▀▀▀│
# │▀▀▀▀▀▀░░█▀█░█░░░ █ ░█▀█░▀▀█░█▀▀░▀▀█░░▀▀▀▀▀▀│
# │█▀▀▀▀▀░░▀ ▀░▀▀▀░▀▀▀░▀ ▀░▀▀▀░▀▀▀░▀▀▀░░▀▀▀▀▀█│
# │█     ░░ ░ ░   ░   ░ ░ ░   ░   ░   ░░     █│
# │█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█│
# │█░░  Author : Roosta <mail@roosta.sh>   ░░█│
# │█░░  Site   : https://www.roosta.sh     ░░█│
# │█░░  Github : https://github.com/roosta ░░█│
# └───────────────────────────────────────────┘

# Defaults: {{{
# ------------------------------------------------------------------------------
# Aliases that shadow the original command, except with added "default" options,
# use `which ALIAS` to see what it resolves to and `\ls` to get the unaliased
# command.

alias jobs='jobs -l' # show pid
alias ncdu='ncdu --color dark'
alias tree="tree -ahC --gitignore" # hidden(all), human, color
alias free='free --human'
alias locate='locate --ignore-case'
alias du='du --human-readable'
alias df='df --human-readable'
alias pgrep='pgrep --ignore-case --list-full'
alias mv='mv --interactive --verbose'
alias rm='rm -I --verbose --one-file-system' # prompt on large operations
alias cp='cp --interactive'
alias ln='ln --interactive'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias mkdir='mkdir --parents --verbose'
alias rg="rg --smart-case --hidden"
alias fd='fd --hidden'

# }}}
# Aliases: {{{
# ------------------------------------------------------------------------------

alias _="sudo"
alias feh='swayimg'
alias awk='gawk'
alias mutt='neomutt'
alias vim='nvim'
alias vi="nvim"
alias suser='systemctl --user'

alias paste="wl-paste"
alias copy="wl-copy"


if hash dust 2>/dev/null; then
  alias du="dust"
fi

# Check for various ls replacements before falling back to ls
if [[ $TERM == 'eterm-color' ]]; then
  alias ls='\ls -lAh'
else
  if hash eza 2>/dev/null; then
    alias ls='eza -aghl --git --group-directories-first -F'
  elif hash ls++ 2>/dev/null; then
    alias ls='ls++ -lAhpk --potsf'
  else
    alias ls="ls -lsAhpk --color=auto --group-directories-first"
  fi
fi

# Function to check disk status
# Uses dfc if installed, otherwise formats output with df and lsblk
check_disks() {
  if hash dfc 2>/dev/null; then
    # If dfc is available, use it with specified options
    dfc -W -q mount
  else
    # Otherwise, use a formatted output with lsblk and df
    # Artwork by https://github.com/xero, yanked from dotfiles long ago
    echo "╓───── m o u n t . p o i n t s"
    echo "╙────────────────────────────────────── ─ ─ "
    lsblk -a
    echo ""
    echo "╓───── d i s k . u s a g e"
    echo "╙────────────────────────────────────── ─ ─ "
    df -h
  fi
}
alias disks='check_disks'

# list filestypes by extension in cwd
# https://stackoverflow.com/a/7170782
alias ftls="find . -type f | awk -F. '!a[$NF]++{print $NF}'"

# }}}
# Custom: {{{
# ------------------------------------------------------------------------------

# Dotfiles in git bare repo
# https://wiki.archlinux.org/title/Dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles
alias dot='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dotsync='dot pull --recurse-submodules'

# Use fugitive with git bare repo (dotfiles)
# Additional dotfile local git config needed
# `dot config --local core.worktree $HOME`
alias dotvim="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME nvim -c 'Git'"

alias gitvi="vim -c 'Git'" # Fugitive on startup
alias clear_="sudo -K" # Clear cached sudo pass
alias clear!="printf '\033[2J\033[3J\033[1;1H'" # clear kitty scrollback buffer
alias ps-cpu-full='ps auxf | sort -nr -k 3'
alias ps-cpu='ps auxf | sort -nr -k 3 | head -10'
alias log-ssh='journalctl _COMM=sshd'
alias dut='du --human-readable -t' # threshold=SIZE
alias lspath='echo -e ${PATH//:/\\n}' # print whats on $PATH
alias lsfpath='tr " " "\n" <<< $fpath'
alias psgrep='ps aux|head -n 1 && ps aux|rg'
alias lsr='\ls -Atr' # lists most recent last
alias toilet-list="$HOME/scripts/figlet-list.sh"
alias wc="toilet -d $HOME/lib/figlet-fonts"
alias 3d-text="toilet -t -f 3d"
alias future="toilet -t -f future"
alias rusto="toilet -d $HOME/lib/figlet-fonts -t -f rusto"
alias rustofat="toilet -d $HOME/lib/figlet-fonts -t -f fonts/rustofat"
alias pagga="toilet -t -f pagga"
alias pagga-border="toilet -t -f pagga -F border"
alias check-rk="sudo rkhunter --update && sudo rkhunter --check --sk && \
  sudo rkhunter --propupd"
alias scan="clamdscan --multiscan --fdpass"
alias tnew="tmux new-session -s"
alias trw="tmux rename-window"
alias ta="tmux attach -t"
alias tkill="tmux kill-pane -t"
alias tls="tmux ls"
alias tc="tmux choose-session"
alias tk="tmux kill-session -t"
alias tw="tmux new-window -n"
alias now='date +"%T"'
alias stamp='date +"%Y-%m-%dT%T"'
alias iso='date +"%Y-%m-%d"'
alias pdf="evince"
alias watch-firefox="watch progress -wc firefox" # Download progress
alias close-firefox-="wmctrl -c firefox" # Clean shutdown
alias extract-to-dir="tar --one-top-level -zxvf" # ouput to filename dir
alias open-ports="ufw show listening"
alias mount-tmp-fs='sudo mount -t tmpfs tmpfs /mnt -o size=1024m'
alias gpg-reload='gpg-connect-agent reloadagent /bye'
alias public-ip='curl ipinfo.io/ip'
alias ipleak="curl -s https://ipleak.net/json/ | jq '.type'"
alias weather='curl http://wttr.in/oslo'
alias music='ncmpcpp'
alias npm-ls='npm -g ls --depth=0'
alias npm-outdated='npm outdated -g --depth=0'
alias alarm='termdown'
alias clock='termdown'
alias image-dimensions="identify -format 'width: %w\nheight: %h\n'"
alias vgit="nvim -c 'Git'" # Open nvim with fugitive
alias sa="ssh-add $HOME/.ssh/id_rsa"
alias get-props='hyprctl clients|rg '
alias get-keys="wev -f wl_keyboard"
alias find-font='pango-list|rg '
alias zref="exec zsh" # reload zshrc
alias :q="exit" # :)
alias pacown='pacman -Qo' # which package owns arg
alias pacorph='paru -Rns $(pacman -Qtdq)' # clear orphans
alias pacls='pacman -Ql' # list package files
alias pacfd="pacman -F" # find file in repos
alias aurls="paru -Qm" # list aur packages

# reload config if the process supports the signal
alias reload='killall -SIGUSR2'

# }}}
# Quick edits: {{{
# ------------------------------------------------------------------------------

alias vialias="${EDITOR:-nvim} $HOME/.zsh.d/aliases.zsh"
alias vibar="${EDITOR:-nvim} $HOME/.config/waybar/modules.jsonc \
  $HOME/.config/waybar/style.css $HOME/.config/waybar/config.jsonc"
alias vienv="${EDITOR:-nvim} $HOME/.zshenv"
alias vifzf="${EDITOR:-nvim} $HOME/.zsh.d/fzf.zsh"
alias vigit="${EDITOR:-nvim} $HOME/.gitconfig"
alias vigtk="${EDITOR:-nvim} $HOME/.gtkrc-2.0 \
  $HOME/.config/gtk-3.0/settings.ini \
  $HOME/.config/gtk-4.0/settings.ini"
alias vihypr="${EDITOR:-nvim} $HOME/.config/hypr/hyprland.conf"
alias viquick="${EDITOR:-nvim} $HOME/notes/quick-notes.md"
alias virofi="${EDITOR:-nvim} $HOME/.config/rofi/config.rasi \
  $HOME/.config/rofi/theme.rasi"
alias vissh="${EDITOR:-nvim} $HOME/.ssh/config"
alias viterm="${EDITOR:-nvim} $HOME/.config/kitty/kitty.conf"
alias vitodo="${EDITOR:-nvim} $HOME/notes/TODOs.md"
alias vivim="${EDITOR:-nvim} -c 'cd $HOME/.config/nvim' $HOME/.config/nvim/"
alias vizsh="${EDITOR:-nvim} $HOME/.zshrc"
alias vizshd="${EDITOR:-nvim} $HOME/.zsh.d"

# }}}
# Global: {{{
# ------------------------------------------------------------------------------
# These work as a replacement inline, not just beginning of command
# |& short hand for piping stdout and stderr

alias -g NL=/dev/null
alias -g SK="&& sudo -K" # clear sudo cache on command success 
alias -g G='| rg'
alias -g H='|& head'
alias -g T='|& tail'
alias -g A='| tee -a' # append to file
alias -g P='|& $PAGER'
alias -g X='| xargs'
alias -g C="| wl-copy"
alias -g J='| jq .'

#}}}
# Suffix: {{{
# ------------------------------------------------------------------------------
# example: type 'test.yml' opens vim with test.yml as active buffer.

alias -s {yml,json,txt,tex,css,ts,js,html,md,handlebars,hbs}="${EDITOR:-nvim}"
alias -s {com,net,org,io}=firefox

# }}}

# vim: set ts=2 sw=2 tw=80 fdm=marker et :
