#!/bin/bash
set -ue

echo "INFO: cleaning nvim from system"
sudo rm -r ~/.config/nvim || echo "INFO: ~/.config/nvim probably doesn't exist, therefore not deleting"
sudo rm -r ~/.local/state/nvim || echo "INFO: ~/.local/state/nvim probably doesn't exist, therefore not deleting"
sudo rm -r ~/.local/share/nvim || echo "INFO: ~/.local/share/nvim probably doesn't exist, therefore not deleting"
sudo rm ~/nvim.appimage || echo "INFO: "

echo "INFO: Installing nvim"
mkdir ~/repos
cd ~/repos
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

echo "INFO: Lazy loading astrovim and lazy"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Set defaults 
echo "INFO: Setting vim defaults"
export CUSTOM_NVIM_PATH=~/
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110

echo "INFO: initializing git, password must be entered"
ssh-start || echo "INFO: failed to initialize ssh agent, alias probably isn't set in ~/.bashrc"
git clone git@github.com:twnbay78/astrovim_config.git ~/.config/nvim/lua/user

echo "INFO: installing patched font"
git clone git@github.com:ryanoasis/nerd-fonts.git ~/repos/nerd-fonts/ --depth 1
chmod u+x ~/repos/nerd-fonts/install.sh
~/repos/nerd-fonts/install.sh ShareTechMono

echo "INFO: Installing TS syntax highlighter, LSP and debugger for Python"
vim --headless +DapInstall python +q
vim --headless +TsInstall python +q
vim --headless +LspInstall pyright +q
 
echo "INFO: taking it out on a test drive"
vim ~/.config/nvim/lua/plugins/core.lua
