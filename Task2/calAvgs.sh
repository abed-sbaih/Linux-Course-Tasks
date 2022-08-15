#!/bin/bash

# This script calculates the averages of the data collected,
# and stores the resulting averages in files in /avgs directory.

# The number of files stored for each item type is the same in each directory in systemStats.
# We will use 5 loops to find the avg for each item type

# find the number of files for each item type
fileNumber=$(ls /tmp/task2/systemStats/freeMemory | wc -w)

sum=0

# find the avg of the used disk data
files=$( ls /tmp/task2/systemStats/usedDisk )
for file in $files
do
        usedDiskSpace=$( cat /tmp/task2/systemStats/usedDisk/$file | grep -i total | gawk '{ print $2 }')
        (( sum=$sum+$usedDiskSpace ))
done

let usedDiskAvg=$sum/$fileNumber
echo $usedDiskAvg > /tmp/task2/avgs/usedDiskAvg

# find the avg of the free disk data
files=$(ls /tmp/task2/systemStats/freeDisk )
sum=0
for file in $files
do
        freeDiskSpace=$( cat /tmp/task2/systemStats/freeDisk/$file | grep -i total | gawk '{ print $2 }' )
        (( sum=$sum+$freeDiskSpace ))
done
let freeDiskAvg=$sum/$fileNumber
echo $freeDiskAvg > /tmp/task2/avgs/freeDiskAvg

# find the avg of the used memory data
files=$( ls /tmp/task2/systemStats/usedMemory )
sum=0
for file in $files
do
        usedMemory=$( cat /tmp/task2/systemStats/usedMemory/$file)
        (( sum=$sum+$usedMemory ))
done
let usedMemoryAvg=$sum/$fileNumber
echo $usedMemoryAvg > /tmp/task2/avgs/usedMemoryAvg

# find the avg of the free memory data
files=$(ls /tmp/task2/systemStats/freeMemory )
sum=0
for file in $files
do
        freeMemory=$(cat /tmp/task2/systemStats/freeMemory/$file)
        (( sum=$sum+$freeMemory ))
done
let freeMemoryAvg=$sum/$fileNumber
echo $freeMemoryAvg > /tmp/task2/avgs/freeMemoryAvg

# find the avg of the cpu utilitzation data
files=$(ls /tmp/task2/systemStats/cpuUtils )
sum=0
for file in $files
do
        cpuUtil=$(cat /tmp/task2/systemStats/cpuUtils/$file )
        sum=`echo $sum+$cpuUtil | bc`
done
let cpuUtilAvg=`echo $sum/$fileNumber | bc`
echo $cpuUtilAvg > /tmp/task2/avgs/cpuUtilAvg


# Modification:
# Adding Avgs to Html

# Add Disk Usage Averages:
sed "s/\*usedDisk\*/$usedDiskAvg/" /var/www/html/diskUsage.html > /var/www/html/tmp
cp /var/www/html/tmp /var/www/html/diskUsage.html
sed "s/\*freeDisk\*/$freeDiskAvg/" /var/www/html/diskUsage.html > /var/www/html/tmp
cp /var/www/html/tmp /var/www/html/diskUsage.html

# Add Memory Usage Averages:
sed "s/\*usedMem\*/$usedMemoryAvg/" /var/www/html/memoryUsage.html > /var/www/html/tmp
cp /var/www/html/tmp /var/www/html/memoryUsage.html
sed "s/\*freeMem\*/$freeMemoryAvg/" /var/www/html/memoryUsage.html > /var/www/html/tmp
cp /var/www/html/tmp /var/www/html/memoryUsage.html

# Add cpu Usage Averages:
sed "s/\*cpuUtil\*/$cpuUtilAvg/" /var/www/html/cpuUsage.html > /var/www/html/tmp
cp /var/www/html/tmp /var/www/html/cpuUsage.html
