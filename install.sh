#!/bin/sh

# install neovim
sudo apt install neovim python-neovim python3-neovim -y

# install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# install Vim-Plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy/paste enable
sudo apt install xclip

# install python support
pip install pynvim

# install node support
npm i -g neovim

# install ranger
sudo apt install ranger
pip install ueberzug
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

