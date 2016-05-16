#!/bin/bash

# Clean up old versions of the wicksy/wickscv container to prevent issue #31595 breaking a highstate
#
# See https://github.com/saltstack/salt/issues/31595 for details
#
# Force an exit 0 to ensure highstate is clean

/usr/bin/docker rm -vf $(/usr/bin/docker ps -aq -f name="wicksycv")

exit 0
