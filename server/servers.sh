#!/bin/bash
PS3="Enter the host section : "
select host in exit $(cat $HOME/bin/server/servers.conf); do
    case $host in 
        exit)
            echo "bye!"
            break
            ;;
        *)
            SERVER=$(cut -d: -f1<<<$host)
            TAG=$(cut -d: -f2<<<$host)
            echo "ssh $host"
            ssh $SERVER
            ;;
    esac
done
