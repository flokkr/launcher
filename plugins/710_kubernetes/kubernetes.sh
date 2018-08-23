#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


if [ "$KUBERNETES_CONFIGMAP" ]; then
  plugin-is-active "KUBERNETES"
  echo "Launch with kubernetes launcher. $KUBERNETES_CONFIGMAP_NAMESPACE/$KUBERNETES_CONFIGMAP"
  $DIR/kubernetes-launcher --destination $CONF_DIR --namespace ${KUBERNETES_CONFIGMAP_NAMESPACE:-default} --fields metadata.name=$KUBERNETES_CONFIGMAP $RUNTIME_ARGUMENTS
else
   call-next-plugin "$@"
fi
