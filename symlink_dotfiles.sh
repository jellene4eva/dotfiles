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

for i in `find $(pwd)/ -maxdepth 1`; do
  original_file=`basename $i`
  if [ -f "$HOME/.${original_file}" ]; then
    ln -snfv $i ~/.${original_file}
  fi
done
