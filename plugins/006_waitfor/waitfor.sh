#!/usr/bin/env bash
#Based on https://github.com/eficode/wait-for/blob/master/wait-for

if [ ! -z "$WAITFOR" ]; then
  echo "Waiting for $WAITFOR"
  WAITFOR_HOST=$(printf "%s\n" "$WAITFOR"| cut -d : -f 1)
  WAITFOR_PORT=$(printf "%s\n" "$WAITFOR"| cut -d : -f 2)
  for i in `seq ${WAITFOR_TIMEOUT:-60}` ; do
    nc -z "$WAITFOR_HOST" "$WAITFOR_PORT" > /dev/null 2>&1

    result=$?
    if [ $result -eq 0 ] ; then
      if [ $# -gt 0 ] ; then
        call-next-plugin "$@"
      fi
      return
    fi
    sleep 1
  done
  echo "Operation timed out" >&2
  EXIT_CODE=-1
  return
else
  call-next-plugin "$@"
fi
