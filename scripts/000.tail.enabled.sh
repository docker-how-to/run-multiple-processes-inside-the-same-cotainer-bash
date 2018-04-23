#!/usr/bin/env bash

BINARY="tail"
PARAMS="-f $LOG_FILE"

######################################################

CMD=$1

if [[ -z "${CONFIG_LOG_TARGET}" ]]; then
  LOG_FILE="runner.log"
else
  LOG_FILE="${CONFIG_LOG_TARGET}"
fi

case $CMD in

describe)
    echo "Sleep $PARAMS"
    ;;

is-running)
    if pgrep -f "$BINARY $PARAMS" >/dev/null 2>&1 ; then
        exit 1
    fi
    exit 0
    ;;

start)
    touch $LOG_FILE
    echo "Starting... $BINARY $PARAMS"
    echo "$BINARY $PARAMS"
    $BINARY $PARAMS &
    ;;

start-fail)
    echo "Start failed! $BINARY $PARAMS"
    ;;

stop)
    if pgrep -f "$BINARY $PARAMS" >/dev/null 2>&1 ; then
        echo "Stopping... $BINARY $PARAMS"
        kill -9 $(pgrep -f "$BINARY $PARAMS")
    else
        echo "Already stopped... $BINARY $PARAMS"
    fi
    ;;

esac
