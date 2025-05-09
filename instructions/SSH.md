# SSH

## Connection to UoA servers
1. First establish a VPN connection

2. Connect to the server via `ssh`
```bash
ssh your_upi@aitken.math.auckland.ac.nz
```
3. Look which of the computational servers is less busy 
```bash
htop
```
and connect into that
```bash
ssh forder.math.auckland.ac.nz
```
4. To execute Julia scripts have a look at the __Installation on a server__ paragraph in [Julia](Julia.md)

## SFTP
1. Connect to the server
```bash
sftp your_upi@maclaurin.math.auckland.ac.nz
```
2. Copy a file from your local system to the remote server
```bash
put /home/papadeiv/path_to_local_file ./path_you_want_to_copy_the_file
```
If the target is a directory then add the `-r` flag to the command

3. Download a file from the remote server to the local system
```bash
get ./path_to_the_remote_file /home/papadeiv/path_you_want_to_download_the_file
```
Same as before if the target is a directory then add the `-r` flag to the command

4. To remove a directory use `rmdir` in lieu of `rm -r`

## Screen sessions
5. To run a `screen` session:
```bash
screen -S <session_name>
echo $STY
```
Now you're logged and can do whatever you want
To detach the screen 
<c-a>
To exit 
<c-d>
Notice that this won't kill the session, in fact
```bash
screen -list
```
will still list the previous <session_name> running in the background.
You can resume it via
```bash
screen -r <session_name>
```
and then, from within the session you can terminate it via
```bash
exit
```
If instead you want to kill one session while keeping others running, then
```bash
screen -X -S <session_name> kill
```

6. To disconnect from the server run
```bash
exit
```
