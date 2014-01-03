#!/bin/bash
source /opt/zimbra/backup/zm.conf
NOW=$(date +"%Y%m%d%H%M")
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')

if [ "$CURRENT" -gt "$HARDDISK" ] ; then
echo "harddisk normal degil"
else

mkdir $WORKDIR/$NOW
chmod 777 $WORKDIR/$NOW
touch $WORKDIR/$NOW/sifreler.txt
chmod 777 $WORKDIR/$NOW/sifreler.txt
 

for i in `/opt/zimbra/bin/zmprov -l gaa | egrep -v 'galsync|spam|ham|virus|stimpson'`;
do
        echo $i , `/opt/zimbra/bin/zmprov -l ga $i userPassword | grep userPassword | sed 's/userPassword: //'` >> $WORKDIR/$NOW/sifreler.txt
        echo "$i , `/opt/zimbra/bin/zmprov -l ga $i userPassword | grep userPassword | sed 's/userPassword: //'`";
        curl -k -u $ADMINUSER:$ADMINPASS https://$URLAL:7071/home/$i/?fmt=tgz > $WORKDIR/$NOW/$i.tgz 
        echo '------------------------------------------------------------------------------'
done;
chmod -R 777 $NOW
echo "işlem bitti"




if [ $AKTARMA == "evet" ]; then
echo "karşı sisteme dosya aktarma işlemi başlıyor"
scp -r $WORKDIR/$NOW $AKTARMAADRES
echo "aktarÄ±m iÅŸlemi bitti"
        
        if [ $ESKIVERI == "evet" ]; then
        rm -rf $WORKDIR/$NOW
        echo "oluşturulan klasör silindi"
        fi


fi


fi
