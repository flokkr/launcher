#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for INSTALLER in $(env | grep INSTALLER_); do
		  ID=$(id -u -n)
		  KEY=$(echo $INSTALLER | awk -F '=' '{print $1}')
		  COMPONENT=$(echo $KEY | awk -F '_' '{print tolower($2)}')
		  URL=$(echo $INSTALLER | awk -F '=' '{print $2}')
		  sudo rm -rf /opt/$COMPONENT
		  sudo rm -rf /opt/unpack
		  sudo mkdir -p /opt/unpack
		  sudo mkdir -p /opt/download
		  sudo chown $ID /opt/unpack
		  sudo chown $ID /opt/download
		  DESTFILE=/opt/download/$COMPONENT.tar.gz
		  if [ ! -f "$DESTFILE" ]; then
		     wget $URL -O $DESTFILE
	          fi
		  tar xzf $DESTFILE -C /opt/unpack
                  sudo mv /opt/unpack/* /opt/$COMPONENT
                  sudo chown $ID /opt/$COMPONENT
                  rm -rf /opt/unpack
done


call-next-plugin "$@"
