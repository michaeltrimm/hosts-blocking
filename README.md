# Hosts Blocking

Small utility that syncronizes the hosts.txt file to the /etc/hosts file.

1. Script installs the `_hosts.txt` into your `/etc/hosts` file

2. A snapshot of the `/etc/hosts` is stored inside `./backups` as `host_YYYYMMDD@HHMMSS.bak`

3. A file named `latest.txt` is created with the contents of the newly created `.bak` file from #2

## Installation

### Prerequisites 

System requirements: `git` `bash` and `sudo`

#### Install GIT

*macOS*: Install `git` via `Homebrew`

    brew install git
    
*Ubuntu*: Install `git` via `apt-get`

    sudo apt-get install git

*CentOS/RHEL*: Install `git` via `yum`

    sudo yum install git

Manually download `git`

    https://git-scm.com/

### Install

From your command line application like `Terminal` or `iTerm2` run the following: 

    git clone https://github.com/michaeltrimm/hosts-blocking.git
    cd hosts-blocking
    sudo ./run.sh --install

## Usage:

Show the help menu...
  
    sudo ./run.sh --help

Copy blocking hosts data to your hosts file
  
    sudo ./run.sh --install

Revert to the previous state of your hosts file
  
    sudo ./run.sh --undo

Revert your hosts file to a stored backup by name
  
[See backups/README.md](backups/README.md)

## Disclaimer

This software is provided "as-is" and comes with absolutely no warranty or guarantee. Please use at your own discretion. No contributor to this project shall be responsible for any issues caused as a result of executing this software. That being said, the software is fully open-source, so have at it... look it over, understand it, and determine on your own merits whether or not you should use it.
