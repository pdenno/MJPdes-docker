#!/bin/bash

set -e

if [ "$1" = '/bin/bash' ]
then
    exec /bin/bash
else
    exec /MJPdes/target/MJPdes "$@"
fi
