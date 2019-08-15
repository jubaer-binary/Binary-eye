#!/bin/bash
#Colors
RED=$(echo -en '\001\033[00;31m\002')
GREEN=$(echo -en '\001\033[00;32m\002')
WHITE=$(echo -en '\001\033[01;37m\002')

echo "
${RED}
  .  . .  .  . .  . . . . . . . . . .  .  . .  .
   .       .                          .       .
     .  .    .  . . . . . . .  .  .     . .     .
 .       .          .;tSSX%%:.   .  .       .
   .  .    .  :@tSX t8888888@%; ;t@. . .  .   . .
  .    .  . :t @@8@@S8@tSS@@8S88@@8 S:      .
    .    .8@:888t %;888888X@@8;X ;888:88: .    .
  .   .;: 8@8  8t:@S88888@8@8SXX.:8: 8@8 :: .    .
 .    %X888.S   S8@88888@8888@@88S   X.888S%  .
   ..S.@8tt%  :@@8888;@888;@8888@8@:  %:;X8.S.  .
 . ;888@%%   t@8888@8S%888SX888@88.@t  .t%@@88;
  .8888;  . .%%888@X.  t8: 8;S88@888 .    ;8888. .
 .:888..    %88888X%. .@88S%8@:@888888:   ..888:.
 %8@@8    . @@8888XtS X@@888@@tX888@88:     8888%
 .888X  .   8:88@8S:88888888@@:%8;@8   .    X@88.
 S 8@ %     888;X888tS@88888XSS88@8888   . %.8@ S
  S 88 8 . .tX8@888@88t .: t@8888888@%    8.88 %
 . S @8;8  .:88888S88S8:.:.XX88@;@888. . 8SX8.X .
    8 8@S.; .:88888888888@888@88X888%  ;:XS8 @
   .  :;X8SSX:t8X88 @8@8888@88888 8t X%@@@;..   .
 .    .SX@X8X%t.:88888;X88@88:S 8..t 8@88XS   .
        :S X@8SX 8S%8X8XXS %8;%t8 88888 @:      .
  . .  .   t;@t8888X.88@tS@8StX888@%X:t     . .
             .tX8S8@8888888@@@@8SS%;            .
  .  .      .  ..t@X.;X8888X%.%8S .  .    . .
   .   .  .           .        .   .    .     .  .
     .   .   .  . .  .      .         .    .   .
 .     .   .        .    .   . .  .      .   .
   .         . .  .   . .  .  .  .  .  .   .    .

${GREEN}
 ____   ____  ____    ____  ____   __ __        ___  __ __    ___
|    \ |    ||    \  /    ||    \ |  |  |      /  _]|  |  |  /  _]
|  o  ) |  | |  _  ||  o  ||  D  )|  |  |     /  [_ |  |  | /  [_
|     | |  | |  |  ||     ||    / |  ~  |    |    _]|  ~  ||    _]
|  O  | |  | |  |  ||  _  ||    \ |___, |    |   [_ |___, ||   [_
|     | |  | |  |  ||  |  ||  .  \|     |    |     ||     ||     |
|_____||____||__|__||__|__||__|\_||____/     |_____||____/ |_____|

Binary Eye monitors your existing ports and if any port goes down or if there's a new port it will send a mail to you.
By Jubaer Alnazi 
${WHITE}Enter Domain:"
read domains
while true
do
echo "${GREEN}...................................................................."
echo "${WHITE}Domain: ${GREEN}$domains"
NMAP=$(nmap $domains | GREP_COLORS='mt=01;32' egrep --color=always 'open|\closed')
sleep 50
NMAP2=$(nmap $domains | GREP_COLORS='mt=01;32' egrep --color=always 'open|\closed')
echo "${GREEN}...................................................................."
if [ "$NMAP" == "$NMAP2" ]; then
    echo "${GREEN}Seems Like No Ports Have Been Opened!"
else
    echo "${RED}ALERT! A NEW PORT WAS DETECTED" | sendemail -o tls=yes -f from@gmail.com -t to@gmail.com -s smtp.gmail.com:587 -xu username@gmail.com -xp PASSWORD -u "ALERT - NEW PORT ACTIVITY WAS DETECTED $domains" -m "New Port list-
$NMAP2"

exit 1
fi
done
