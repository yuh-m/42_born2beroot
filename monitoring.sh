#!/bin/bash

architecture=$(uname -a)
physical_processor=$(grep 'cpu cores' /proc/cpuinfo | tr -d 'cpu cores \t:')
virtual_processor=$(grep -c '^processor' /proc/cpuinfo)
total_memory=$(free -m | awk '/Mem:/ {print $2}')
used_memory=$(free -m | awk '/Mem:/ {print $3}')
utilization_rate_memory=$(free -m | awk '/Mem:/ {printf("%.2f"), $3/$2*100}')
total_disk=$(df -h --total | awk '/total/ {print $2}')
used_disk=$(df -h --total | awk '/total/ {print $3}')
utilization_rate_disk=$(df -h --total | awk '/total/ {print $5}')
cpu_load=$(top -bn1 |awk '/Cpu/ {print $2}')
last_boot=$(who -b | awk '{print $3" "$4}')
total_lvm=$(lsblk | grep -c lvm)
tcp_connections=$(ss | grep -c tcp)
count_users=$(who -u | awk '{print $1}' | uniq | wc -l)
ip=$(hostname -I | awk '{print $1}')
mac=$(ip addr show | awk '/link\/ether/ {print $2}')
count_sudo=$(cat /var/log/sudo/sudo.log | grep -c "COMMAND=")
if [ $total_lvm -gt 0 ]
then
    lvm='yes'
else
    lvm='no'
fi

wall << .
    #Architecture: $architecture
    #CPU physical: $physical_processor
    #vCPU: $virtual_processor
    #Memory Usage: $used_memory/${total_memory}MB (${utilization_rate_memory}%)
    #Disk Usage: $used_disk/${total_disk}GB (${utilization_rate_disk}%)
    #CPU load: $cpu_load%
    #Last boot: $last_boot
    #LVM use: $lvm
    #Connections TCP: $tcp_connections ESTABLISHED
    #User log: $count_users
    #Network: IP $ip ($mac)
    #Sudo: $count_sudo cmd
.
