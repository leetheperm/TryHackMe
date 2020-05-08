# Metasploit cheat sheet

## Framework Components

### Metasploit Meterpreter

Run as a DLL injection payload on a target PC providing control over the target system

### Metasploit msfvenom

Help create standalone payloads as executable, Ruby script, or shellcode

## Meterpreter commands

* for some reason the command is above the description

Basic and file handling commands:

```
sysinfo
```
Display system information


```
ps
```
List and display running processes

```
kill (PID)
```
Terminate a running process

```
getuid
```
Display user ID
```
upload or download
```
	

Upload / download a file
```
pwd or lpwd
```
	

Print working directory (local / remote)
```
cd or lcd
```
	

Change directory (local or remote)
```
cat
```
	

Display file content 
```
bglist
```
	

Show background running scripts
```
bgrun
```
Make a script run in background 
```
Bgkill
```
Terminate a background process
```
background
```
Move active session to background
```
edit 
```
Edit a file in vi editor
```
shell
```
Access shell on the target machine
```
migrate 
```
Switch to another process
```
idletime
```
Display idle time of user
```
screenshot
```
Take a screenshot
```
clearev
```
Clear the system logs
```
? or Help 
```
Shows all the commands 
```
exit / quit: 
```
Exit the Meterpreter session
```
shutdown / reboot
```
Restart system
```
use
```
Extension load
```
channel
```
Show active channels