#!/bin/bash -x

mkdir -p /srv

ln -sf "$(pwd)/salt/roots" /srv/salt
ln -sf "$(pwd)/salt/pillar" /srv/pillar

ls -l

#salt-call --local -l debug state.apply

#docker ps
#sleep 30
#curl "http://localhost:8080"

#salt-call --version

exit 0
