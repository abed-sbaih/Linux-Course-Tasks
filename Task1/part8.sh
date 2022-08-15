#!/bin/bash

# open port 443, 80 permanently. and block the ssh for your colleague ip to the VM.
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=192.168.203.100
 service name=ssh reject'
firewall-cmd --reload
