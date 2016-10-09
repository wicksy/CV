#!/bin/bash -x
#
# Apply Salt States

# Create Salt Links for States and Pillar
#
mkdir -p /srv
ln -sf "$(pwd)/salt/roots" /srv/salt
ln -sf "$(pwd)/salt/pillar" /srv/pillar

# Apply States
#
salt-call --local -l debug state.apply

docker ps
sleep 30
curl "http://localhost:8080"

salt-call --version

exit 0
