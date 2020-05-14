#!/bin/bash

# if no command argument is given, a set of instructions will help you

if ["$1" == ""]
then 
echo "You need to provide an IP address"
echo "Example : ./ipsweep.sh 193.189.0"

else 

# scan all 255 ports and ping each one to see which ones respond

for ip in {1..254}; do
ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done

fi