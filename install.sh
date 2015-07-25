cd
  mkdir -p ~/dotfiles

    curl -L  https://github.com/jellene4eva/dotfiles/blob/master/setup_laptop.sh -o ~/dotfiles/setup_laptop.sh
    curl -L  https://github.com/jellene4eva/dotfiles/blob/master/laptop.local -o ~/.laptop.local

    chmod 700 ~/dotfiles/*

    source ~/.bashrc

    ~/dotfiles/setup_laptop.sh
