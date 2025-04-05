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

# System: {{{1

# Set up nohup so that it can deal with an argument that is itself an alias
# name:
alias nohup="nohup "

alias ~~="$HOME/.backup/home/$USER"

# Clear cached sudo password
alias suk="sudo -K"

#}}}
# Shadow: {{{
# Aliases that shadow some command. These are usually for setting certain flags
# by default, like --preserve-root, interactive etc that I don't want to type
# every time.
# --------

alias jobs='jobs -l'
alias ncdu='ncdu --color dark'
alias mutt='neomutt'
alias tree="tree -ah"
alias free='free -h'
alias locate='locate -i' # ignore case always

# Keeping these as comments, not sure of the consequences yet
# alias tmux="tmux -2" # force 256 color mode in tmux
# alias grep='rg'
# alias stow="stow -v"

# print du/df tallies in human readable
alias du='du -h'
alias df='df -h'
alias dut='du -ht'

# alias ssh='env TERM=xterm-256color ssh'

alias pgrep='pgrep -ia'
alias diff='colordiff'

alias mv='mv -iv'
alias rm='rm -Iv --one-file-system'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# get top process eating cpu
alias ps-cpu-full='ps auxf | sort -nr -k 3'
alias ps-cpu='ps auxf | sort -nr -k 3 | head -10'

# create parents, be verbose
alias mkdir='mkdir -pv'

# use neovim
alias vim='nvim'
alias vi="nvim"

#}}}
# Logging: {{{

alias log-ssh='journalctl _COMM=sshd'

#}}}
# Quick edits: {{{

alias vialias="${EDITOR:-vim} ~/etc/conf/zsh/.zsh.d/aliases.zsh"
alias vibar="${EDITOR:-vim} ~/etc/conf/waybar/.config/waybar/config.jsonc ~/etc/conf/waybar/.config/waybar/style.css"
alias vibinds="${EDITOR:-vim} ~/.xbindkeysrc"
alias vidunst="${EDITOR:-vim} ~/etc/templates/dunst/config.dunst"
alias vienv="${EDITOR:-vim} ~/etc/conf/zsh/.zshenv"
alias vifzf="${EDITOR:-vim} ~/etc/conf/zsh/.zsh.d/fzf.zsh"
alias vigitc="${EDITOR:-vim} ~/etc/conf/git/.gitconfig"
alias vigtk="${EDITOR:-vim} ~/.gtkrc-2.0 ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini"
alias vihosts="${EDITOR:-vim} /etc/hosts"
alias vimake="${EDITOR:-vim} ~/etc/Makefile"
alias vimime="${EDITOR:-vim} ~/etc/conf/desktop/.config/mimeapps.list"
alias viquick="${EDITOR:-vim} ~/notes/quick-notes.md"
alias virofi="${EDITOR:-vim} ~/etc/templates/rofi/config.rofi"
alias vissh="${EDITOR:-vim} ~/.ssh/config"
alias visway="${EDITOR:-vim} ~/etc/templates/sway/config.sway"
alias vihypr="${EDITOR:-vim} ~/etc/conf/hyprland/.config/hypr/hyprland.conf"
alias viterm="${EDITOR:-vim} ~/etc/conf/kitty/.config/kitty/kitty.conf"
alias vitmux="${EDITOR:-vim} ~/etc/conf/tmux/.tmux.conf"
alias vitodo="${EDITOR:-vim} ~/notes/TODOs.md"
alias vivars="${EDITOR:-vim} ~/etc/templates/i3/variables.i3 ~/etc/local/$(hostname)/variables.mk"
alias vivim="${EDITOR:-vim} ~/etc/conf/vim/.vimrc"
alias viws="${EDITOR:-vim} ~/etc/conf/i3wsr/.config/i3wsr/config.toml"
alias vixinit-local="${EDITOR:-vim} ~/.xinitrc.local"
alias vixinit="${EDITOR:-vim} ~/etc/conf/x/.xinitrc"
alias vixres="${EDITOR:-vim} ~/etc/conf/x/.Xresources"
alias vizopts="${EDITOR:-vim} ~/etc/conf/zsh/.zsh.d/options.zsh"
alias vizsh="${EDITOR:-vim} ~/etc/conf/zsh/.zshrc"

#}}}
# Find: {{{1

alias ag="ag --smart-case --color-line-number '0;37' --color-match '1;35' --color-path '0;34' --hidden -p ~/.globalignore"
alias rg="rg --smart-case --colors 'match:fg:magenta' --colors 'match:style:bold' --colors 'line:fg:white' --colors 'path:fg:blue' --colors 'column:fg:8'"

alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# grep command history quickly
alias hist-grep="cat ~/.histfile | ag"
alias ls-path='echo -e ${PATH//:/\\n}'
alias ls-fpath='tr " " "\n" <<< $fpath'

alias ps-grep='ps aux|head -n 1 && ps aux|ag'

alias awk='gawk'
alias find-here='find . -name'
alias fd='fd --hidden'

# lists most recent last
alias lsr='\ls -Atr'

#}}}
# Web search: {{{1

alias @aur='googler -w aur.archlinux.org'
alias @aw='googler -w wiki.archlinux.org'
alias @yt='googler -w youtube.com'
alias @w='googler -w en.wikipedia.org'
alias @xkcd='googler -w xkcd.com'
alias @clj='googler -w clojuredocs.org'
alias @gh='googler -w github.com'

#}}}
# Global: {{{1

# These work as a replacement inline, not just beginning of command. i.e
# $ cat file L
# This expands to: cat file | less

alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
# alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

#}}}
# Suffix: {{{1

# example: type 'test.yml' opens vim with test.clj as active buffer.
alias -s {yml,json,txt,tex,css,ts,js,html,md,handlebars,hbs}=vim
alias -s {com,net,org}=firefox

#}}}
# Lists: {{{1

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

#}}}
# Security: {{{1

alias check-rk="sudo rkhunter --update && sudo rkhunter --check --sk && sudo rkhunter --propupd"
alias scan="clamdscan --multiscan --fdpass"

#}}}
# Tmux: {{{1

alias tnew="tmux new-session -s" # start new session by giving a name
alias trw="tmux rename-window"
alias ta="tmux attach -t"
alias tkill="tmux kill-pane -t"
alias tls="tmux ls"
alias tc="tmux choose-session"
alias tk="tmux kill-session -t"
alias tw="tmux new-window -n"  # open new window with name

#}}}
# ASCII: {{{1

alias toilet-list='~/scripts/figlet-list.sh'
alias 3d-text="toilet -t -f 3d"
alias future="toilet -t -f future"
alias rusto="toilet -t -f rusto"
alias rusto-fat="toilet -t -f rustofat"
alias pagga="toilet -t -f pagga"
alias pagga-border="toilet -t -f pagga -F border"
# alias artprint="~/lib/arttime/bin/artprint"
# alias arttime="~/lib/arttime/bin/arttime"

#}}}
# Date/time {{{1

alias gettime='date +"%T"'
alias _now='date +"%Y-%m-%d@%T"'
alias now='date +"%Y-%m-%dT%T"'
alias getdate='date +"%Y-%m-%d"'

#}}}
# Clipboard: {{{1

# See ~/.zshrc plugins
alias copy="clipcopy"
alias paste="clippaste"
alias empty-clipmenu="clipdel -d \".*\""

#}}}
# Utils: {{{1

# watch firefox download progress.
alias watch-firefox="watch progress -wc firefox"

# Cleanly shut down firefox
alias close-firefox-="wmctrl -c firefox"

# extract tar to directory same as filename
alias extract-tar="tar --one-top-level -zxvf"

# list open ports
alias open-ports="netstat -tulanp"

alias pdf="zathura"

# alias fehp='feh -g 640x480 -d -S filename'
alias feh='swayimg'

# Alias to check disk status, use dfc if present, otherwise use df with some formatting
# https://github.com/xero/dotfiles/blob/master/zsh/.zsh/aliases.zsh
if hash dfc 2>/dev/null; then
  alias disks='dfc -W -q mount'
else
  alias disks='echo "╓───── m o u n t . p o i n t s"; echo "╙────────────────────────────────────── ─ ─ "; lsblk -a; echo ""; echo "╓───── d i s k . u s a g e"; echo "╙────────────────────────────────────── ─ ─ "; df -h;'
fi

alias mount-tmp-fs='sudo mount -t tmpfs tmpfs /mnt -o size=1024m'
alias kill-emacs='emacsclient -e "(save-buffers-kill-emacs)"'
alias gpg-reload='gpg-connect-agent reloadagent /bye'

# Get public ip
alias public-ip='curl ipinfo.io/ip'

# Check vpn status
alias ipleak="curl -s https://ipleak.net/json/ | jq '.type'"


# Get weather in oslo
alias weather='curl http://wttr.in/oslo'

alias music='ncmpcpp'

# NPM
alias npm-ls='npm -g ls --depth=0'
alias npm-outdated='npm outdated -g --depth=0'

alias alarm='termdown'
alias clock='termdown'

alias image-dimensions="identify -format 'width: %w\nheight: %h\n'"

#}}}
# Git: {{{1
# --------

alias vigit="vim -c 'Git'"

# if hash hub 2>/dev/null; then
#   alias git='hub'
# fi

alias sa="ssh-add ~/.ssh/id_rsa"

#}}}
# Xorg {{{1

alias select-font='xfontsel -print|clipcopy'

alias update-font-cache='fc-cache -fv'

# delete and or refresh shell confs
alias xrmerge="xrdb -merge ~/.Xresources"
alias xrload="xrdb -load ~/.Xresources"

# Refresh keyboard config. Run setxkbmap again, sometimes ctrl+alt+backspace doesn't work
alias refresh-keyboard='setxkbmap -model pc104 -layout us,no -option grp:caps_toggle -option terminate:ctrl_alt_bksp'

alias get-class="xprop"
alias get-key="xev -event keyboard"

# alias getkeycode=xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'

#}}}
# Wayland: {{{1

alias find-font='pango-list|grep '

alias get-props="wlprop"
alias get-keys="wev -f wl_keyboard"

#}}}
# Miscellaneous: {{{

# Reload zsh config
alias zref="exec zsh"

# quit
alias :q="exit"

# Clears session but keep scrollback, if you want full clear, use clear without
# options.
alias cl='clear -x'


#}}}
# Taskwarrior {{{

alias todos="task +main list"
alias summary="task entry.after:today-1mo list"
alias tui="taskwarrior-tui"

# }}}
# Pacman: {{{1

# show which package owns a given file
alias pacown='pacman -Qo'

# clean orphans
alias pacorph='paru -Rns $(pacman -Qtdq)'

# clean cache
alias pacc='paru -Scc'

# Lists files installed from a given package
alias pacls='pacman -Ql'

# Show which package in db arg belongs to. Useful to identify which package in
# db, but not in system, that a file belongs to.
alias pacfd="pacman -F"

# Shows installed aur packages
alias aurls="paru -Qm"
#}}}
# Audio: {{{1

# list pulseaudio sinks
alias sinks="pacmd list-sinks|grep -Ei 'index:|name:'"

# alias headphones="pacmd set-default-sink 3"
# alias speakers="pacmd set-default-sink 1"

#}}}
# vim: fdm=marker:sw=2
