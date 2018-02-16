# requirements:
# jackd
# zita-njbridge

## install required stuff
apt install -y jackd zita-njbridge


## setup app dir in /opt/ipaudio
mkdir /opt/ipaudio

# for client
echo export ROLE=client >> vars.sh
# for server
echo export ROLE=server >> vars.sh

cp ipaudio /opt/ipaudio/ipaudio
cp vars.sh /opt/vars.sh
cp ipaudio_client /opt/ipaudio/ipaudio_client
cp ipaudio_server /opt/ipaudio/ipaudio_server

ln -s /opt/ipaudio/ipaudio* /usr/local/bin/

## copy crontab
CRONTAB='/var/spool/cron/crontabs/perry'
echo "@reboot /usr/local/bin/ipaudio" >> $CRONTAB
