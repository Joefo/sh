#!/bin/bash
#set -x
PS3="Enter the host section : "
select LINE in exit $(cat $HOME/bin/mysql/servers.conf); do
    case $LINE in 
        exit)
            echo "bye!"
            break
            ;;
        *)
			CONFIG=(${LINE//:/ })
			echo "connect to: ${CONFIG[0]}"
			echo "description: ${CONFIG[6]}"
			echo "mysql -h${CONFIG[1]} -u${CONFIG[3]} -P${CONFIG[2]} -p${CONFIG[4]} ${CONFIG[5]}"
			mysql -h${CONFIG[1]} -u${CONFIG[3]} -P${CONFIG[2]} -p${CONFIG[4]} ${CONFIG[5]}
            ;;
    esac
done
