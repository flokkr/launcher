#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "true" == "$BYTEMAN_ENABLED" ] || [ -n "$BYTEMAN_SCRIPT" ] || [ -n "$BYTEMAN_SCRIPT_URL" ]; then
  plugin-is-active "BYTEMAN"

  BYTEMAN_DIR=/opt/byteman
  #install btrace
  if [ ! -d $BYTEMAN_DIR ]; then
     sudo mkdir -p $BYTEMAN_DIR
     sudo wget https://kv.anzix.net/byteman.jar -O /opt/byteman/byteman.jar
  fi

  BYTEMAN_OPTS_VAR=${BYTEMAN_OPTS_VAR:-JAVA_OPTS}
  export PATH=$PATH:$BYTEMAN_DIR/bin

  if [ ! -z "$BYTEMAN_SCRIPT_URL" ]; then
    sudo wget $BYTEMAN_SCRIPT_URL -O /tmp/byteman.btm
    export BYTEMAN_SCRIPT=/tmp/byteman.btm
  fi

  if [ ! -f "$BYTEMAN_SCRIPT" ]; then
    echo "ERROR: The defined $BYTEMAN_SCRIPT does not exist!!!"
    exit -1
  fi

  AGENT_STRING="-javaagent:/opt/byteman/byteman.jar=script:$BYTEMAN_SCRIPT"
  declare -x $JAVA_OPTS_VAR="$AGENT_STRING $JAVA_OPTS"
  echo "Process is instrumented with setting $BYTEMAN_OPTS_VAR to $AGENT_STRING"
  echo "Standard output is replaced with btrace output"
fi

call-next-plugin "$@"
