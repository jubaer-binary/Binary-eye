#!/bin/bash
#Colors
RED=$(echo -en '\001\033[00;31m\002')
GREEN=$(echo -en '\001\033[00;32m\002')
WHITE=$(echo -en '\001\033[01;37m\002')
echo"${WHITE}
██████╗ ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗    ███████╗██╗   ██╗███████╗
██╔══██╗██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝    ██╔════╝╚██╗ ██╔╝██╔════╝
██████╔╝██║██╔██╗ ██║███████║██████╔╝ ╚████╔╝     █████╗   ╚████╔╝ █████╗  
██╔══██╗██║██║╚██╗██║██╔══██║██╔══██╗  ╚██╔╝      ██╔══╝    ╚██╔╝  ██╔══╝  
██████╔╝██║██║ ╚████║██║  ██║██║  ██║   ██║       ███████╗   ██║   ███████╗
╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚══════╝   ╚═╝   ╚══════╝
Enter Domain-"
read domains
while true
do
echo "${GREEN}...................................................................."
echo "${WHITE}Domain: ${GREEN}$domains"
NMAP=$(nmap $domains | GREP_COLORS='mt=01;32' egrep --color=always 'open|\closed')
sleep 10
NMAP2=$(nmap $domains | GREP_COLORS='mt=01;32' egrep --color=always 'open|\closed')
echo "${GREEN}...................................................................."
if [ "$NMAP" == "$NMAP2" ]; then
    echo "${GREEN}Seems Like No Ports Have Been Open!"
else
    echo "${RED}ALERT! A NEW PORT WAS DETECTED"
fi
done
