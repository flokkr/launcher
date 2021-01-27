#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -n "$SLEEP_SECONDS" ]; then
    echo "Waiting for $SLEEP_SECONDS seconds"
    sleep $SLEEP_SECONDS
fi

call-next-plugin "$@"

if [ -n "$SLEEP_AFTER_SECONDS" ]; then
    echo "Waiting for $SLEEP_SECONDS seconds"
    sleep $SLEEP_AFTER_SECONDS
fi
