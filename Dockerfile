# we need glibc for borgbackup
FROM frolvlad/alpine-glibc

# install dependencies
RUN apk add --no-cache git tor torsocks wget sed bash tzdata

# install borgbackup
RUN wget -O /bin/borg https://github.com/borgbackup/borg/releases/download/1.1.11/borg-linux64
RUN chmod 755 /bin/borg

# configure tor
COPY etc/torrc /etc/tor/torrc

# copy crabgrass-tools and scripts
COPY crabgrass-tools /cg_tools
COPY backup.sh /cg_tools
COPY startup.sh /cg_tools

# copy crontab
COPY etc/crontab /etc/cron/crontab
RUN crontab /etc/cron/crontab

# set environment
ENV CG_RUN_AT_STARTUP 1
ENV CG_GROUPS myGroup
ENV CG_BASE_URL https://we.riseup.net
ENV CG_USERNAME myUser
ENV CG_PASSWORD changeme!
ENV BORG_PASSPHRASE changeme!
ENV BORG_REPO changeme!
#ENV TZ Europe/Berlin


CMD ["/cg_tools/startup.sh"]
