#!/bin/bash

# Generate SSH key and connect to a different VM without password.
# The following link was used for reference to generating the SSH key:
# https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server

# generating ssh key without passphrase
(printf '\n'; printf '\n'; printf '\n';) | ssh-keygen

# get the username of this VM
username=$(whoami)

# get the remote VM server ip
echo
echo "Please, enter remote IP: "
read remoteIP

# copying the public SSH key to the remote VM
# it may require remote VM root password if first time
(printf 'yes\n';) | ssh-copy-id $username@$remoteIP

# the key is copied to the remote server, and now can be used

# connect using ssh to the remote server, without password
echo
echo Connecting to $remoteIP ...
ssh $username@$remoteIP
