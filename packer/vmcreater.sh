HOSTONLY=`VBoxManage list hostonlyifs | wc -l`
USER=ubuntu
if [ $HOSTONLY -lt 1 ]; then
VBoxManage hostonlyif create
SINGLENAME=`VBoxManage list hostonlyifs | grep ^Name: | cut -d ' ' -f 13 | tail -n 1`
IP=`VBoxManage list hostonlyifs | grep ^IPAddress: | tail -n 1 | cut -d ' ' -f 8`
VBoxManage dhcpserver add --ifname $SINGLENAME --enable --ip ${IP}00 --netmask 255.255.255.0 --lowerip ${IP}01 --upperip ${IP}01

else

NAME=`VBoxManage list hostonlyifs | grep ^Name:`
ANZAHLNAME=`VBoxManage list hostonlyifs | grep ^Name: | wc -l`
REALNAME=`VBoxManage list hostonlyifs | grep ^Name: | cut -d ' ' -f 13`

VBoxManage hostonlyif create
SINGLENAME=`VBoxManage list hostonlyifs | grep ^Name: | cut -d ' ' -f 13 | tail -n 1`
IPS=`VBoxManage list hostonlyifs | grep ^IPAddress:`

IP=`VBoxManage list hostonlyifs | grep ^IPAddress: | tail -n 1 | cut -d ' ' -f 8`

VBoxManage dhcpserver add --ifname $SINGLENAME --enable --ip ${IP}00 --netmask 255.255.255.0 --lowerip ${IP}01 --upperip ${IP}01

fi

################
#    Packer    #
################
packer validate ubuntu_64.json
packer build ubuntu_64.json
VBoxManage import ./output-virtualbox-iso/packer-virtualbox-iso.ovf

################
#   Get Key    #
################
wget https://raw.githubusercontent.com/zih-a35/trinityvm/master/download/trinityvm
mkdir ~/.ssh
mv ./trinityvm ~/.ssh

###################
# Network Adapter #
###################
VBoxManage modifyvm "packer-virtualbox-iso" --nic1 hostonly
VBoxManage modifyvm "packer-virtualbox-iso" --hostonlyadapter1 $SINGLENAME
VBoxManage modifyvm "packer-virtualbox-iso" --nic2 nat

#VBoxHeadless --startvm "packer-virtualbox-iso" &

#ssh -o StrictHostKeyChecking=no ${USER}@${IP}01


#./trinitybuilder
