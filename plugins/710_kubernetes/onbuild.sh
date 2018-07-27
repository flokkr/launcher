#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
wget http://kv.anzix.net//kubernetes-launcher_linux_amd64 -O $DIR/kubernetes-launcher
chmod +x $DIR/kubernetes-launcher
