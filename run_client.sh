#!/bin/bash

source vars.sh

jackd -R -d alsa -d "$CARD" -p $PERIOD
zita-j2n $MCAST $PORT $IFACE
