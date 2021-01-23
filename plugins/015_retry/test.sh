#!/usr/bin/env bash
set -x
call-next-plugin(){
   EXIT_CODE=-1
   echo "$@"
}

export EXIT_CODE=-1
source retry.sh
