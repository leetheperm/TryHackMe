# Vulnversity

## Recon and scanning machine

first thing's first. save that IP
```
export IP=10.10.12.13
```
ping it until it is given us a response

let's run a scan against this machine using NMAP

```
nmap -sV -vv $IP
```
nmap flag	Description
-sV			Attempts to determine the version of the services running

-p or -p-	Port scan for port <x> or scan all ports

-Pn			Disable host discovery and just scan for open ports

-A			Enables OS and version detection, executes in-build scripts for further enumeration 

-sC			Scan with the default nmap scripts
-v			Verbose mode
-sU			UDP port scan
-sS			TCP SYN port scan

Questions

### 2  Scan the box, how many ports are open?
### 3 	What version of the squid proxy is running on the machine? 3.5.12
### 4 	How many ports will nmap scan if the flag -p-400 was used? 400
### 5 	Using the nmap flag -n what will it not resolve? DNS
### 6 	What is the most likely operating system this machine is running? Ubuntu
### 7 	What port is the web server running on? 3333
### 8 	Its important to ensure you are always doing your reconnaissance thoroughly before progressing. Knowing all open services (which can all be points of exploitation) is very important, don't forget that ports on a higher range might be open so always scan ports after 1000 (even if you leave scanning in the background)

## Locating directories

Download GoBuster


