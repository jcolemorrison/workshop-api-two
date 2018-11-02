#!/bin/sh

# Exit the script on fali
set -e

# Do other set up here, like pull in keys or other SSM encrypted values

# hand back over and run the default command from our docker file which is "node ."
exec "$@"