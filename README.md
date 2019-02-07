# vagrant-CSGO-server
Vagrant deployment for CS:GO.
Use this tool to easily start a development server!

###### DEVELOPMENT - Never use this project to make an online game server!

# Install vagrant

Go to https://www.vagrantup.com/downloads.html and download / install vagrant for your system.

## Install VirtualBox

Vagrant works with a vm manager, by default you can work with VirtualBox.

Go to  https://www.virtualbox.org/wiki/Downloads and download / install vagrant for your system.

# Deploy your CS:GO server

Clone this repository:

	$ git clone https://github.com/b3none/vagrant-csgo
	$ cd vagrant-CSGO-server
	$ vagrant up
	$ vagrant ssh
	$ ./csgoserver start

Stop the server

	./csgoserver stop

Update the server

	./csgoserver update

The "debug" mode functionality - for modders, run server instance to debug transaction

	./csgoserver debug

### CS:GO server

Use the ./csgoserver script to start / update / stop / debug your server.
All the action list is accessed like this (inside the vm):
	
	./csgoserver
	
To connect to your game server, use 192.168.56.101:27015 as server IP.
This IP is forced in the VM configuration file.

	- rcon password : rconpassword

All csgo server content is available from you computer in: vagrant-csgo/csgo
	
## VM file sharing
	
The "csgo" directory is shared between the box and your computer and will get updated as changes occur.

## For LGSM commands

https://linuxgsm.com/lgsm/csgoserver/
