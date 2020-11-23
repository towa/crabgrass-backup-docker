#!/bin/bash
echo "Taking snapshot.."
if [ $CG_USE_TOR -eq 1 ]
then
  echo "Trying to connect via tor.."
  tortest=$(torsocks wget -qO- https://check.torproject.org/ | grep -m 1 Congratulations)
  if [ "$tortest" ]
  then
    echo "TOR is working :)"
    torflag="--tor"
  else
    echo "TOR is not working.. stoping backup :("
    exit 1
  fi
else
  torflag=""
fi

DOWNLOAD_DIR=$(mktemp -d "$(date +%Y_%m_%d_%).XXXXXXXX")
for CG_GROUP in $CG_GROUPS
do
  # Download using crabgrass-tools
  echo "Downloading $CG_GROUP to $DOWNLOAD_DIR.."
  SECONDS=0
  /cg_tools/cg-make-snapshot.sh $torflag --base-url $CG_BASE_URL \
    --user $CG_USERNAME --password $CG_PASSWORD --quiet \
    --download-directory $DOWNLOAD_DIR --subgroup $CG_GROUP
  duration=$SECONDS
  echo "Finished downloading $CG_GROUP"
  echo "duration: $(($duration / 60))m $(($duration % 60))s"

done
# Backup using borg
echo "Creating backup of files.."
/bin/borg create ::$DOWNLOAD_DIR $DOWNLOAD_DIR/

echo "Removing download directory.."
rm -r $DOWNLOAD_DIR

echo "Removing old backups"
/bin/borg prune --keep-daily=7 --keep-weekly=4 --keep-monthly=-1

echo "Finished snapshot!"
