#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
wget https://github.com/elek/envtoconf/releases/download/1.2.2/envtoconf_1.2.2_linux_amd64 -O $DIR/envtoconf
chmod +x $DIR/envtoconf
