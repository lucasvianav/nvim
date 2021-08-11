#!/bin/sh

# install neovim, node.js and other dependencies
sudo snap install nvim --beta --classic
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs node-typescript python3 python3-pip python-neovim
sudo apt install -y python3-neovim npm yarn fzf ripgrep silversearcher-ag
sudo apt install -y xclip clangd-9 ranger

mkdir session

# install C language server (clangd)
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

# install Vim-Plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install python support
pip3 install -U pynvim neovim-remote

# install node support + eslint
sudo npm i -g neovim eslint

# install ranger
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

# sets plugins up
# nvim --headless +PlugUpgrade +q
# nvim --headless +PlugInstall +q
# nvim --headless +PlugUpdate +q
# nvim --headless +CocStart +CocUpdate +q

# install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

printf "\n\n\n\nSuccessfully installed!"

