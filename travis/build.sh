#!/bin/bash -x
#
# Build - Apply Salt States
#

# Exit on errors
#
set -e
set -u
set -o pipefail

# Create Salt Links for States and Pillar
#
mkdir -p /srv
ln -sf "$(pwd)/salt/roots" /srv/salt
ln -sf "$(pwd)/salt/pillar" /srv/pillar

# Apply States
#
salt-call --local -l debug state.apply

exit 0
