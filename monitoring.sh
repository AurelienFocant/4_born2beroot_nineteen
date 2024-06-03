#! /bin/zsh

ARCH="$(uname -s) version $(uname -r)"
PCPU=$(grep '^physical id' /proc/cpuinfo | uniq | wc -l)
VCPU=$(grep '^processor'   /proc/cpuinfo | uniq | wc -l)

TOTARAM=$(free -m | grep Mem | awk '{print $2}')
USEDRAM=$(free -m | grep Mem | awk '{print $3}')
PERCRAM=$(free    | grep Mem | awk '{printf ("%.2f"), $3/$2*100}')

TOTADISK=$(df -BG | awk '{td += $2} END {print td}')
USEDDISK=$(df -BG | awk '{ud += $3} END {print ud}')
PERCDISK=$(df -BG | awk '{td += $2} {ud += $3} END {printf ("%.2f"), ud/td*100}')

CPUSED=$(top -bn1 | grep %Cpu | awk '{print $2 + $4 + $6}')

echo	"
Architecture:			$ARCH
Nb of physical processors:	$PCPU
Nb of  virtual processors:	$VCPU
RAM  usage:			${USEDRAM}/${TOTARAM} MiB = ${PERCRAM}%	
DISK usage:			${USEDDISK}/${TOTADISK} GiB = ${PERCDISK}%
CPU  usage:			$CPUSED%
"
