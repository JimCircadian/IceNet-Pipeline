#!/usr/bin/env bash

ENV_NAME="$1"
DIR="pipeline.$ENV_NAME"

if [ ! -d ./pipeline ] && [ ! -d ./pipeline/.git ]; then
  echo "This is a simple script, run it with a clone of icenet-pipeline in the current dir"
  exit 1
fi

mkdir -v $DIR

find pipeline/ -maxdepth 1 -type f -exec ln -s `realpath {}` $DIR/ \;

for COMMON_DIR in configurations data scripts src; do
  [ -d pipeline/$COMMON_DIR ] && ln -s `realpath pipeline/$COMMON_DIR` $DIR/$COMMON_DIR
done

# Link to the ensemble templates
mkdir $DIR/ensemble
for ENS_TMPL in predict.tmpl.yaml template train.tmpl.yaml; do
  ln -s `realpath pipeline/ensemble/$ENS_TMPL` $DIR/ensemble/
done

echo "Created environment $DIR"