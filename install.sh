#!/bin/bash

APTGET="apt-get"

eval ${APTGET} update
eval ${APTGET} upgrade

echo -e "\n--- libc6-i386 & lib32gcc1 - i386 packages ---\n"
sudo dpkg --add-architecture i386
eval ${APTGET} update
eval ${APTGET} install libc6-i386 lib32gcc1

echo -e "\n--- ia32-libs - i386 packages ---\n"
sudo dpkg --add-architecture i386
eval ${APTGET} update
sudo aptitude -y -q install ia32-libs

echo -e "\n--- Binaries (gdb, tmux, git ...) ---\n"
eval ${APTGET} install gdb tmux git curl

echo -e "\n--- IP Tables ---\n"
echo "*filter

-P INPUT DROP
-P FORWARD ACCEPT
-P OUTPUT ACCEPT

-A INPUT -i lo -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -p igmp -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp --dport ssh -j ACCEPT
-A INPUT -p tcp --dport http -j ACCEPT
-A INPUT -p tcp --dport https -j ACCEPT

#
# Steam Rules -----
# https://forums.alliedmods.net/showthread.php?t=163467
#

-A INPUT -p udp --dport 1200 --jump ACCEPT
-A INPUT -p udp --dport 27000 --jump ACCEPT
-A INPUT -p tcp --dport 27020 --jump ACCEPT
-A INPUT -p tcp --dport 27039 --jump ACCEPT
-A INPUT -p udp --dport 27020 --jump ACCEPT
-A INPUT -p udp -d 127.0.0.1 --dport 27015
-A INPUT -p tcp -d 127.0.0.1 --dport 27015 --jump ACCEPT

#
# !Steam Rules -----
#

-A INPUT -j LOG --log-prefix \"paquet IPv4 inattendu\"

# /!\ WARNING
# /!\ WARNING - NEVER USE THIS RULE ON PRODUCTION SERVER
# /!\ WARNING - (Note change it with : -A INPUT -j REJECT)
# /!\ WARNING
-I INPUT -j ACCEPT

COMMIT

*nat
COMMIT

*mangle
COMMIT" > /home/vagrant/iptables.up.rules
sudo cp /home/vagrant/iptables.up.rules /etc/iptables.up.rules
sudo iptables-restore < /etc/iptables.up.rules

echo -e "\n--- Install CS:GO server ---\n"
cd /home/vagrant
wget https://raw.github.com/dgibbs64/linuxgameservers/master/CounterStrikeGlobalOffensive/csgoserver
sed -i 's/"0.0.0.0"/"192.168.56.101"/' /home/vagrant/csgoserver
chmod +x csgoserver
sudo chown vagrant:vagrant -R /home/vagrant/serverfiles
/home/vagrant/csgoserver auto-install
