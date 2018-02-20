#!/bin/bash


ROLE='source'
USERNAME=perry

USER_HOME=/home/$USERNAME
SRC_DIR=/$USER_HOME/deploy/ipaudio
SYSTEMD_SRC_DIR=$SRC_DIR/systemd
SYSTEMD_USER_DIR=/home/$USERNAME/.config/systemd/user
SYSTEMD_SET_UNIT="ipaudio-$ROLE"

## install required stuff
apt install -y jackd zita-njbridge alsa-utils

## copy stuff to SYSTEMD_USR_DIR
cp -pr $SYSTEMD_SRC_DIR $SYSTEMD_USER_DIR

# set role
systemctl --user enable $SYSTEMD_SET_UNIT
loginctl enable-linger $USERNAME

# pull up alsamixer for tty1, should be automatic
echo '[[ $(tty) = "/dev/tty1" ]] && exec alsamixer' >> $USER_HOME/.bashrc
