#!/bin/bash -
echo "$(date)"
echo "taking snapshot.."
DOWNLOAD_DIR=$(mktemp -d "cg_download.XXXXXXXX")
if [ $CG_USE_TOR -eq 1 ]
then
  echo "trying to connect via tor"
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

for CG_GROUP in $CG_GROUPS
do
  # Download using crabgrass-tools
  /cg_tools/cg-make-snapshot.sh $torflag --base-url $CG_BASE_URL \
    --user $CG_USERNAME --password $CG_PASSWORD \
    --download-directory $DOWNLOAD_DIR --subgroup $CG_GROUP
done
# Backup using borg
echo "backing up downloaded files using borgbackup.."
/bin/borg create /backup::$(date +%Y_%m_%d) $DOWNLOAD_DIR
/bin/borg info /backup::$(date +%Y_%m_%d)

echo "removing download directory"
rm -r $DOWNLOAD_DIR

echo "finished snapshot!"
