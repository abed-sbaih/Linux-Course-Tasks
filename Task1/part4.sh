#!/bin/bash

# Copy /etc/fstab to /var/tmp name admin, user1 could read, write
# and modify it, while user2 can't do any permission

# copy /etc/fstab to /var/tmp and name it admin
cp -p /etc/fstab /var/tmp/admin

# change permissions for user1 to read, write/modify
setfacl -m u:user1:rw /var/tmp/admin

# change permissions for user2 ro no permissions
setfacl -m u:user2:--- /var/tmp/admin
