#! /bin/zsh

ARCH="$(uname -s) version $(uname -r)"
PCPU=$(grep '^physical id' /proc/cpuinfo | uniq | wc -l)
VCPU=$(grep '^processor'   /proc/cpuinfo | uniq | wc -l)

TOTARAM=$(free -m | grep Mem | awk '{print $2}')
USEDRAM=$(free -m | grep Mem | awk '{print $3}')
PERCRAM=$(free    | grep Mem | awk '{printf ("%.2f"), $3/$2*100}')

TOTADISK=$(df -BG --total | grep total | awk '{print $2}')
USEDDISK=$(df -BG --total | grep total | awk '{print $3}')
PERCDISK=$(df -BG --total | grep total | awk '{print $5}')

CPUSED=$(top -bn1 | grep %Cpu | awk '{print $2 + $4 + $6}')
LAST_BOOT=$(who -b | awk '{print($3 " " $4)}')
LVM=$(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi)

ASCII=$(figlet Born2Betterave)

wall "
$ASCII

Architecture			:	$ARCH
Nb of physical processors	:	$PCPU
Nb of  virtual processors	:	$VCPU
RAM  usage			:	${USEDRAM}/${TOTARAM} MiB = ${PERCRAM}%	
DISK usage			:	${USEDDISK}/${TOTADISK} GiB = ${PERCDISK}%
CPU  usage			:	${CPUSED}%
Last boot			:	${LAST_BOOT}
LVM				:	$LVM
"
