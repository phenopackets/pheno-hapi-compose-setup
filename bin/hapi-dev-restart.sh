#!/usr/bin/env bash
set -x
set -e
set -u
set -o pipefail
set -o noclobber
shopt -s nullglob

# stack overflow #59895
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

"${DIR}/hapisetup.sh" compose down
rm -rf "${DIR}/../setup/docker_container/elasticsearch"
#rm -rf "${DIR}/../setup/docker_container/hapi_build/data-volume"/*  # this doesn't delete the .m2 directory to save time.
rm -rf "${DIR}/../setup/docker_container/postgresql"

"${DIR}/hapisetup.sh" compose up --build
