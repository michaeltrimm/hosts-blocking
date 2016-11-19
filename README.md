# Hosts Blocking

Small utility that syncronizes the hosts.txt file to the /etc/hosts file.

## Usage:

Show the help menu...
  
    sudo ./run.sh --help

Copy blocking hosts data to your hosts file
  
    sudo ./run.sh --install

Revert to the previous state of your hosts file
  
    sudo ./run.sh --undo

Revert your hosts file to a stored backup by name
  
    sudo ./run.sh --revert-to=YYYYMMDD@HHMMSS

