#!/bin/sh

PARAMS=""
if [ ! -z "$JENKINS_USERNAME" ]; then
  PARAMS="$PARAMS -username $JENKINS_USERNAME"
fi
if [ ! -z "$JENKINS_PASSWORD" ]; then
  PARAMS="$PARAMS -password $JENKINS_PASSWORD"
fi
if [ ! -z "$SLAVE_EXECUTORS" ]; then
  PARAMS="$PARAMS -executors $SLAVE_EXECUTORS"
fi
if [ ! -z "$SLAVE_LABELS" ]; then
  PARAMS="$PARAMS -labels $SLAVE_LABELS"
fi
if [ ! -z "$SLAVE_NAME" ]; then
  PARAMS="$PARAMS -name $SLAVE_NAME"
fi
if [ ! -z "$JENKINS_MASTER" ]; then
  PARAMS="$PARAMS -master $JENKINS_MASTER"
else
  if [ ! -z "$JENKINS_SERVICE_PORT" ]; then
    # kubernetes environment variable
    PARAMS="$PARAMS -master http://$SERVICE_HOST:$JENKINS_SERVICE_PORT"
  fi
fi

dockerd --storage-driver vfs &

java -jar swarm-client-$JENKINS_SWARM_VERSION.jar $PARAMS -sslFingerprints "" -fsroot /workspace
