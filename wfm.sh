#!/bin/bash

WFM_CLI_DIR=$(dirname $(readlink -f $0))
WFM_DIR="$WFM_CLI_DIR/.."

MODULES_DIR="$WFM_DIR/modules"

# symlink all wfm modules:
# grep fh-wfm package.json | cut -d':' -f1 | tr -d ' "' | sed 's/fh-//' | xargs -I {} npm link ../modules/{}

pullApps () {
  APPS="wfm2-cloud wfm2-auth wfm2-mobile wfm2-portal"
  for D in $APPS; do
    cd "$WFM_DIR/$D"
    echo #########
    echo `pwd`
    git pull
  done
}

pullModules () {
  ls "$MODULES_DIR/"
  for D in $MODULES_DIR/*; do
    cd $D
    echo #########
    echo `pwd`
    git pull
  done
}

case $1 in
  pull)
  pullApps
  pullModules
  ;;
  *)
  echo "Usage: wfm pull"
esac
