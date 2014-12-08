#/bin/bash
FORCE=${2:=0}
PSR=$(ps -e | grep "$1" | grep -v 'grep ' | awk '{print $1}')
[[ -z $PSR ]] && { echo 'not found'; exit 1; } || { ps -e | grep "$1" | grep -v 'grep '; }

if [[ $FORCE -ne 1 ]]; then
    read -p 'are u sure to kill these all? yes|no:' CHOICE 
    [[ $CHOICE = 'no' ]] && { exit 1; }
fi

sudo kill -9 $PSR
