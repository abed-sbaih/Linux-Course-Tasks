#!/bin/bash

# Gets users currently logged on the server.
# who: shows all users currently logged on
# gawk: gets only the name of the user
# uniq: removes duplicate user names
# tr: concatinate the user names on one line
users=$( who | gawk '{ print $1 }' | sort | uniq | tr '\n' ' ')

# the date and users are saved in /tmp/task1/loggedin file
printf "$(date)-$users\n" >> /tmp/task1/loggedin
