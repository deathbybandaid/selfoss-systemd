#!/bin/bash

sleep_timeout=30s

phppath=`which php`
selfoss_path="/var/www/html/selfoss"
selfoss_cli_script="$selfoss_path/cliupdate.php"

while true
do
  LOOPSTART=$(date +"%s")

  printf "\nUpdating Selfoss - $LOOPSTART"

  "$phppath" "$selfoss_cli_script"

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
