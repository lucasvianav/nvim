#!/bin/sh

# install neovim, node.js and other dependencies
sudo snap install nvim --beta --classic
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs node-typescript
sudo apt install python3 python3-pip python-neovim python3-neovim npm yarn -y

# install C language server (clangd)
sudo apt install clangd-9 -y
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

# install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# install Vim-Plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy/paste enable
sudo apt install xclip

# install python support
pip3 install -U pynvim neovim-remote

# install node support
sudo npm i -g neovim

# install ranger
sudo apt install ranger -y
pip install -U ueberzug
mkdir -p ~/.config/ranger/plugins/ranger_devicons
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

# install vimtex dependencies and other latex tools
sudo apt install latexmk xdotool -y
sudo apt install -y texlive texlive-font-utils texlive-pstricks-doc
sudo apt install -y texlive-base texlive-formats-extra texlive-lang-portuguese
sudo apt install -y texlive-publishers texlive-bibtex-extra texlive-latex-base
sudo apt install -y texlive-publishers-doc texlive-binaries texlive-latex-base-doc texlive-science
sudo apt install -y texlive-extra-utils texlive-latex-extra texlive-science-doc texlive-fonts-extra
sudo apt install -y texlive-latex-extra-doc texlive-pictures texlive-xetex texlive-fonts-extra-doc
sudo apt install -y texlive-latex-recommended texlive-pictures-doc texlive-fonts-recommended
sudo apt install -y texlive-humanities texlive-lang-english texlive-latex-recommended-doc
sudo apt install -y texlive-fonts-recommended-doc texlive-humanities-doc texlive-luatex
sudo apt install -y texlive-pstricks perl-tk texlive-metapost texlive-metapost-doc

mkdir -p ../autoload ../session

printf "\n\n\n\nSuccessfully installed!"

