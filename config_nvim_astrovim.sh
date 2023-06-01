#!/bin/bash
set -u

echo "cleaning nvim from system"
sudo rm -r ~/.config/nvim
sudo rm -r ~/.local/state/nvim
sudo rm -r ~/.local/share/nvim
sudo rm ~/nvim.appimage

echo "reinstalling nvim and astrovim"
cd ~/
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Set defaults 
export CUSTOM_NVIM_PATH=~/
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110

git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

git clone git@github.com:ryanoasis/nerd-fonts.git ~/nerd-fonts/ --depth 1
./install ./install.sh ShareTechMono
 
~/nvim.appimage ~/.config/nvim/lua/plugins/core.lua
