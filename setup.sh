#!/bin/bash
#Intructions to set up a PC for 491G lab
# this should be run as root (or with sudo)

export GUI=no

# disallow TUI setup prompts
export DEBIAN_FRONTEND=noninteractive

# see https://github.com/phusion/baseimage-docker/issues/319
# "debconf: delaying package configuration, since apt-utils is not installed"
apt-get update && apt-get install -y --no-install-recommends apt-utils

# https://stackoverflow.com/a/51507868
apt-get install -y debconf-utils dialog
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections
apt-get update
apt-get install -y resolvconf


apt-get -y install 

apt-get -y install vim nano less htop telnet netcat iputils-ping 

# ---------------------------------------
# install telnet server
# ---------------------------------------
apt-get -y install telnetd
# no need to restart inetd


# ---------------------------------------
# Install traceroute
# ---------------------------------------
apt-get -y install inetutils-traceroute


# ---------------------------------------
# Install traceroute6
# ---------------------------------------

apt-get install -y ndisc6

# ---------------------------------------
# Install ARPing
# ---------------------------------------

apt-get install -y arping



if [[ "$GUI" == 'y' ]]; then
    # ---------------------------------------
    # Install unity-tweak-tool utility (Optional) [Not for GNS3]
    # ---------------------------------------
    apt-get -y install unity-tweak-tool


    # ---------------------------------------
    # Install editor leafpad & lxterminal
    # ---------------------------------------
     apt-get -y install leafpad
     apt-get -y install lxterminal
fi

# ---------------------------------------
# Install iperf
# ---------------------------------------
apt-get -y install iperf		#iperf
apt-get -y install iperf3
# ---------------------------------------
# Install minicom  [not for GNS3]
# ---------------------------------------
apt-get -y install minicom		#minicom

# ---------------------------------------
# Install kermit  [not for GNS3]
# ---------------------------------------
#apt-get -y install ckermit		#kermit

# Deprecated in Ubuntu 20.04, needs to be compiled from source

# ---------------------------------------
# Install TFTP-HPA client & server
# Usage:
# /etc/init.d/tftp-hpa {start|stop|restart|force-reload|status}
# ---------------------------------------
apt-get -y install tftpd-hpa		#tftp server
apt-get -y install tftp-hpa 		#tftp client

# https://help.ubuntu.com/community/TFTP

# In the PC do the following:

# Create directore "tftpboot" in the home directory of user "labuser"

mkdir -p /home/labuser/tftpboot
chown -R tftp /home/labuser/tftpboot

cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.ORIGINAL
#nano /etc/default/tftpd-hpa


# make sure the file has the following contents
echo <<EOF > /etc/default/tftpd-hpa
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/home/labuser/tftpboot"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure"
EOF
# save and exit




# ---------------------------------------
# Install FTP server (client is installed by default)
# Usage:
# ---------------------------------------
apt-get -y install ftpd		#ftp server



# ---------------------------------------
# Install Bridge Utilities
# ---------------------------------------
apt-get -y install bridge-utils	#brctl



# ---------------------------------------
# Install quagga
# ---------------------------------------
apt-get update
apt-cache policy quagga		#quagga
apt-get -y install quagga quagga-core quagga-doc 		#quagga

cat << EOF > /etc/quagga/daemons
zebra=yes
bgpd=no 
ospfd=yes
ospf6d=no
ripd=yes   
ripngd=no
isisd=no
babeld=no
EOF
#CTRL-o
#CTRL-x

cp -r /usr/share/doc/quagga-doc /usr/share/doc/quagga
cp -r /usr/share/doc/quagga-core /usr/share/doc/quagga
ls -lah /usr/share/doc/quagga/examples
ls -lah /etc/quagga

cp /usr/share/doc/quagga/examples/zebra.conf.sample /etc/quagga/zebra.conf
cp /usr/share/doc/quagga/examples/ospfd.conf.sample /etc/quagga/ospfd.conf
cp /usr/share/doc/quagga/examples/ripd.conf.sample /etc/quagga/ripd.conf
chown -R quagga.quaggavty /etc/quagga/*.conf  # */
chmod -R 640 /etc/quagga/*.conf               # */

# For a good example see the following
# https://www.brianlinkletter.com/how-to-build-a-network-of-linux-routers-using-quagga/

  
# ---------------------------------------
# Install DHCP Server & Client
# 
# Stop prevent the server from starting at reboot by
# update-rc.d isc-dhcp-server disable
# ---------------------------------------
apt-get update
apt-get -y install isc-dhcp-server
# Client is already included, no need to install
#apt-get -y install isc-dhcp-client


# ---------------------------------------
# Install BIND9: DNS Server
# 
# ---------------------------------------
apt-get update
apt-get -y install bind9 bind9utils


if [[ "$GUI" == 'y' ]]; then
    # ---------------------------------------
    # Install Wireshark [Not for GNS3]
    # ---------------------------------------
    # Step 1 : Add the official PPA
        add-apt-repository ppa:wireshark-dev/stable

    #Step 1.1 : Add Universal repository
        add-apt-repository universe

    #Step 2 : update the repository
        apt-get update

    #Step 3 : Install wireshark (V 2.2.4?)
        apt-get -y install wireshark

    #Step 4: Do this on Linux:
        chmod +x /usr/bin/dumpcap

    # During the installation,it will require to confirm security about 
    # allowing non-superuser to execute Wireshark.
    #
    # Just confirm YES if you want to. If you check on NO, you must run 
    # Wireshark with sudo. later, if you want to change this,
    #
       dpkg-reconfigure wireshark-common
fi

# ---------------------------------------
# Deactivate firewall
# ---------------------------------------

service ufw stop


# ====================================

apt-get -y install openssh-server	#ssh

apt-get -y install tftp           #tftp client
# ---------------------------------------
# Install ftp-hda/ftpd-hda
# https://help.ubuntu.com/community/TFTP
# ---------------------------------------
apt-get -y install vsftpd             #ftp
apt-get -y install xinetd tftpd tftp ftp
apt-get -y install iptables isc-dhcp-client
apt-get -y install nmap
apt-get -y install dnsutils
apt-get -y install unzip zip

# openvswitch
apt-get install -y openvswitch-switch


# ethtool
apt-get -y install ethtool

# Reinstall tftpd-hpa because it doesn't work the first time...

apt-get install -y tftpd-hpa

mkdir /tftpboot
chmod -R 777 /tftpboot
chown -R tftp /tftpboot

rm /etc/default/tftpd-hpa
touch /etc/default/tftd-hpa
cat <<EOT > /etc/default/tftpd-hpa
USE_DAEMON="yes"
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/tftpboot"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure --create"
EOT

# Install net-tools

apt-get install -y net-tools

# Configure Quagga
mkdir -p /var/log/quagga && chown quagga:quagga /var/log/quagga
touch /etc/quagga/zebra.conf
cat <<EOT > /etc/quagga/zebra.conf
hostname localhost
password zebra
enable password zebra
log file /var/log/quagga/zebra.log
!
interface eth0
!
interface ath0
!
interface lo
!
access-list vtylist permit 127.0.0.1/32
access-list vtylist deny any
!
ip forwarding
!
line vty
 access-class vtylist
!
EOT
chown quagga:quagga /etc/quagga/zebra.conf && chmod 640 /etc/quagga/zebra.conf

#----------------------------------------
# Create labuser
# Install sudo
# add labuser to sudoers
# set default login to labuser
echo "Creating and Configuring labuser..."
adduser -gecos '' labuser
echo "labuser:labuser" | chpasswd
chown labuser /home/labuser

apt-get install sudo
usermod -aG sudo labuser


# Bypass weird sudo pseudo-error
echo "Set disable_coredump false" >> /etc/sudo.conf

# Create telnet config file
cat <<EOT >> /etc/xinetd.d/telnet
service telnet
{
disable = no
flags = REUSE
socket_type = stream
wait = no
server = /usr/sbin/in.telnetd
log_on_failure += USERID
}
EOT

echo "labuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "Done!"

