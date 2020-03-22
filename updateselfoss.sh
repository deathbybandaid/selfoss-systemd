#!/bin/bash

sleep_timeout=30s

while true
do
  LOOPSTART=$(date +"%s")

  printf "\nUpdating Selfoss - $LOOPSTART"

  /usr/bin/php /var/www/html/selfoss/cliupdate.php

  LOOPEND=$(date +"%s")

  printf "\nUpdating Selfoss Completed - $LOOPEND"

  DIFFTIMELOOPSEC=`expr $LOOPEND - $LOOPSTART`
  if [[ $DIFFTIMELOOPSEC -ge 60 ]]
  then
    DIFFTIMELOOPMIN=`expr $DIFFTIMELOOPSEC / 60`
    LOOPTIMEDIFF="$DIFFTIMELOOPMIN Minutes."
  elif
    [[ $DIFFTIMELOOPSEC -lt 60 ]]
  then
    LOOPTIMEDIFF="$DIFFTIMELOOPSEC Seconds."
  fi

  printf "\nSelfoss Update Took $LOOPTIMEDIFF"

  printf "\nSleeping for $sleep_timeout"
  sleep $sleep_timeout

done
