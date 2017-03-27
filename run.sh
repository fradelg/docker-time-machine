#!/bin/bash
if [ -n "${INIT_BACKUP}" ]
then
  echo "=> Creating a first backup as requested ..."
  /backup.sh
fi

echo "${CRON_TIME} /backup.sh >> /backup.log 2>&1" > /crontab.conf
crontab /crontab.conf
echo "=> Running cron task manager"
exec crond -f
