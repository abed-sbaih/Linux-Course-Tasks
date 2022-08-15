#!/bin/bash

# Write a shell script that will keep running for 10 mins in the background
# and check the process that it's created and try to kill using commands.

# I will be using sleep command in order to make the script work for 10mins,
# in a script called count10.sh, and kill it from this shell script from
# another terminal on the server. In order to get the script working in background
# I will use & when I run the script.
./count10.sh&

# Show process generated on termial
echo "The process generated is: "
ps -ef | grep -i ./count10.sh

# Extract the process id of this process
pid=$(ps -ef | grep -i ./count10.sh | head -1 | gawk '{ print $2 }')
echo "Process with pid = "$pid" will be killed"

# Kill process
kill -9 $pid

# Check if process is still running
echo "Process was killed."
ps -ef | grep -i ./count10.sh
