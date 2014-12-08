#!/bin/bash
PS3="please select the service to start: "

select SERVICE in exit nginx memcache mysql redis reabbitmq php-fpm; do
    case $SERVICE in
        nginx)
            pgrep -q nginx 
            [[ $? -eq 0 ]] && { echo "nginx is already running, reload instead. "; sudo nginx -s reload; continue; }
            sudo nginx
            echo 'start nginx service'
            ;;
        mysql)
            pgrep -q mysqld 
            [[ $? -eq 0 ]] && { echo "mysqld is already running."; continue; }
            mysqld >/dev/null 2>&1 &
            echo 'start mysql service'
            ;;
        php-fpm)
            echo 'kill running php-fpm'
            $HOME/dev/bin/tool/kill.sh php-fpm 1 > /dev/null
            sudo /usr/local/sbin/php-fpm --fpm-config /usr/local/etc/php-fpm.conf -D
            echo 'start php-fpm service'
            ;;
        memcache)
            pgrep -q memcached 
            [[ $? -eq 0 ]] && { echo 'memcached is already running.'; continue; }
            memcached -d
            echo 'start memcached service'
            ;;
        redis)
            pgrep -q redis-server 
            [[ $? -eq 0 ]] && { echo 'redis-server is already running.'; continue; }
            redis-server >/dev/null &
            echo 'start redis-server service'
            ;;
        exit)
            break
            ;;
        *)
            echo 'invalid service name'
            continue
            ;;
    esac
done
