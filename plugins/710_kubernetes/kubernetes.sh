#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


if [ "$KUBERNETES_CONFIGMAP" ]; then
  plugin-is-active "KUBERNETES"
  echo "Launch with kubernetes launcher."
  $DIR/kubernetes-launcher $RUNTIME_ARGUMENTS
else
   call-next-plugin "$@"
fi
