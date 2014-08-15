---
title: Using packer to create VM
type: pages
layout: default
---

What is packer
==============

How does it work
================

Howto install packer
====================
* install [Packer](http://www.packer.io/docs/installation.html)
* install [VirtualBox](http://wiki.ubuntuusers.de/VirtualBox/Installation)
* install [VirtualBox Plugin](https://help.ubuntu.com/community/VirtualBox/GuestAdditions)
* Validate .JSON File`packer validate ubuntu_64.json`
* Build Packer `packer build ubuntu_64.json`

Build an ubuntu vm
==================
* preseed file is described [here](preseed.html)

