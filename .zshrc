# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/home/eva/.rbenv/plugins/ruby-build/bin:/home/eva/.rbenv/shims:/home/eva/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
source $ZSH/oh-my-zsh.sh
export TLY_BACKUPS="/home/eva/Documents/Touristly.work/Backups"

export EDITOR='vim'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## ZSH CONFIG
## ----------------------------------------------------------------

alias zr=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshrc="vim ~/.zshrc && zr"
alias vimrc="vim ~/.vimrc.after"

#terminal support 256-color
export TERM="xterm-256color"

#warning if doing a 'rm *'
setopt RM_STAR_WAIT

## TERMINAL
## ----------------------------------------------------------------

alias clearcache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches" && echo Cache cleared'
alias bleachcache='sudo bleachbit -c firefox.cache chromium.cache libreoffice.cache apt.autoclean apt.autoremove system.trash system.cache system.tmp '
alias syscleanup='clearcache; bleachcache'
alias tkill='tmux kill-session && echo "tmux session killed"'
alias tly='teamocil --here tly'
alias jfs='teamocil --here jfs'
alias fs='foreman start'
alias o='gnome-open'
alias ag=' ag -iC 3'

function zreload() {
  echo "Restarting Zeus services..."
  tmux send-keys -t tly-server.2 C-c
  tmux send-keys -t tly-server.1 C-c
  sleep 2
  tmux send-keys -t tly-server.2 'zet' ENTER
  tmux send-keys -t tly-server.1 'sleep 2 && zes' ENTER
  echo "Zeus reloaded!"
}

# fix tmate / tmux version mismatch
if [[ $TMUX =~ tmate ]]; then alias tmux=tmate; fi

## SAVED DIRECTORY
## ----------------------------------------------------------------

alias ..fend='cd /home/eva/Documents/Touristly.work/tly-frontend'
alias ..bend='cd /home/eva/Documents/Touristly.work/tly-backend'
alias ..tools='cd /home/eva/Documents/Touristly.work/tools'
alias ..jfs='cd /home/eva/Documents/jfs_app'

## GIT FLOW
## ----------------------------------------------------------------
alias gfs='git flow feature start'
alias gff='git flow feature finish'
alias gfd='git flow feature delete'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'

# Start and finish new release
function gfrsf() {
  echo "Starting and finishing new release"
  git flow release start $1
  git flow release finish $1
}

# Get branch name in underscores
# Useful for Git-aware database.yml in Rails
function gbdb() {
  app_env=`rails r "print Rails.env"`
  feature_branch=`echo "$(current_branch)" | tr '-' '_' | tr '/' '_'`
  project_prefix="tly"

  echo "Project prefix has been set to \"tly\""
  echo "BRANCH NAME: ${project_prefix}_${app_env}_${feature_branch}"
}

## GIT
## ----------------------------------------------------------------

if [[ "$(pwd)" == /home/eva/Documents/Touristly.work/tly-frontend ]]; then
  alias gl..='zr; git pull && npm install && bower install'
else
  alias gl..='zr; git pull && bundle install && rake db:migrate'
fi

alias gcleanup='git branch --merged develop | grep -v develop | xargs git branch -d'
alias gl#='git log -1 --pretty=%B | tail -n 2 | pbcopy'


## ZEUS
## ----------------------------------------------------------------
alias zet='zeus start'
alias zes='zeus s'
alias zec='zeus c'
alias zrm='rm .zeus.sock'
alias railslog='tail -f log/development.log'

## EMBER / NPM / BOWER
## ----------------------------------------------------------------
alias ebs='ember serve'

## Copy Paste
## ----------------------------------------------------------------
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

## SSH
## ----------------------------------------------------------------
alias sshshow='cat ~/.ssh/id_rsa.pub'
alias sshcopy='cat ~/.ssh/id_rsa.pub | pbcopy; echo "Copied SSH public key to clipboard."'
