#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -z "$FLOKKR_DEBUG" ]; then
  set -x
fi

echo "Flokkr launcher script $(git --work-tree=$DIR --git-dir=$DIR/.git describe --tags)"
plugin-is-active() {
  echo "===== Plugin is activated $1 ====="
}
call-next-plugin() {
  shift 1
  source $PLUGIN_DIR/$1/${1:4}.sh
}


if [ "$LAUNCHER_UPDATE" ]; then
  echo "Pulling latest launcher script"
  cd $DIR
  sudo git branch -u origin/master master
  sudo git fetch origin
  sudo git checkout ${LAUNCHER_GITREF:-origin/master}
  cd -
fi

#For compatibility reason: remove the old btrace location
sudo rm -rf /opt/launcher/plugins/020_btrace

export CONFIG_TYPE="simple"
export RUNTIME_ARGUMENTS="$@"
echo ""
export PLUGIN_DIR="$DIR/plugins"
source $PLUGIN_DIR/002_permissionfix/permissionfix.sh $(ls -1 $PLUGIN_DIR | sort);
exit $EXIT_CODE
