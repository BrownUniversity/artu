#!/bin/bash
WEEK=$1
THISWEEK=`echo $((($(date +%-d)-1)/7+1))`
DATE=`date +%F`
# Set help fonts
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

help() {
# Help info
        echo "Basic usage: ${BOLD}$0 -w <week num 1-5> -c <Command to run>${NORM}"
        echo -e "This script is meant to be used with cron to run a command on"
        echo -e "on the specified week on the month. "
        echo -e ""
        echo -e "\t${BOLD}-w${NORM}: Week number 1-5"
        echo -e "\t${BOLD}-c${NORM}: Command to be run by the cron, use quotes"
        echo -e ""
        echo ""
}
while getopts ":w:c:h" OPT; do
  case "$OPT" in
    w)  WEEK=$OPTARG
        ;;
    c)  CMD=$OPTARG
        ;;
    h)
        help
        exit 0
        ;;
    \?)
        echo "Option -$OPTARG not allowed"
        help
        exit 1
        ;;
    *)	help
        exit 1
  esac
done
shift $(($OPTIND - 1))
remaining_args="$@"


if [ ${WEEK} == ${THISWEEK} ]; then
        shift
        ${CMD} $remaining_args
else
        echo "Wrong week"
        exit 1
fi
