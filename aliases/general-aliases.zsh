#!/usr/bin/env zsh
# General aliases for common commands

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
alias h="cd ~"
alias tmp="cd /tmp"

# Directory listing
alias ls='ls -G'                  # colorize output
alias ll='ls -lh'                 # list long with human-readable sizes
alias la='ls -lah'                # list all (including hidden)
alias lt='ls -lahtr'              # list all by time (recent at bottom)
alias lsa='ls -lahd .*'           # list only hidden files
alias l.='ls -d .*'               # list only hidden files
alias lsd='ls -lhd *(-/DN)'       # list only directories

# File operations
alias rm='rm -i'                  # confirm before deleting
alias cp='cp -i'                  # confirm before overwriting
alias mv='mv -i'                  # confirm before overwriting
alias mkdir='mkdir -p'            # create parent directories as needed

# Grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Process management
alias psa='ps aux'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psp='ps -f -u $USER'
alias mem='free -m -l -t'

# System info
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'
alias df='df -h'                  # human-readable sizes
alias du='du -h'                  # human-readable sizes

# Network
alias myip='curl ipinfo.io/ip'    # external IP
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias lsnet='sudo lsof -i'        # list internet connections
alias ports='netstat -tulanp'     # show listening ports
alias ping='ping -c 5'            # only send 5 pings

# Disk usage
alias diskspace="df -h"
alias foldersize="du -sh"
alias usage="du -h -d1"

# Date and time
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias nowtime='date +"%T"'

# Reload configurations
alias reload='source ~/.zshrc'
alias updatedb='sudo updatedb'

# Convenience
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
alias vi='vim'

# Archive extraction
function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <file>"
    return 1
  fi
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1    ;;
      *.tar.gz)    tar xzf $1    ;;
      *.bz2)       bunzip2 $1    ;;
      *.rar)       unrar e $1    ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xf $1     ;;
      *.tbz2)      tar xjf $1    ;;
      *.tgz)       tar xzf $1    ;;
      *.zip)       unzip $1      ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7z x $1       ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show aliases
alias aliases="alias | sort"