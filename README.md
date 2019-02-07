# vagrant-CSGO-server
Vagrant deployement for CSGO game server.
Use this tool to easily start a development server!

###### /!\ Project for developers - never use this project to make online game server! [![Build Status](https://travis-ci.org/42antoine/vagrant-CSGO-server.svg?branch=master)](https://travis-ci.org/42antoine/vagrant-CSGO-server)

# Install vagrant

Go to https://www.vagrantup.com/downloads.html and download / install vagrant for your system.

## Install VirtualBox

Vagrant works with a vm manager, by default you can work with virtualbox.

Go to  https://www.virtualbox.org/wiki/Downloads and download / install vagrant for your system.

# Deploy your server CS:GO

Clone this repository :

	$ git clone https://github.com/b3none/vagrant-csgo
	$ cd vagrant-CSGO-server
	$ vagrant up
	$ vagrant ssh
	$ ./csgoserver start

Stop the game server

	./csgoserver stop

Update the game server

	./csgoserver update

The "debug" mode functionality - for moders, run server instance to debug transaction

	./csgoserver debug

### CS:GO game server

Use the ./csgoserver script to start / update / stop / debug your server.
All the action list is accessed like this (inside the vm) :
	
	$ ./csgoserver
	@seealso https://github.com/dgibbs64/linuxgsm/wiki/Usage
	
To connect to your game server, use 192.168.56.101:27015 as server IP.
This IP is forced in the VM configuration file.

	- rcon password : rconpassword

All csgo server content is available from you computer in : vagrant-CSGO-server/csgo *(1)
	
## VM file sharing
	
*(1) : On project root directory, you can see "csgo" directory. These folders are shared from VM, use it to share game server configuration or website with the VM.

## See also

https://github.com/dgibbs64/linuxgsm/wiki/Usage
