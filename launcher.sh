#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Flokkr launcher script $(git --work-tree=$DIR describe --tags)"
plugin-is-active() {
  echo "===== Plugin is activated $1 ====="
}
call-next-plugin() {
  shift 1
  source $PLUGIN_DIR/$1/${1:4}.sh
}


if [ -n "$LAUNCHER_UPDATE" ]; then
   echo "Pulling latest launcher script"
   cd $DIR
   sudo git branch -u origin/master master
	sudo git pull
   if [ -n "$LAUNCHER_GITREF" ]; then
      git checkout $LAUNCHER_GITREF
   fi
   cd -
fi

export CONFIG_TYPE="simple"
export ENABLED_PLUGINS="envtoconf launcher"
export RUNTIME_ARGUMENTS="$@"
for ENABLED_PLUGIN in $(echo $ENABLED_PLUGINS); do
   declare -x ${ENABLED_PLUGIN^^}_ENABLED=true
done
echo ""
export PLUGIN_DIR="$DIR/plugins"
source $PLUGIN_DIR/002_permissionfix/permissionfix.sh $(ls -1 $PLUGIN_DIR | sort);
