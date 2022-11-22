#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SERVICES="services.csv"

GREEN="\033[1;32m"
RED="\033[0;31m"
END="\033[0m"

STATUS_TEXT=""

# command -v mo > /dev/null 2>&1 || bash -c "curl -sSL https://git.io/get-mo -o mo && chmod +x mo && sudo mv mo /usr/local/bin/"

if [ ! "$1" == "--install" ] && [ ! "$1" == "--uninstall" ] && [ ! "$1" == "--status" ] && [ ! "$1" == "--start" ] && [ ! "$1" == "--stop" ] && [ ! "$1" ==  "--restart" ]; then
    echo -e "$RED./setup.sh --install|--uninstall|--status|--start|--stop|--restart$END" && exit 1
fi

while IFS="\n" read -r SERVICE; do
    EXECUTABLE=$(echo $SERVICE | cut -f1 -d, | tr -d '[:space:]')
    if [ ! -f "$EXECUTABLE" ]; then
        command -v "$EXECUTABLE" > /dev/null 2>&1 || continue
        EXECUTABLE="$(which $EXECUTABLE)"
    fi

    SERVICE_NAME="$(echo $SERVICE | cut -f2 -d, | tr -d '[:space:]')"
    if [ -z "$SERVICE_NAME" ]; then continue; fi

    SERVICE_DESCRIPTION="$(echo $SERVICE | cut -f3 -d,)"
    EXEC_START="$(echo "$(readlink -f $EXECUTABLE) $(echo $SERVICE | cut -f4 -d,)")" #| mo

    if [ "$1" == "--install" ]; then
        echo -e "$GREEN=> Daemonlizing $EXECUTABLE...$END"
        ./daemon.sh --daemonize $EXECUTABLE "$SERVICE_NAME" "$SERVICE_DESCRIPTION" "$EXEC_START"
    elif [ "$1" == "--uninstall" ]; then
        echo -e "$GREEN=> Undaemonlizing $EXECUTABLE...$END"
        ./daemon.sh --undaemonize $EXECUTABLE "$SERVICE_NAME" "$SERVICE_DESCRIPTION" "$EXEC_START"
    elif [ "$1" == "--status" ]; then
        systemctl is-active --quiet $SERVICE_NAME

        if [ "$?" -eq 0 ]; then
            STATUS_TEXT="$STATUS_TEXT\n${GREEN}$SERVICE_NAME [+]${END}"
        else
            STATUS_TEXT="$STATUS_TEXT\n${RED}$SERVICE_NAME [-]${END}"
        fi
    elif [ "$1" == "--start" ]; then
        sudo systemctl start $SERVICE_NAME
    elif [ "$1" == "--stop" ]; then
        sudo systemctl stop $SERVICE_NAME
    elif [ "$1" == "--restart" ]; then
        sudo systemctl restart $SERVICE_NAME
    fi
done <<<"$(cat $SERVICES | sed '/^ *$/d' | sed '/^ *#/d' | sed 's/\(.*\)#.*/\1/g')"

if [ "$1" == "--status" ]; then
    DATABASES=()

    for DB in "${DATABASES[@]}"; do
        systemctl is-active --quiet $DB
        if [ "$?" -eq 0 ]; then
            STATUS_TEXT="$STATUS_TEXT\n${GREEN}$DB [+]${END}"
        else
            STATUS_TEXT="$STATUS_TEXT\n${RED}$DB [-]${END}"
        fi
    done

    echo -e $STATUS_TEXT | column -t -s' '
elif [ "$1" == "--start" ]; then
    DATABASES=()

    for DB in "${DATABASES[@]}"; do
        sudo systemctl start $DB
    done
elif [ "$1" == "--stop" ]; then
    DATABASES=()

    for DB in "${DATABASES[@]}"; do
        sudo systemctl stop $DB
    done
elif [ "$1" == "--restart" ]; then
    DATABASES=()

    for DB in "${DATABASES[@]}"; do
        sudo systemctl restart $DB
    done
fi
