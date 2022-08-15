
#!/bin/bash
# This script collects all system performance statistics: disk usage, free disk, memomry usage,
# free memory space, and cpu utilization. And then stores them in a file with a name format of the
# statistic name and the time-stamp the script was run.

# find time stamp in which the script is executed
timeStamp=$( date | tr ' ' '_' )

# collect all stats about disks in system
df --total > diskStats

# collect detailed data about used disk space in kB and save in file
cat diskStats | gawk '{ print $1, $3 }' > /tmp/task2/systemStats/usedDisk/usedDiskSpace_$timeStamp

# collect detailed data about free disk space in kB and save in file
cat diskStats | gawk '{ print $1, $4 }' > /tmp/task2/systemStats/freeDisk/freeDiskSpace_$timeStamp

# collect all stats about memory in system
cat /proc/meminfo | head -3 > memoryStats

# collect total memory space in kB
totalmem=$( cat memoryStats | grep -i memtotal | gawk '{ print $2 }' )

# collect free memory space in kB and save in file
freemem=$( cat memoryStats | grep -i memfree | gawk '{ print $2 }' )
echo $freemem > /tmp/task2/systemStats/freeMemory/freeMemory_$timeStamp

# collect used memory space in kB and save in file
usedmem=$(( totalmem - freemem))
echo $usedmem > /tmp/task2/systemStats/usedMemory/usedMemory_$timeStamp

# collect cpu utilization and save in file
ps -aux | grep -v -i %cpu | gawk '{ sum += $3 } END { print sum }' > /tmp/task2/systemStats/cpuUtils/cpuutil_$timeStamp


# Modification:
# Adding data to html files.

# Preparing data:
usedDisk=$( cat /tmp/task2/systemStats/usedDisk/usedDiskSpace_$timeStamp | grep -i total | gawk '{ print $2 }' )
freeDisk=$( cat /tmp/task2/systemStats/freeDisk/freeDiskSpace_$timeStamp | grep -i total | gawk '{ print $2 }' )
cpuUtil=$( cat /tmp/task2/systemStats/cpuUtils/cpuutil_$timeStamp )

#echo $usedDisk, $freeDisk, $cpuUtil, $usedmem, $freemem

# Adding Disk Data:
echo -n "\<tr\>\<td\>$timeStamp\</td\>\<td\>$usedDisk\</td\>\<td\>$freeDisk\</td\>\</tr\>" >> /tmp/task2/tables/disk.table

table=$( cat /tmp/task2/tables/disk.table)
#echo $table
sed "s,\*data\*,$table," /var/www/html/diskUsage.format > /var/www/html/diskUsage.html

# Adding Memory Data:
echo -n "\<tr\>\<td\>$timeStamp\</td\>\<td\>$usedmem\</td\>\<td\>$freemem\</td\>\</tr\>" >> /tmp/task2/tables/memory.table

table=$( cat /tmp/task2/tables/memory.table )
#echo $table
sed "s,\*data\*,$table," /var/www/html/memoryUsage.format > /var/www/html/memoryUsage.html

# Adding cpu data:
echo -n "\<tr\>\<td\>$timeStamp\</td\>\<td\>$cpuUtil\</td\>\</tr\>" >> /tmp/task2/tables/cpu.table

table=$( cat /tmp/task2/tables/cpu.table )
#echo $table
sed "s,\*data\*,$table," /var/www/html/cpuUsage.format > /var/www/html/cpuUsage.html


# Calculate averages:
sh /tmp/task2/calAvgs.sh
