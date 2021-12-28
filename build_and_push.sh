#!/usr/bin/env bash

set -eux # European Union - Extended mode

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

(
  gcloud auth login &
  AUTH_PID=${!}

  docker build --network host -t "eu.gcr.io/orwell-270813/gitea:latest" "."

  while kill -0 "${AUTH_PID}" 2> /dev/null; do echo "Waiting For Auth"; sleep 5; done;

  docker push "eu.gcr.io/orwell-270813/gitea:latest"
)
