#!/bin/bash

# This script counts minutes from 1 to 10
x=1
while [ $x -le 10 ]
do
        x=$(( $x + 1 ))
        sleep 1m
done
