#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Cleanup resources
function cleanup {
  set +e
  docker compose down
  cd ..
  rm -rf output
  set -e
}
trap cleanup EXIT

function waitAlfrescoReady {
  echo "Starting Alfresco ..."
  bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8080/alfresco/s/api/server)" != "200" ]]; do sleep 5; done'
  echo "Alfresco started successfully!"
}

cd ..

go run main.go init -t alfresco \
-p Version=7.4 \
-p Database=postgres \
-p Messaging=No \
-p LegacyUI=Yes \
-p Volumes=None \
-p Server=localhost \
-p Addons=None

cd output

docker compose up --detach --quiet-pull

waitAlfrescoReady

cleanup