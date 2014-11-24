HOSTONLY=`VBoxManage list hostonlyifs | wc -l`
USER=ubuntu
if [ $HOSTONLY -lt 1 ]; then
VBoxManage hostonlyif create
SINGLENAME=`VBoxManage list hostonlyifs | grep ^Name: | cut -d ' ' -f 13 | tail --lines 1`
IP=`VBoxManage list hostonlyifs | grep ^IPAddress: | tail --lines 1 | cut -d ' ' -f 8`
VBoxManage dhcpserver add --ifname $SINGLENAME --enable --ip ${IP}00 --netmask 255.255.255.0 --lowerip ${IP}01 --upperip ${IP}01

else

NAME=`VBoxManage list hostonlyifs | grep ^Name:`
ANZAHLNAME=`VBoxManage list hostonlyifs | grep ^Name: | wc -l`
REALNAME=`VBoxManage list hostonlyifs | grep ^Name: | cut -d ' ' -f 13`

VBoxManage hostonlyif create
SINGLENAME=`VBoxManage list hostonlyifs | grep ^Name: | cut -d ' ' -f 13 | tail --lines 1`
IPS=`VBoxManage list hostonlyifs | grep ^IPAddress:`

IP=`VBoxManage list hostonlyifs | grep ^IPAddress: | tail --lines 1 | cut -d ' ' -f 8`

VBoxManage dhcpserver add --ifname $SINGLENAME --enable --ip ${IP}00 --netmask 255.255.255.0 --lowerip ${IP}01 --upperip ${IP}01

fi

##########################################
#    Prüfen ob noch eine VM existiert    #
##########################################
ORDNER=`ls $PWD | grep output-virtualbox-iso | wc -l`
if [ $ORDNER -gt 0 ]; then 
	ORDNER=`ls $PWD | grep output-virtualbox-iso-old | wc -l`
	if [ $ORDNER -gt 0 ]; then 
		rm -r output-virtualbox-iso-old
		mv $PWD/output-virtualbox-iso $PWD/output-virtualbox-iso-old
		vboxmanage unregistervm packer-virtualbox-iso --delete

	else
		mv $PWD/output-virtualbox-iso $PWD/output-virtualbox-iso-old
		vboxmanage unregistervm packer-virtualbox-iso --delete
		
	fi
fi
ORDNER=`ls $HOME/VirtualBox\ VMs/ | grep packer-virtualbox-iso | wc -l`
if [ $ORDNER -gt 0 ]; then
	ORDNER=`ls $HOME/VirtualBox\ VMs/ | grep packer-virtualbox-iso-old | wc -l`
	if [ $ORDNER -gt 0 ]; then 
		rm -r packer-virtualbox-iso-old
		mv $HOME/VirtualBox\ VMs/packer-virtualbox-iso $HOME/VirtualBox\ VMs/packer-virtualbox-iso-old
	else
		mv $HOME/VirtualBox\ VMs/packer-virtualbox-iso $HOME/VirtualBox\ VMs/packer-virtualbox-iso-old
	fi
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


