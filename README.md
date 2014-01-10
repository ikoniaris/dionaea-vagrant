dionaea-vagrant
===============

Dionaea-Vagrant provides a Vagrant configuration file (Vagrantfile) and shell scripts to automate the setup of a Dionaea malware honeypot virtual machine.

###REQUIREMENTS

1. [VirtualBox](https://www.virtualbox.org)
2. [Vagrant](https://www.vagrantup.com)

###QUICK INSTALLATION:
1. `git clone https://github.com/ikoniaris/dionaea-vagrant && cd dionaea-vagrant`
2. `vagrant up`

This will download (only the first time) a virtual disk, create a new Ubuntu 12.04 LTS VM on the fly and start it, install Dionaea and all of its dependencies and execute it as daemon along with p0f. And that’s it!

You can then login into the machine by typing `vagrant ssh` or using an SSH client (e.g. PuTTY) and connect to localhost:2222 — *username: vagrant*, *password: vagrant*. Once inside the VM, type `ifconfig` to find out the IP address assigned to the bridged adapter (eth1), which you can use to forward ports from your home router back to the VM. For a list of ports used by Dionaea type `sudo netstat -antp | grep dionaea`. If you want to stop the machine type `vagrant halt` (on the outer terminal, not inside the machine).

Every time you want to start the honeypot VM a simple `vagrant up` issued inside the dionaea-vagrant directory is enough!
