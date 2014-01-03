#!/bin/bash
CWD=$(pwd)
source $CWD/zm.conf


echo 'yedek klasor adi'
read yedekklasor

while read line
do 
email=$(echo $line | awk '{print $1}')
sifre=$(echo $line | awk '{print $3}')

echo $email 'hesabı işlemi'
echo 'hesap oluşturuluyor'


if [ $email != $ADMINEMAIL ]; then
        zmprov ca $email 123456
        echo 'hesap değiştiriliyor'
        zmprov ma $email userPassword $sifre

fi




#curl -k -u $ADMINUSER:$ADMINPASS https://$URLAL:7071/home/$MAIL/?fmt=tgz > $WORKDIR/$yedekklasor/$MAIL.tgz
echo 'yedek dosyası yükleniyor'
curl -k --data-binary @$WORKDIR/$yedekklasor/$email.tgz -u $ADMINUSER:$ADMINPASS https://$URLVER:7071/service/home/$email/?fmt=tgz
echo '-----------------------------------------------------------------'

done < $yedekklasor/sifreler.txt
echo 'işlem bitti'
