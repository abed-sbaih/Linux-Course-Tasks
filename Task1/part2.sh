#!/bin/bash

# In this task, we should create a user 'user1' with uid = 601, and password: redhat,
# and make the user's login shell non-interactive (no ssh access to the server).
# Then add the user to group TrainingGroup.
# After that, add users 'user2' and 'user3'. Add them to admin group. Password: redhat
# 'user3' must have root permissions.

# check if there is user with 601 as uid.
test=$(cat /etc/passwd | grep 601 | wc -l)
if [ $test -eq 0 ]
then
        # create user with user id = 601
        useradd -u 601 user1

        # change password of user to redhat
        (printf 'redhat\n'; printf 'redhat\n';) | passwd user1

        # deny user in sshd configuration file at location /etc/ssh/sshd_config
        echo "DenyUsers user1" >> /etc/ssh/sshd_config
        systemctl restart sshd

        # create group TrainingGroup
        groupadd TrainingGroup

        # in order to add the user to TrainingGroup, we will just change the primary
        # group of the user to TrainingGroup.
        usermod -a -G TrainingGroup user1
else
        echo error: uid 601 already taken
fi

# add user2 and change password to redhat
useradd user2
(printf 'redhat\n'; printf 'redhat\n';) | passwd user2

# add user3 and change password to redhat
useradd user3
(printf 'redhat\n'; printf 'redhat\n';) | passwd user3

# create admin group and add users to group
groupadd admin
usermod -a -G admin user2
usermod -a -G admin user3

# change user3 permissions to root permissions
echo "user3 ALL=(ALL) ALL" >> /etc/sudoers
