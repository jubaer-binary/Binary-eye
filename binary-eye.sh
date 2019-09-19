logfile="scan_$(date +%Y%m%d_%H%M%S).log"
masscan -p0-65535 --max-rate 10000 -Pn -vv -iL ../hosts.txt | grep "Discovered open port" | awk {'print $6":"$4'} | awk -F/ {'print $1'}| sort -u >> /root/BinaryEye/$logfile

old="$(ls /root/BinaryEye -lt | grep nmap_tcp__scan | awk 'NR==2,NR==2 {print $9}')"
new="$(ls /root/BinaryEye -lt | grep nmap_tcp__scan | awk 'NR==1,NR==1 {print $9}')"

res="$(printf "New ports \n" && printf "\n\n\n\n" &&  comm -3  /root/BinaryEye/$old  /root/BinaryEye/$new |pcregrep -r "\t" && printf "\n\n\n\n" && echo -e  "Closed ports \n" && comm -3  /root/BinaryEye/$old  /root/BinaryEye/$new |pcregrep -v -r "\t")"

sendAlert() {
sendemail -o tls=yes -f "alert@binaryeye.com" -t "alertmail@mail.com" -s "smtp.sendgrid.net:587" -xu apikey -xp "<KEY>" -u "Alerts For Port Activity From Binary Eye" -m "$res"
}


if [[ $(comm -3 /root/BinaryEye/$old /root/BinaryEye/$new) ]]; then sendAlert ; fi
