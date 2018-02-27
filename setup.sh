#!/bin/bash


ROLE='source'
USERNAME=perry

USER_HOME=/home/$USERNAME
SRC_DIR=$USER_HOME/deploy/ipaudio
SYSTEMD_SRC_DIR=$SRC_DIR/systemd
SYSTEMD_USER_DIR=$USER_HOME/.config/systemd/user
SYSTEMD_SET_UNIT="ipaudio-$ROLE"

## install required stuff
apt install -y jackd zita-njbridge alsa-utils

## copy stuff to SYSTEMD_USR_DIR
su -c "mkdir -p $SYSTEMD_USER_DIR" $USERNAME

cp -p $SYSTEMD_SRC_DIR/jackd.service $SYSTEMD_USER_DIR
cp -p $SYSTEMD_SRC_DIR/ipaudio-sink/* $SYSTEMD_USER_DIR
cp -p $SYSTEMD_SRC_DIR/ipaudio-source/* $SYSTEMD_USER_DIR

cp $SRC_DIR/wait_zita_sink /usr/local/bin/
cp $SRC_DIR/wait_zita_source /usr/local/bin/

# add pam_limits.so to /etc/pam.d/systemd-user
echo "session  required pam_limits.so" >> /etc/pam.d/systemd-user

# set role
su -c "systemctl --user daemon-reload" $USERNAME
su -c "systemctl --user enable $SYSTEMD_SET_UNIT" $USERNAME
loginctl enable-linger $USERNAME

# pull up alsamixer for tty1, should be automatic
echo '[[ $(tty) = "/dev/tty1" ]] && exec alsamixer' >> $USER_HOME/.bashrc
