#!/bin/sh

# run after cloning repo to ~/.dotfiles

cd ~

for f in `ls -A .dotfiles/ | grep -vE 'init\.sh|\.git/?$|\.gitmodules'`; do
  ln -s .dotfiles/$f
done

for f in .bash_history .mysql_history .psql_history .sqlite_history; do
  rm -f ~/$f
  ln -s /dev/null ~/$f
done
