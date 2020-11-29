#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXECUTABLE="$2"
SERVICE_NAME="$3"
SERVICE_FILE="$SERVICE_NAME.service"
SERVICE_DESCRIPTION="$4"
DAEMON_PATH="/etc/systemd/system"
USER="$(whoami)"
EXEC_START="$5"
WORK_DIR="${6:-$DIR}"

function validate-process {
    [[ -f $EXECUTABLE ]] && [[ -x $EXECUTABLE ]] || command -v $EXECUTABLE > /dev/null 2>&1 || exit 1
}

function kill-process {
    PIDS=( $(pgrep -f /$EXECUTABLE) )
    for PID in "${PIDS[@]}"; do
        # Avoid killing bash script && the main process of executable
        if [[ $PID != $$ ]] && [ `ps -aux | grep $EXECUTABLE | awk '{print $2}' | grep -c $PID` -gt 0 ]; then
            kill "$PID"
            echo "[$EXECUTABLE] killed"
            sleep 1s
        fi
    done
}

function undaemonize-service {
    sudo systemctl stop $SERVICE_NAME
    sudo systemctl disable $SERVICE_NAME
    if [ -f "/etc/systemd/system/multi-user.target.wants/$SERVICE_NAME.service" ]; then
        sudo rm "/etc/systemd/system/multi-user.target.wants/$SERVICE_NAME.service"
    fi
    if [ -f "/etc/systemd/system/$SERVICE_NAME.service" ]; then
        sudo rm "/etc/systemd/system/$SERVICE_NAME.service"
    fi
    if [ -f $SERVICE_FILE ]; then
        rm $SERVICE_FILE
    fi
    sudo systemctl daemon-reload
    sudo systemctl reset-failed
    echo "[$SERVICE_NAME] undaemonized"
}

function daemonize-service {
    if [ -f $SERVICE_FILE ]; then
        rm $SERVICE_FILE
    fi
    touch $SERVICE_FILE
    printf "[Unit]\nDescription=$SERVICE_DESCRIPTION\nRequires=network.target\nAfter=multi-user.target graphical.target network.target syslog.target\nWants=network.target\n\n[Service]\nUser=$USER\nRestart=always\nRestartSec=5\nWorkingDirectory=$WORK_DIR\nExecStart=$EXEC_START\n\n[Install]\nWantedBy=multi-user.target\n" > $SERVICE_FILE

    # Deamonize
    echo -e "Daemonizing"
    sudo cp ./$SERVICE_FILE ${DAEMON_PATH}/
    sudo chmod 755 ${DAEMON_PATH}/$SERVICE_FILE
    sudo chown root:root ${DAEMON_PATH}/$SERVICE_FILE
    sudo systemctl link ${DAEMON_PATH}/$SERVICE_FILE

    echo -e "Run dameon"
    # Run deamon right now
    sudo systemctl enable $SERVICE_NAME
    sudo systemctl daemon-reload
    sudo systemctl start $SERVICE_NAME
    sudo systemctl reenable $SERVICE_NAME
}

# Catch parameters
if [ $1 == '--daemonize' ]; then

    validate-process

    kill-process

    daemonize-service

elif [ $1 == '--undaemonize' ]; then

    validate-process

    kill-process

    undaemonize-service
fi
