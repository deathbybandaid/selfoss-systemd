#!/bin/bash

sleep_timeout=15s

phppath=`which php`
selfoss_path="/var/www/html/selfoss"
selfoss_cli_script="$selfoss_path/cliupdate.php"
selfoss_cache_files="$selfoss_path/data/cache/*.spc"

cache_clear_count=0

while true
do
  LOOPSTART=$(date +"%s")

  printf "\nUpdating Selfoss - $LOOPSTART"
  
  if [[ $cache_clear_count -ge 5 ]]
  then
    if ls $selfoss_cache_files &> /dev/null;
    then
      printf "\nClearing Cache"
      rm $selfoss_cache_files
    else
      printf "\nCache Empty, Not Clearing"
    fi
    cache_clear_count=0
  else
    cache_clear_count=$((cache_clear_count + 1))
  fi

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
