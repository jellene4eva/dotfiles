#!/bin/bash

#Welcome to Jellene's laptop script! This script is inspired by
# thoughbot's discontinued linux laptop script. This script will
# install development essentials on your laptop and make it awesome! <3


# Shared functions
fancy_echo() {
  printf "\n%b\n" "$1"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="$2"

  if [[ -w "$HOME/.zshrc.local" ]]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if (( skip_new_line )); then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}


#Trap
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

#Create .zshrc and .bin files for later
if [[ ! -d "$HOME/.bin/" ]]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

#Install aptitude to maintain packages
fancy_echo "Updating system packages ..."
  if command -v aptitude >/dev/null; then
    fancy_echo "Using aptitude ..."
  else
    fancy_echo "Installing aptitude ..."
    sudo apt-get install -y aptitude
  fi

  sudo aptitude update

#----------------------------------
# APT Package installation
#
fancy_echo "Installing git, for source control management ..."
  sudo aptitude install -y git

fancy_echo "Installing vim, best editor ever! ..."
  sudo aptitude install -y vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall &> /dev/null

fancy_echo "Installing libraries for common gem dependencies ..."
  sudo aptitude install -y curl zlib1g-dev build-essential libyaml-dev libssl-dev libxslt1-dev libcurl4-openssl-dev libksba8 libksba-dev libqtwebkit-dev libreadline-dev libxml2-dev

fancy_echo "Installing sqlite, a common database used by Ruby On Rails ..."
  sudo aptitude install -y sqlite3 libsqlite3-dev

fancy_echo "Installing Postgres, a good open source relational database ..."
  sudo aptitude install -y postgresql postgresql-server-dev-all

fancy_echo "Installing ImageMagick, to crop and resize images ..."
  sudo aptitude install -y imagemagick

fancy_echo "Installing zsh, a better more customizable terminal ..."
  sudo aptitude install -y zsh

fancy_echo "Installing node, to render the rails asset pipeline ..."
  sudo aptitude install -y nodejs

fancy_echo "Installing checkinstall, for easy package removal ..."
  sudo aptitude install -y checkinstall

#Switch to zsh shell
fancy_echo "Changing your shell to zsh ..."
  sudo chsh -s $(which zsh)

fancy_echo "Installing Oh-My-Zsh plugin for zsh ..."
  sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


#------------------------------------
# Silver Searcher (ag) Installation
#
silver_searcher_from_source() {
  git clone git://github.com/ggreer/the_silver_searcher.git /tmp/the_silver_searcher
  sudo aptitude install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
  sh /tmp/the_silver_searcher/build.sh
  cd /tmp/the_silver_searcher
  sh build.sh
  sudo make install
  cd
  rm -rf /tmp/the_silver_searcher
}

if ! command -v ag >/dev/null; then
  fancy_echo "Installing The Silver Searcher (better than ack or grep) to search the contents of files ..."

  if aptitude show silversearcher-ag &>/dev/null; then
    sudo aptitude install silversearcher-ag
  else
    silver_searcher_from_source
  fi
fi

#------------------------------------
# rbenv Installation
#
if [[ ! -d "$HOME/.rbenv" ]]; then
  fancy_echo "Installing rbenv, to change Ruby versions ..."
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

    append_to_zshrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
    append_to_zshrc 'eval "$(rbenv init - zsh --no-rehash)"' 1

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init - zsh)"
fi

if [[ ! -d "$HOME/.rbenv/plugins/rbenv-gem-rehash" ]]; then
  fancy_echo "Installing rbenv-gem-rehash so the shell automatically picks up binaries after installing gems with binaries..."
    git clone https://github.com/sstephenson/rbenv-gem-rehash.git \
      ~/.rbenv/plugins/rbenv-gem-rehash
fi

if [[ ! -d "$HOME/.rbenv/plugins/ruby-build" ]]; then
  fancy_echo "Installing ruby-build, to install Rubies ..."
    git clone https://github.com/sstephenson/ruby-build.git \
      ~/.rbenv/plugins/ruby-build
fi


#------------------------------------
# Ruby Installation
#
ruby_version="$(curl -sSL http://ruby.thoughtbot.com/latest)"

fancy_echo "Installing Ruby $ruby_version ..."
  rbenv install -s "$ruby_version"

fancy_echo "Setting $ruby_version as global default Ruby ..."
  rbenv global "$ruby_version"
  rbenv rehash

fancy_echo "Updating to latest Rubygems version ..."
  gem update --system

fancy_echo "Installing Bundler to install project-specific Ruby gems ..."
  gem install bundler --no-document --pre

fancy_echo "Configuring Bundler for faster, parallel gem installation ..."
  number_of_cores=$(nproc)
  bundle config --global jobs $((number_of_cores - 1))

#---------------------------------------
# Tmux installation
#

mkdir ~/Applications

git clone git@github.com:tmux/tmux.git ~/Applications
cd ~/Applications/tmux
sh autogen.sh
./configure && make
checkinstall -y sudo make install

#---------------------------------------
# lnav installation
#

git clone git@github.com:tstack/lnav.git ~/Applications
cd ~/Applications/lnav
./configure && make
checkinstall -y sudo make install

#---------------------------------------
# tig installation
#

git clone git@github.com:jonas/tig.git ~/Applications
cd ~/Applications/tig
./configure && make
checkinstall -y sudo make install

#------------------------------------
# All other personal installation will be installed from .laptop.local
#
fancy_echo "Installing your personal additions from ~/.laptop.local ..."
  source ~/Scripts/laptop.local

