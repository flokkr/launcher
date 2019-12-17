#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ "$GIT_CLONE" ]; then
   cd /tmp/
   git clone --depth=1 $GIT_CLONE
fi

call-next-plugin "$@"
