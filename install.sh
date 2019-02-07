#!/bin/bash

apt-get update
apt-get upgrade

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
cp /home/vagrant/iptables.up.rules /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules

echo -e "\n--- LGSM pre-requisites ---\n"
apt-get update
apt-get install mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386

echo -e "\n--- Install CS:GO server ---\n"
cd /home/vagrant
wget -O linuxgsm.sh https://linuxgsm.sh
chmod +x linuxgsm.sh
bash linuxgsm.sh csgoserver

sed -i 's/"0.0.0.0"/"192.168.56.101"/' /home/vagrant/csgoserver

chown vagrant:vagrant -R /home/vagrant/serverfiles
/home/vagrant/csgoserver auto-install
