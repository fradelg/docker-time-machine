#!/bin/bash
MAX_BACKUPS=${MAX_BACKUPS}
BACKUP_NAME=$(date +\%Y.\%m.\%d)
BACKUP_DIR="/backup"

cd ${BACKUP_DIR}
if [ -d "$BACKUP_NAME" ]
then
  mkdir ${BACKUP_NAME}
fi

echo "=> Backup started at dir \${BACKUP_NAME}"
rsync -a --link-dest=/backup/current /target/ ${BACKUP_NAME}/
echo "=> Backup finished"

echo "=> Link 'current' to this last backup"
rm -f current
ln -s ${BACKUP_NAME} current

if [ -n ${MAX_BACKUPS} ]
then
    while [ $(ls /backup -N1 | wc -l) -gt ${MAX_BACKUPS} ]
    do
        BACKUP_TO_BE_DELETED=$(ls /backup -N1 | sort | head -n 1)
        echo "  Backup ${BACKUP_TO_BE_DELETED} is deleted"
        rm -rf /backup/${BACKUP_TO_BE_DELETED}
    done
fi
echo "=> Backup done"
