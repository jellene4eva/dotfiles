#!/bin/sh

if [ ! -f "$HOME/.zshrc" ]; then
  touch ~/.zshrc
fi

if [ ! -f "$HOME/.tmux.conf" ]; then
  touch ~/.tmux.conf
fi

if [ ! -f "$HOME/.vimrc.local" ]; then
  touch ~/.vimrc.local
fi

if [ ! -f "$HOME/.vimrc" ]; then
  touch ~/.vimrc
fi

if [ ! -f "$HOME/.teamocil" ]; then
  touch ~/.teamocil
fi

if [ ! -f "$HOME/.tigrc" ]; then
  touch ~/.tigrc
fi

for i in `find $(pwd)/ -maxdepth 1`; do
  original_file=`basename $i`
  if [ -f "$HOME/.${original_file}" ]; then
    ln -snfv $i ~/.${original_file}
  fi
done
