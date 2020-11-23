#!/bin/bash
echo "Starting CBD - Crabgrass Backup Docker"
# init tor
if [ $CG_USE_TOR -eq 1 ]
then
  echo "Starting tor"
  tor -f /etc/tor/torrc &>/dev/null &
fi
# init borg repo
/bin/borg init --encryption=repokey
# do a backup run
if [ $CG_RUN_AT_STARTUP -eq 1 ]
then
  /cg_tools/backup.sh
fi
crond -f