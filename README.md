# crabgrass-backup-docker
crabgrass-backup-docker (CBD) is a a docker image to make crabgrass backups.
This image uses cron, [crabgrass-tools](https://github.com/meitar/crabgrass-tools), tor and borg backup.

## Install
First clone this repository and its submodule:
```
git clone https://github.com/towa/crabgrass-backup-docker.git
cd crabgrass-backup-docker
git submodule init
git submodule update
```
Now you can build the Docker image
```
docker-compose build
```

## Configuration:
Copy `env.example` and change it to your liking.
```
cp env.example .env
```
The most important Variables are probably your wiki username and password.
You can change the backup time in the `etc/crontab` file.
If you are happy with your config simply run:
```
docker-compose up -d
```

Have fun
