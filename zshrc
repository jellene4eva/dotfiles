# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
export ANDROID_HOME="/home/jellene/Android/Sdk"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform_tools:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export TLY="$HOME/Code/tly"
export YGM="$HOME/Code/ygm"
export INF="$HOME/Code/infinity"
export TLY_BACKUPS="$TLY/Backups"

## SAVED DIRECTORY
## ----------------------------------------------------------------

alias ..fend='cd $TLY/tly-frontend'
alias ..bend='cd $TLY/tly-backend'
alias ..tools='cd $TLY/tools'
alias ..jfs='cd $HOME/Code/jfs_app'
alias ..ygm='cd $YGM/yogame'
alias ..ygi='cd $YGM/yogame-ui'
alias ..inf='cd $INF/magicloud-inf'

## PROJECT START
## ----------------------------------------------------------------

alias tly='teamocil --here tly'
alias jfs='teamocil --here jfs'
alias ygm='teamocil --here ygm'
alias inf='teamocil --here inf'

## ZSH CONFIG
## ----------------------------------------------------------------

alias zr=". ~/dotfiles/zshrc && echo 'ZSH config reloaded'"
alias zshrc="vim ~/dotfiles/zshrc && zr"
alias tmuxrc="vim ~/dotfiles/tmux.conf"
alias vimrc="vim ~/dotfiles/vimrc.local"

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
alias fs='foreman start -f Procfile.dev'
alias o='gnome-open'
alias ag=' ag -iC 3'

# fix tmate / tmux version mismatch
if [[ $TMUX =~ tmate ]]; then alias tmux=tmate; fi

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

## GIT
## ----------------------------------------------------------------

if [[ "$(pwd)" == $TLY/tly-frontend ]]; then
  alias gl..='git pull && npm install && bower install'
else
  alias gl..='git pull && bundle install && rake db:migrate'
fi

alias gcleanup='git branch --merged develop | grep -v develop | xargs git branch -d'
alias gl#='git log -1 --pretty=%B | grep "#" | pbcopy'


## ZEUS
## ----------------------------------------------------------------
alias zet='zeus start'
alias zes='zeus s'
alias zec='zeus c'
alias zrm='rm $TLY/tly-backend/.zeus.sock'
alias railslog='tail -f log/development.log'
function fsr() {
  tmux send-keys -t server.2 C-c Enter
  sleep 2
  tmux send-keys -t server.2 "fs" Enter
}

## PYTHON
## ----------------------------------------------------------------
alias src='source env/bin/activate'
alias djsh='python manage.py shell'
alias djsh+='python manage.py shell_plus'

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


## MYSQL (https://github.com/kriskhaira/dotfiles/blob/master/zshrc.local)
### ---------------------------------------------------------------

# Get branch name in underscores
# Useful for Git-aware database.yml in Rails
# Requires prefix as the param (without underscore)
function gbdb() {
  app_env=`rails r "print Rails.env"`
  feature_branch=`echo "$(current_branch)" | tr '-' '_' | tr '/' '_'`
  project_prefix=$1

  if [[ "$app_env" = 'development' ]]; then
    app_env="dev"
  fi

  echo "${project_prefix}_${app_env}_${feature_branch}"
}

# Requires prefix as the param (without underscore)
function setupgbdb() {
  BRANCH_DB=$(gbdb $1)
  mysqlcopydb $1_dev_develop $BRANCH_DB
}

function mysqlcopydb() {
  DBSNAME=$1
  DBNAME=$2

  fCreateTable=""
  fInsertData=""
  echo "Copying database ... (may take a while ...)"
  echo "DROP DATABASE IF EXISTS ${DBNAME}" | mysql --login-path=touristly
  echo "CREATE DATABASE ${DBNAME}" | mysql --login-path=touristly
  for TABLE in `echo "SHOW TABLES" | mysql --login-path=touristly $DBSNAME | tail -n +2`; do
    createTable=`echo "SHOW CREATE TABLE ${TABLE}"|mysql --login-path=touristly -B -r $DBSNAME|tail -n +2|cut -f 2-`
    fCreateTable="${fCreateTable} ; ${createTable}"
    insertData="INSERT INTO ${DBNAME}.${TABLE} SELECT * FROM ${DBSNAME}.${TABLE}"
    fInsertData="${fInsertData} ; ${insertData}"
  done &&
  echo "$fCreateTable ; $fInsertData" | mysql --login-path=touristly $DBNAME
}


## TIG
## ----------------------------------------------------------------

alias tiga='tig --all'
alias ts='tig status'


export PATH="$HOME/.bin:$PATH"

export NVM_DIR="/home/jellene/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
