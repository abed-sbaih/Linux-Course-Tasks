#!/bin/bash

# This script must be run only once, it creates a cronjob that checks for the logged
# in users at 1:30AM everyday, which is run by the script /tmp/task1/findLoggedIn.sh
# and saves the logged in users in /tmp/task1/loggedin file.

(echo "30 01 * * * /tmp/task1/findLoggedIn.sh";) | crontab -
