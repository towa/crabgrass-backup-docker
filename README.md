# crabgrass-backup-docker
crabgrass-backup-docker (CBD) is a a docker image to make crabgrass backups.
This image uses cron, [crabgrass-tools](https://github.com/meitar/crabgrass-tools), tor and borg backup.

## Configuration:
Copy `env.example` and change it to your liking.
```
cp env.example .env
```
The most important Variables are probably your wiki username and password.
You can change the backup time in the `etc/crontab` file.
If you are happy with your config simply run:
```
sudo docker-compose up -d
```

Have fun
