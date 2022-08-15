#!/bin/bash

# SELinux must be running in the Enforcing mode (permanent even after reboot).

# change configuration in SELinux configuration file /etc/sysconfig/selinux
# to enforcing mode.
lineNo = $(grep -n ^SELINUX= /etc/sysconfig/selinux | cut -c1)
sed -i $lineNo's/permissive/enforcing/' /etc/sysconfig/selinux

echo reboot system using \'reboot\' command, for enforcing mode to work ...