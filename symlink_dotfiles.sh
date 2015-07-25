#!/bin/sh

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

for i in `find $(pwd)/ -maxdepth 1`; do
  original_file=`basename $i`
  if [ ! -f "$HOME/.${original_file}" ]; then
    touch "$HOME/.${original_file}"
  else
    ln -snfv $i ~/.${original_file}
  fi
done
