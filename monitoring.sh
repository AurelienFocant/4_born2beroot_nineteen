#! /bin/zsh

ARCH="$(uname -s) version $(uname -r)"
PCPU=$(grep '^physical id' /proc/cpuinfo | uniq | wc -l)
VCPU=$(grep '^processor'   /proc/cpuinfo | uniq | wc -l)

TOTARAM=$(free -m | grep Mem | awk '{print $2}')
USEDRAM=$(free -m | grep Mem | awk '{print $3}')
PERCRAM=$(free    | grep Mem | awk '{printf ("%.2f"), $3/$2*100 }')

echo	"
Architecture:			$ARCH
Nb of physical processors:	$PCPU
Nb of  virtual processors:	$VCPU
RAM usage:			${USEDRAM}/${TOTARAM} MiB = ${PERCRAM}%	
"
