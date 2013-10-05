#!/bin/bash
NOW=$(date +"%Y%m%d%H%M")
mkdir $NOW
chmod 777 $NOW
touch $NOW/sifreler.txt
chmod 777 $NOW/sifreler.txt

source /opt/zimbra/backup/zm.conf 

for i in `zmprov -l gaa | egrep -v 'galsync|spam|ham|virus|stimpson'`;
do
	echo $i , `zmprov -l ga $i userPassword | grep userPassword | sed 's/userPassword: //'` >> $WORKDIR/$NOW/sifreler.txt
	echo "$i , `zmprov -l ga $i userPassword | grep userPassword | sed 's/userPassword: //'`";
	curl -k -u $ADMINUSER:$ADMINPASS https://$URLAL:7071/home/$i/?fmt=tgz > $WORKDIR/$NOW/$i.tgz 
	echo '------------------------------------------------------------------------------'
done;
echo "işlem bitti"
