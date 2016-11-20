# Hosts Blocking

Small utility that syncronizes the hosts.txt file to the /etc/hosts file.

1. Script installs the `_hosts.txt` into your `/etc/hosts` file

2. A snapshot of the `/etc/hosts` is stored inside `./backups` as `host_YYYYMMDD@HHMMSS.bak`

3. A file named `latest.txt` is created with the contents of the newly created `.bak` file from #2


## Usage:

Show the help menu...
  
    sudo ./run.sh --help

Copy blocking hosts data to your hosts file
  
    sudo ./run.sh --install

Revert to the previous state of your hosts file
  
    sudo ./run.sh --undo

Revert your hosts file to a stored backup by name
  
    sudo ./run.sh --revert-to=YYYYMMDD@HHMMSS
