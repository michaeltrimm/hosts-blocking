# Hosts Blocking Generator

From time to time new websites will get added to this list. The `hosts.txt` file in this directory (which is ignored by git inside `.gitignore`) will be read by the `remove_duplicates.php` script and processed. The output will be stored inside `_hosts.txt` which will be consumed by `_run.sh`. Every time the `remove_duplicates.php` script is executed, a new set of *boundaries* are created inside the `_hosts.txt` which will trigger new backups to be made. If no changes are made to the `hosts.txt` file and the script is executed, there will be no difference between one set of *boundaries* and another, which may cause unexpected results.

In order to protect the integrity of `_hosts.txt` file, the results inside `hosts.txt` will be shuffled every time they are re-generated to add a simple layer of obfuscation.

## Installation

System requirements: `php v5.4+`

*macOS*: Install `php` via `Homebrew`

    brew install homebrew/php/php70

*Ubuntu*: Install `php` via `apt-get`

    sudo apt-get install php5-cli

*CentOS/RHEL 7.x*: Install `php` via `yum`

    rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
    
    yum install php70w-cli

*CentOS/RHEL 6.x*: Install `php` via `yum`

    rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
    
    yum install php70w-cli

## Usage

    php remove_duplicates.php

## hosts.txt file format

    0.0.0.0 domaintoblock.ext
    0.0.0.0 anotherdomaintoblock.ext