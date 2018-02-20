#!/bin/bash

TARGET=/opt/ipaudio
ROLE=server
SRC=/home/perry/deploy/ipaudio
USER=perry

## install required stuff
apt install -y jackd zita-njbridge

## setup app dir in /opt/ipaudio
mkdir $TARGET

# copy to $TARGET
cp -u $SRC/ipaudio $TARGET/ipaudio
cp -u $SRC/vars.sh $TARGET/vars.sh
cp -u $SRC/ipaudio_client $TARGET/ipaudio_client
cp -u $SRC/ipaudio_server $TARGET/ipaudio_server

# setup role
sed -i s/ROLE=.*$/ROLE=$ROLE/ $TARGET/vars.sh

# link to $PATH
ln -s $TARGET/ipaudio* /usr/local/bin/

## copy crontab
CRONTAB="/var/spool/cron/crontabs/$USER"
JOB="@reboot /usr/local/bin/ipaudio"

if ! [[ $(crontab -l -u "$USER" | grep "$JOB" ) ]]; then
	echo "$JOB" >> $CRONTAB
fi
