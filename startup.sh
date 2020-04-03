#!/bin/bash -
# init tor
echo "$(date)"
echo "Starting the crapgrass backup container"
if [ $CG_USE_TOR -eq 1 ]
then
  echo "starting tor"
  tor -f /etc/tor/torrc &>/dev/null &
fi
# init borg repo
/bin/borg init --encryption=repokey /backup
# do a backup run
if [ $CG_RUN_AT_STARTUP -eq 1 ]
then
  /cg_tools/backup.sh
fi
crond -f
