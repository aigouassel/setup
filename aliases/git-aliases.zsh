#!/usr/bin/env zsh
# Git aliases with g-prefix for faster workflow

# Basic git commands
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcl='git clone'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gm='git merge'
alias gr='git rebase'

# Branch commands
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbr='git branch --remote'

# Log commands
alias gl='git log'
alias glg='git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias glo='git log --oneline --decorate'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --all'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Diff commands
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias gdtool='git difftool'

# Reset commands
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grs='git reset --soft'
alias grv='git revert'
alias gru='git reset --'

# Stash commands
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstall='git stash --all'

# Remote commands
alias gra='git remote add'
alias grr='git remote remove'
alias grv='git remote -v'
alias gpu='git push -u origin'
alias gpf='git push --force-with-lease'

# Working with files
alias grm='git rm'
alias grmr='git rm -r'

# Tag commands
alias gt='git tag'
alias gtl='git tag -l'
alias gta='git tag -a'
alias gtd='git tag -d'

# Show commands
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'

# Additional utility aliases
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gclean='git clean -fd'

# Workflow-focused aliases
alias gnew='git checkout -b'
alias gundo='git reset --soft HEAD~1'
alias gamend='git commit --amend --no-edit'
alias gfix='git commit --fixup'
alias gsup='git status --untracked-files=no'
alias gfetch='git fetch --all --prune'

# Show aliases
alias galias="alias | grep 'git' | sort"