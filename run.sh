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

if [ "$EUID" -ne 0 ]
  then printf "Please run as ${RED}root${NC} using ${YELLOW}sudo ./update-hosts.sh${NC}\n\n"
  exit
fi

function undo {
  exit
}

function revertto {
  exit
}

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
  printf "    Revert your hosts file to a stored backup by name\n"
  printf "    ${RED}sudo ./run.sh --revert-to=YYYYMMDD@HHMMSS${NC}\n"
  printf "\n\n"

}

function install {
  
  # Boundary is generated based on when the _hosts.txt file is generated
  BOUNDARY1=$(sed -n '1p' ${HOSTS_DATA_FILE})
  BOUNDARY2=$(sed -n '$p' ${HOSTS_DATA_FILE})

  # Check if the boundary already exists in the hosts file, if it does, then the install has already happened
  EXISTING=$(sed -n "/\\${BOUNDARY1}/,/\\${BOUNDARY1}/p" ${HOSTS_FILE})

  if [ "${EXISTING}" == "" ]
  then
  
    # Not yet installed
    printf "Installing ${HOSTS_DATA_FILE} inside of ${HOSTS_FILE}..."
  
    cat ${HOSTS_FILE} >> ./backups/hosts_${NOW}.bak
  
    echo "hosts_${NOW}.bak" > ./backups/latest.txt
  
    RECORDS="$(cat ${HOSTS_DATA_FILE})"
  
    echo "
${RECORDS}" >> /etc/hosts
  
    CHECK=$(sed -n "/\\${BOUNDARY1}/,/\\${BOUNDARY1}/p" ${HOSTS_FILE})
    if [ "${CHECK}" == "" ]
    then printf " ${RED}X${NC}\n\n"
    else printf " ${GREEN}✓${NC}\n\n"
    fi
  
    exit

  else
  
    printf "${RED}Already installed ${HOSTS_DATA_FILE} hosts inside ${HOSTS_FILE}!\n\n"
    exit

  fi
  
}



REVERTTO=""


for i in "$@"
do
case $i in
    -i|--install)
    install
    shift # past argument=value
    ;;
    -u|--undo)
    undo
    shift # past argument=value
    ;;
    -rt=*|--revert-to=*)
    REVERTTO="${i#*=}"
    shift # past argument=value
    ;;
    -h|--help)
    readme
    shift # past argument with no value
    ;;
    *)
    ;;
esac
done


