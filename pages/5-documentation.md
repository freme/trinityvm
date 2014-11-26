---
title: Documentation for the Trinity VM Builder
type: pages
layout: default
---

quick start
-----------

1. {% highlight bash %}apt-get install unzip{% endhighlight %}
2. Download and Install the Packer.
2.1 {% highlight bash %}wget https://dl.bintray.com/mitchellh/packer/packer_0.7.2_linux_amd64.zip{% endhighlight %}
2.2 {% highlight bash %}unzip packer_0.7.2_linux_amd64 -d /usr/local/bin/{% endhighlight %}
3. {% highlight bash %}apt-get install virtualbox virtualbox-guest-additions-iso{% endhighlight %}
4. Download the scripts.
4.1 {% highlight bash %}wget https://github.com/zih-a35/trinityvm/blob/master/packer/ubuntu_64.json
	{% highlight bash %}wget https://github.com/zih-a35/trinityvm/blob/master/download/preseed.cfg{% endhighlight %}
4.2 {% highlight bash %}wget https://github.com/zih-a35/trinityvm/blob/master/packer/vmcreater.sh{% endhighlight %}
5. Create a directory and move the scripts in.
5.1 {% highlight bash %}mkdir VM-Creator{% endhighlight %}
5.2 {% highlight bash %}mv ubuntu_64.json vmcreater.sh preseed.cfg ./VM-Creator/{% endhighlight %}
6. Build the virtual machine by the vmcreater.
6.1 {% highlight bash %}cd VM-Creator{% endhighlight %}
6.2 {% highlight bash %}chmod ug+x vmcreater.sh{% endhighlight %}
6.3 {% highlight bash %}./vmcreater.sh{% endhighlight %}




Step by Step Tutorial
---------------------

1. apt-get install unzip
	Insall of a programm what unpack .zip-Files.
2. Download and Install Packer.
2.1 wget https://dl.bintray.com/mitchellh/packer/packer_0.7.2_linux_amd64.zip
	Download the .zip-File from the programm what build the virtual machine called Packer.
2.2 unzip packer_0.7.2_linux_amd64 -d /usr/local/bin/
	Unpack the .zip-File in the bin direktory at '/usr/local/bin/'.
3. apt-get install virtualbox virtualbox-guest-additions-iso
	Install "VirtualBox" and the plugin "virtualbox-guest-additions-iso".
4. Download the scripts.
4.1 wget https://github.com/zih-a35/trinityvm/blob/master/packer/ubuntu_64.json
	wget https://github.com/zih-a35/trinityvm/blob/master/download/preseed.cfg
	Download from the Git-repository two configscript for Packer.
4.2 wget https://github.com/zih-a35/trinityvm/blob/master/packer/vmcreater.sh
	Download the shellscript from the Git-repository to build the VM.
5. Create a directory and move the Files from the Git-repository in the directory.
5.1 mkdir VM-Creater
	Create a directory for the 3 Files.
5.2 mv ubuntu_64.json vmcreater.sh preseed.cfg ./VM-Creater/
	Move the 3 Files in the "VM-Creator" directory.
6. Build the VM with the shellscript "vmcreater".
6.1 cd VM-Creater
	With the command cd you change the directory to VM-Creator.
6.2 chmod ug+x vmcreater.sh
	Change the permissions from the shellscript "vmcreater.sh" so that you can execute it.
6.3 ./vmcreater.sh
	Execute the script "vmcreater.sh". What makes this script, described below.




Summary
-------

The virtual machine is build when you start the shellscript 'vmcreater.sh' with the command './vmcreater.sh'.
The following files are needed in the same directory: preseed.cfg, ubuntu_64.json, the ISO (ubuntu-14.04-server-amd64.iso) and vmcreater.sh.
Also, you need the programms "Packer" and "VirtualBox" with the plugin "virtualbox-guest-additions-iso".




What are the shellscript 'vmcreater.sh' doing?
----------------------------------------------

The script make a hostonly-network for the VM.

It checks if a builded VM exist.

Then the VM is built.

At first, the .json file will confirmed with 'packer validate ubuntu_64.json'.

Second, the VM is built with 'packer build ubuntu_64.json'.

Then the VM will import into VirtualBox.

SSH-key download from git and include local (not tested).

Connect VM with the hostonly-network.




What happens when you build?
----------------------------

It create a VM with given values such as a hard drive size of 32 GB and username and password is "ubuntu".

Then the VM is started and it will be automatically installed programs such like: vim, ssh, git, java ... .

As a graphical interface lxde installed.

From the Git-website, an SSH key will be downloaded and integrated (but not tested).

After that, the script "Trinitybuilder" is downloaded und installed in the software directory.

"IGV" and "Tophat" will be installed too.

The actual folder of the workshop is downloaded by SVN.

At least, set the environ variables.




