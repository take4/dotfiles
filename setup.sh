#!/bin/bash

DOT_FILES=(.vimrc .tmux.conf .zshrc .gitconfig .gitignore .railsrc)

for file in ${DOT_FILES[@]}

do
  if [ -a $HOME/$file ]; then
    echo "Skip! ($file is existed.)"
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
  fi
done
