#!/bin/bash

### Instalamos paquetes necesarios ######

sudo pacman -S --noconfirm --needed zsh        
sudo pacman -S --noconfirm --needed zsh-doc
sudo pacman -S --noconfirm --needed zsh-autosuggestions
sudo pacman -S --noconfirm --needed zsh-completions
sudo pacman -S --noconfirm --needed zsh-history-substring-search
sudo pacman -S --noconfirm --needed zsh-lovers
sudo pacman -S --noconfirm --needed zsh-syntax-highlighting
sudo pacman -S --noconfirm --needed zshdb
sudo pacman -S --noconfirm --needed zsh-theme-powerlevel10k

sudo pacman -S --noconfirm --needed lsd
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed fzf

##### Instalamos zsh #######

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sed -i .tmp 's/\~\/.oh-my-zsh\}$/\~\/.zsh\/.oh-my-zsh\}/g' install.sh
sh install.sh &>/dev/null &
sleep 20
rm -rf install.sh.tmp
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.zsh/.oh-my-zsh/themes/powerlevel10k
sed -i .tmp 's/robbyrussell/powerlevel10k\/powerlevel10k/1' .zshrc
rm -rf .zshrc.tmp

