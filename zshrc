# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
export ANDROID_HOME=${HOME}/Android/Sdk
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform_tools:${ANDROID_HOME}/emulator:$PATH"
export PATH="$PATH:/usr/lib/jvm/java-8-openjdk/bin"
export PATH="$PATH:/opt/gradle/gradle-4.2.1/bin"

export GDH="$HOME/Code/goodhum"

## SAVED DIRECTORY
## ----------------------------------------------------------------

alias ..gdh='cd $GDH/'

## PROJECT START
## ----------------------------------------------------------------

alias gdh='teamocil --here inf'

## ZSH CONFIG
## ----------------------------------------------------------------

alias zr=". ~/dotfiles/zshrc && echo 'ZSH config reloaded'"
alias zshrc="vim ~/dotfiles/zshrc && zr"
alias tmuxrc="vim ~/dotfiles/tmux.conf"
alias vimrc="vim ~/dotfiles/vimrc.local"

## CUSTOM SCRIPTS ~/Scripts
## ----------------------------------------------------------------

alias httpsserver="~/Scripts/https-server.py"

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
alias o='gnome-open'
alias ag=' ag -iC 3'

## GIT
## ----------------------------------------------------------------

function gcleanup() {
  echo "Cleaning up $1 ..."
  git branch --merged $1 | grep -v "(^\*|master|develop|$1)" | xargs git branch -d
}

alias gl#='git log -1 --pretty=%B | grep "#" | pbcopy'
alias ggpush!='git push --force-with-lease origin $current_branch'



## PYTHON
## ----------------------------------------------------------------
alias src='source env/bin/activate'
alias djsh='python manage.py shell'
alias djsh+='python manage.py shell_plus'


## Copy Paste
## ----------------------------------------------------------------
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

## SSH
## ----------------------------------------------------------------
alias sshshow='cat ~/.ssh/id_rsa.pub'
alias sshcopy='cat ~/.ssh/id_rsa.pub | pbcopy; echo "Copied SSH public key to clipboard."'


## TIG
## ----------------------------------------------------------------

alias tiga='tig --all'
alias ts='tig status'


export PATH="$HOME/.bin:$PATH"

export NVM_DIR="/home/jellene/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nv
