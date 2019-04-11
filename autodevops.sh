#!/bin/bash

function checkrc() {
  RC=$1
  MSG="$2"
  if [ ${RC} -ne 0 ]; then
    echo "Error ${RC}: [${MSG}]"
    exit ${RC}
  fi
}

echo "#-----------------------"
STEP="kubectl check configuration"
echo ${STEP}
RET=$(kubectl auth can-i '*' '*')
checkrc $? ${STEP}

if [[ "${RET}" -ne "yes" ]]; then
  echo "Error ${STEP}"
  exit 1
fi

echo "#-----------------------"
STEP="kubectl Api Url"
echo ${STEP}
APIURL=$(kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}')
checkrc $? ${STEP}
echo "API URL => ${APIURL}"


NAMESPACE=gitlab-managed-apps
echo "#-----------------------"
STEP="kubectl apply account"
echo ${STEP}
kubectl create namespace ${NAMESPACE} || true
kubectl apply -f gitlab-sa.yaml
checkrc $? ${STEP}

echo "#-----------------------"
STEP="Get Secret"
echo ${STEP}
SECRET=$(kubectl -n ${NAMESPACE} get secret | grep ^gitlab-sa | awk '{print $1}')
checkrc $? ${STEP}
echo "Secret => ${SECRET}"

echo "#-----------------------"
STEP="Get CA Certificate"
echo ${STEP}
kubectl -n ${NAMESPACE} get secret $SECRET -o jsonpath="{['data']['ca\.crt']}" | base64 --decode

echo "#-----------------------"
STEP="Get Token from Secret"
TOKEN=$(kubectl -n ${NAMESPACE} describe secret ${SECRET} | grep '^token')
checkrc $? ${STEP}
echo "Token => ${TOKEN}"

echo "#-----------------------"
STEP="Fix clusterrolebinding permissive-binding"
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
checkrc $? ${STEP}

exit 0
