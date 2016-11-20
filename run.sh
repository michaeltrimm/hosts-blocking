#!/bin/bash
# 
# update /etc/hosts to block annoying websites
#
# @version @package_version@
# @author Michael A. Trimm
# @website https://github.com/michaeltrimm
#
#

# Configuration
HOSTS_DATA_FILE="_hosts.txt"
HOSTS_FILE="/etc/hosts"

# Script Variables
NOW=$(date '+%Y%m%d@%H%M%S');
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
WHITE='\033[1;33m'
LIGHTBLUE='\033[1;34m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m'

set -o errexit

# Will attempt to undo the changes made by the script to the /etc/hosts file
function undo {
  
  UNDO_FILE=$(cat backups/latest.txt)
  UNDO_HOSTS=$(cat ./backups/${UNDO_FILE})
  
  printf "Uninstalling ${HOSTS_DATA_FILE} from ${HOSTS} with ${UNDO_FILE} backup"
  
  PREVIOUS_BACKUP=$(find ./backups/* -type f -name '*.bak' -not -name "${UNDO_FILE}" | sort -r -k1 | head -1)
    
  if [ "${PREVIOUS_BACKUP}" == "" ]
  then 
    printf "\nno backup found...\n"
    uninstall
  else     
    cat /etc/hosts > "./backups/hosts_${NOW}.undone"
    echo "${UNDO_HOSTS}" > /etc/hosts
  
    rm -f ./backups/latest.txt
    cat $PREVIOUS_BACKUP > ./backups/latest.txt
  fi
  
  printf " ${GREEN}✓${NC}\n\n"
  exit
}

# Reverts the /etc/hosts file to the ./backups/original.txt
function uninstall {
  printf "Uninstalling hosts-blocking from the system"
  cat ./backups/original.txt > /etc/hosts
  rm -f ./backups/*.bak
  rm -f ./backups/*.undone
  rm -f ./backups/*.txt
  printf " ${GREEN}✓${NC}\n\n"
  exit
}

# The help menu and readme for the script (see README.md and backups/README.md)
function readme {
  printf "Hosts Blocking Helper Script\n"
  printf "\n${GREEN}"
  printf "██╗  ██╗███████╗██╗     ██████╗ \n"
  printf "██║  ██║██╔════╝██║     ██╔══██╗\n"
  printf "███████║█████╗  ██║     ██████╔╝\n"
  printf "██╔══██║██╔══╝  ██║     ██╔═══╝ \n"
  printf "██║  ██║███████╗███████╗██║     \n"
  printf "╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     \n"
  printf "${NC}\n"
  printf "\n"
  printf "${BLUE}@author${NC} Michael Trimm <${CYAN}michael@michaeltrimm.com${NC}>\n"
  printf "${BLUE}@website${NC} ${CYAN}https://github.com/michaeltrimm${NC}\n"
  printf "${BLUE}@project${NC} ${CYAN}https://github.com/michaeltrimm/hosts-blocking${NC}\n"
  printf "${BLUE}@note${NC} No support will be provided under any circumstance\n"
  printf "${BLUE}@license${NC} MIT\n"
  printf "\n"
  printf "Usage: \n"
  printf "\n"
  printf "    Show the help menu...\n"
  printf "    ${GREEN}sudo ./run.sh --help${NC}\n"
  printf "\n"
  printf "    Copy blocking hosts data to your hosts file\n"
  printf "    ${GREEN}sudo ./run.sh --install${NC}\n"
  printf "\n"
  printf "    Revert to the previous state of your hosts file\n"
  printf "    ${RED}sudo ./run.sh --undo${NC}\n"
  printf "\n"
  printf "    Uninstalls the entire script and reverts to original\n"
  printf "    ${RED}sudo ./run.sh --uninstall${NC}\n"
  printf "\n\n"
  exit
}

# Installation
function install {
  
  # Boundary is generated based on when the _hosts.txt file is generated
  BOUNDARY1=$(sed -n '1p' ${HOSTS_DATA_FILE})
  BOUNDARY2=$(sed -n '$p' ${HOSTS_DATA_FILE})

  # Check if the boundary already exists in the hosts file, if it does, then the install has already happened
  EXISTING=$(sed -n "/\\${BOUNDARY1}/,/\\${BOUNDARY1}/p" ${HOSTS_FILE})

  if [ "${EXISTING}" == "" ]
  then
    printf "Installing ${HOSTS_DATA_FILE} inside of ${HOSTS_FILE}..."
    
    cat ${HOSTS_FILE} >> ./backups/hosts_${NOW}.bak
    cat ${HOSTS_FILE} >> ./backups/original.txt
    echo "hosts_${NOW}.bak" > ./backups/latest.txt
    RECORDS="$(cat ${HOSTS_DATA_FILE})"
    echo "
${RECORDS}" >> /etc/hosts
    CHECK=$(sed -n "/\\${BOUNDARY1}/,/\\${BOUNDARY1}/p" ${HOSTS_FILE})
    if [ "${CHECK}" == "" ]
    then printf " ${RED}X${NC}\n\n"
    else printf " ${GREEN}✓${NC}\n\n"
    fi
  else
    printf "${RED}Already installed ${HOSTS_DATA_FILE} hosts inside ${HOSTS_FILE}!\n\n"
  fi
  exit
}

# Script requires root for access to /etc/hosts
if [ "$EUID" -ne 0 ]
  then printf "Please run as ${RED}root${NC} using ${YELLOW}sudo ./run.sh${NC}\n\n"
  exit
fi

# If no args are specified, show the readme
if [ -z "$*" ]; then readme; exit; fi

# CLI Arguments Handler
for i in "$@"
do
case $i in
    --install)
    install
    shift
    ;;
    --undo)
    undo
    shift
    ;;
    --uninstall)
    uninstall
    shift
    ;;
    -h|--help)
    readme
    shift
    ;;
    *)
    readme
    ;;
esac
done

# Always end positive
exit 1
