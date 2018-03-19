#!/usr/bin/env bash

#!/usr/bin/env bash

plugin-is-active() {
  echo "===== Plugin is activated $1 ====="
}
call-next-plugin() {
   echo "$@"  
}
source waitfor.sh

