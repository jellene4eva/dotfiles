cd
  mkdir -p ~/Scripts

    curl -L  https://raw.githubusercontent.com/jellene4eva/dotfiles/master/setup_laptop.sh -o ~/Scripts/setup_laptop.sh
    curl -L  https://raw.githubusercontent.com/jellene4eva/dotfiles/master/laptop.local -o ~/Scripts/laptop.local

    chmod 700 ~/Scripts/*

    source ~/.bashrc

    ~/Scripts/setup_laptop.sh
