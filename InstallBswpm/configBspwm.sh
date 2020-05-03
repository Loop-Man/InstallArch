#!/bin/bash

echo "Folders and files configuration"

echo "Creating Directories..."

if [ ! -d "~/.config" ] 
then
    mkdir -p ~/.config
fi

if [ ! -d "~/.vim" ]
then
    mkdir -p ~/.vim
    mkdir -p ~/.vim/undodir
    mkdir -p ~/.vim/swp
    mkdir -p ~/.vim/bundle
fi

if [ ! -d "/etc/pacman.d/hooks" ]
then
    sudo mkdir -p /etc/pacman.d/hooks
fi

echo "Copying Files to HOME ..."

cp .bashrc ~/.
cp .tmux.conf ~/.
cp vim/vimrc ~/.vim
cp .Xresources ~/.
cp .xinitrc ~/.
cp .Xdefaults ~/.

echo "Copying config files to .config folder..."

cp -r config/bspwm ~/.config/
cp -r config/polybar ~/.config/
cp -r config/Thunar ~/.config/
cp -r config/variety ~/.config/

echo "Copying wallpapers"

### Ruta para las imágenes del gestor de login, no funciona en ruta usuario
### El fichero desde donde se llaman es lightdm-gtk-greeter.conf
if [ ! -d "/opt/backgrounds/icons" ]
then
    sudo mkdir -p /opt/backgrounds/icons
fi

sudo -- sh -c 'cp -r backgrounds/background.png /opt/backgrounds/'
sudo -- sh -c 'cp -r backgrounds/icons/cyberninja.jpg /opt/backgrounds/icons/'

if [ ! -d "~/backgrounds" ]
then
    mkdir -p ~/backgrounds
fi
cp -r backgrounds/* ~/backgrounds/

echo "Setting permissions..."

cd ~/.config/bspwm/
chmod +x bspwmrc autostart.sh
cd ~/.config/polybar
chmod +x launch.sh
cd ~/.config/polybar/scripts
chmod +x get_ip.sh vpn_status.sh connected.sh
cd ~/.config/bspwm/scripts/
chmod +x bspwm_resize picom-toggle.sh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sleep 5

echo 'Setting /etc and /usr config files'
cd ~/InstallArch/InstallBswpm/
sudo cp oblogout.conf /etc/
sudo cp -r solarized-squares64/ /usr/share/themes/

sleep 5

echo "Setting some configuration..."
sudo updatedb # Update mlocate db
sudo localectl set-x11-keymap es # Set the keyboard map
# Config lightdm
sudo cp lightdm-gtk-greeter.conf /etc/lightdm/
# Config pacman
sudo cp mirrorupgrade.hook /etc/pacman.d/hooks/
sudo cp pacman.conf /etc/
# Config ArchStrike
# https://archstrike.org/wiki/setup
sudo pacman -Syy

sudo pacman-key --init
sudo dirmngr < /dev/null
sudo wget https://archstrike.org/keyfile.asc
sudo pacman-key --add keyfile.asc
sudo pacman-key --lsign-key 9D5F1C051D146843CDA4858BDE64825E7CBC0D51
sudo rm keyfile.asc

sudo pacman -S --noconfirm --needed archstrike-keyring
sudo pacman -S --noconfirm --needed archstrike-mirrorlist

sudo sed -i 's/.*mirror.archstrike.*/Include = \/etc\/pacman.d\/archstrike-mirrorlist/' /etc/pacman.conf
sudo pacman -Syy

sleep 3

echo "Installing tools with archstrike"
sudo pacman -S --noconfirm --needed dirb gobuster wfuzz dirbuster
sudo pacman -S --noconfirm --needed burpsuite
sudo pacman -S --noconfirm --needed crunch cupp-git cewl
sudo pacman -S --noconfirm --needed netdiscover
sudo pacman -S --noconfirm --needed dirsearch
sudo pacman -S --noconfirm --needed hash-identifier
sudo pacman -S --noconfirm --needed dnsenum sublist3r-git
sudo pacman -S --noconfirm --needed enum4linux
#sudo pacman -S --noconfirm --needed crackmapexec
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec /opt/
cd /opt/CrackMapExec
python3 setup.py install
cd ~
sudo pacman -S --noconfirm --needed wafw00f
sudo pacman -S --noconfirm --needed windows-binaries
sudo pacman -S --noconfirm --needed nishang
sudo pacman -S --noconfirm --needed powersploit-git
sudo pacman -S --noconfirm --needed windows-exploit-suggester-git
sudo pacman -S --noconfirm --needed smbmap-git
sudo pacman -S --noconfirm --needed cryptcat

echo "Intalling tools with AUR Repo"

if [ ! -d "~/tools" ]
then
    mkdir -p ~/tools
fi

git clone https://aur.archlinux.org/samdump2.git ~/tools/
cd ~/tools/samdump2
makepkg -si
cd ~

git clone https://aur.archlinux.org/rocket-depot-git.git ~/tools/
cd ~/tools/rocket-depot-git
makepkg -si
cd ~

sleep 3

echo "Installing go tools"
go get -u github.com/tomnomnom/assetfinder
go get -u github.com/tomnomnom/httprobe
go get -u github.com/tomnomnom/waybackurls
go get -u github.com/ffuf/ffuf
go get -u github.com/lc/gau

echo "Disabling beep sound"
sudo -- sh -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'

echo "Configuring Nice Burpsuite"
sudo -- sh -c 'echo "_JAVA_AWT_WM_NONREPARENTING=1" > /etc/environment'

echo "To configure root files execute:"
echo "sudo -- sh -c 'ln -sf /home/user/.vim /root/.vim'"
echo "sudo -- sh -c 'ln -sf /home/user/.tmux.conf /root/.tmux.conf'" 

echo "Reboot, open vim and execute :PluginInstall"
