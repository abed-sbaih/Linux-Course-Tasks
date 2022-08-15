#!/bin/bash

# In this part we should create a physical volume, and an extent with size of 16M,
# then create a volume group, and create a logical volume out of it, having size of 50 extents
# then the LV should be mounted under /mnt/data directory.

# Suppose a second disk is already installed on the server
# The disk used in this scenario is /dev/sdb
# Create a partition with the full size of the disk, and change its system to Linux LVM,
# in order to use it in creation of LVs.
(printf 'n\n';
 printf 'p\n';
 printf '\n';
 printf '\n';
 printf '\n';
 printf 't\n';
 printf '8e\n';
 printf 'p\n';
 printf 'w\n';) | fdisk /dev/sdb

# There is only one partition of the disk
# Create physical volume on the partition
pvcreate /dev/sdb1

# Show the created physical volume
echo
echo 'Physical Volumes:'
pvs

# create the volume group (vg1), with extent having 16M size
# the directory of the volume group is /dev/vg1
vgcreate -s 16M vg1 /dev/sdb1

# Show the volume group
echo
echo 'Volume Groups:'
vgs

# create the logical volume (lv1) with 50 extents size
# the directory of the logical volume is /dev/vg1/lv1
lvcreate -l 50 -n lv1 vg1

# view logical volumes
echo
echo 'Logical Volumes:'
lvs

# create file system for the logical volume created with type 'ext4'
mkfs -t ext4 /dev/vg1/lv1

# mount the file system on /mnt/data
mkdir /mnt/data
mount /dev/vg1/lv1 /mnt/data

# show that the LV was created and mounted
echo
echo 'File Systems:'
df -h | grep /mnt/data



