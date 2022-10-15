#Project Auto-OS

#A script that automatically prepares a freshly installed UNIX OS

<<Updates
V1.4
 - Added I3 install functionality
 -

Updates

<<Toadd
V1.5
 - auto install programas necessários (subl/firefox/addons/mpv/ani-cli/changewallpaper/i3blocks)

Toadd



echo "        Welcome to AutoOS          "
echo "...................................."
echo "    ............................    "
echo "           ...............          "
echo "                ......              "

#criação de aliases
echo "alias update='sudo apt update && sudo apt full-upgrade -y'" >> ~/.bash_aliases
echo "alias editalias='nano ~/.bash_aliases'" >> ~/.bash_aliases
echo "alias pubip='curl icanhazip.com'" >> ~/.bash_aliases
echo "alias r='redshift -O 5500'" >> ~/.bash_aliases
echo "alias x='xdg-open'" >> ~/.bash_aliases


echo "     Obrigado por usar o AutoOS    "

#Step 1 - Update the OS
sudo apt update && sudo apt full-upgrade -y
#gnome-terminal -e | xterm -e |konsole -e "update" não dá pois invocar aliases desta maneira dá erro



#Step 2 - Secure the OS
sudo systemctl disable cups-browsed
sudo apt-get autoremove cups-daemon
#interact with printers
sudo systemctl disable avahi-daemon
sudo apt-get purge avahi-daemon
#interact with apple products

#Creation and definition of a firewall
sudo apt install ufw
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default deny forward
sudo ufw default deny outgoing

#exceptions
sudo ufw allow out on <interface> to 1.1.1.1 proto udp port 53 comment 'allow DNS on <interface>'
sudo ufw allow out on <interface> to any proto tcp port 80 comment 'allow HTTP on <interface>'
sudo ufw allow out on <interface> to any proto tcp port 443 comment 'allow HTTPS on <interface>'

#change dns address to 1.1.1.1

sudo ufw status numbered
#see created rules

sudo aa-status
sudo apt-get install apparmor-profiles apparmor-utils
sudo aa-enforce /etc/apparmor.d/*

#More info using man aa-status | man apparmor | man aa-enforce


sudo apt-get install clamav
#install antivirus

#Componentes importantes I3
sudo wget -O- https://baltocdn.com/i3-window-manager/signing.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/i3wm-signing.gpg
sudo apt install apt-transport-https --yes
sudo echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
sudo apt update
sudo apt install i3

#sudo clamscan -r / --log=/tmp/clamav_report.log
#sudo clamscan -ir malware-master/
#-- opcional verifica o sistema todo(/)

#firejail --seccomp --nonewprivs --private-tmp --net=none --x11 firefox