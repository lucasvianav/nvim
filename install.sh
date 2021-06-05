#!/bin/sh

# install neovim, node.js and other dependencies
sudo snap install nvim --beta --classic
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install python3 python-neovim python3-neovim npm yarn -y

# install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# install Vim-Plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy/paste enable
sudo apt install xclip

# install python support
pip install -U pynvim doq

# install node support
npm i -g neovim

# install ranger
sudo apt install ranger
pip install -U ueberzug
mkdir -p ~/.config/ranger/plugins/ranger_devicons
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

mkdir autoload session

echo 
echo 
echo 
echo 
echo 
echo "Successfully installed!"
echo "In VSCode, point your init.vim path to \"\$HOME/.config/nvim/\""

