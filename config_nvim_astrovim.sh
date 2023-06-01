#!/bin/bash
set -ue

echo "cleaning nvim from system"
sudo rm -r ~/.config/nvim || echo "~/.config/nvim probably doesn't exist, therefore not deleting"
sudo rm -r ~/.local/state/nvim || echo "~/.local/state/nvim probably doesn't exist, therefore not deleting"
sudo rm -r ~/.local/share/nvim || echo "~/.local/share/nvim probably doesn't exist, therefore not deleting"
sudo rm ~/nvim.appimage || echo ""

echo "reinstalling nvim and astrovim"
cd ~/
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Set defaults 
echo "Setting vim defaults"
export CUSTOM_NVIM_PATH=~/
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110

echo "Initializing astrovim"
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

echo "installing patched font"
git clone git@github.com:ryanoasis/nerd-fonts.git ~/nerd-fonts/ --depth 1
./install ./install.sh ShareTechMono

echo "Installing TS syntax highlighter, LSP and debugger for Python"
vim --headless +DapInstall python +q
vim --headless +TsInstall python +q
vim --headless +LspInstall pyright +q
 
vim ~/.config/nvim/lua/plugins/core.lua
