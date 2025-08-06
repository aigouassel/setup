#!/usr/bin/env zsh
# Custom aliases for common commands

# Navigation shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
alias h="cd ~"
alias tmp="cd /tmp"
alias ..="cd .."
alias ...="cd ../.."

# Directory listing
alias ls='ls -G'                  # colorize output
alias ll='ls -lh'                 # list long with human-readable sizes
alias la='ls -lah'                # list all (including hidden)

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Network utilities
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

# Convenience
alias path='echo -e ${PATH//:/\\n}'
alias reload='source ~/.zshrc'

# Show all aliases
alias aliases="alias | sort"

# Git shortcuts
alias gamend='git commit --amend --no-edit'

# Read JSONLite files
alias jsonl="cat file.jsonl | jq '.'"