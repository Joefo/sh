#!/bin/bash
echo "用于绑卡流程用户数据清理"
echo "usage:$0 mobile <port>[3307] <password>[devadmin1]"
PHONE=${1?'input mobile'}
MYSQL_USER=devadmin
MYSQL_HOST=192.168.10.33
MYSQL_PORT=${2:-3306}
MYSQL_PASSWORD=${3:-devadmin}
SQL_QUERY="select iUserID from hfb_db.t_hfb_user where sCellPhone=$PHONE order by iAutoID desc limit 1"
RES=$(mysql -u$MYSQL_USER -h$MYSQL_HOST -P$MYSQL_PORT -p$MYSQL_PASSWORD -e "$SQL_QUERY")
USERID=$(cut -d" " -f2 <<<$RES)
[[ -z $USERID  ]] && { echo 'user not found'; exit 1; }
echo iUserID:$USERID

DELETE_USER="delete from hfb_db.t_hfb_user where iUserID=$USERID limit 1"
echo $DELETE_USER
mysql -u$MYSQL_USER -h$MYSQL_HOST -P$MYSQL_PORT -p$MYSQL_PASSWORD -e "$DELETE_USER"

DELETE_CARD="delete from hfb_db.t_hfb_bankcard where iUserID=$USERID limit 1"
echo $DELETE_CARD
mysql -u$MYSQL_USER -h$MYSQL_HOST -P$MYSQL_PORT -p$MYSQL_PASSWORD -e "$DELETE_CARD"

echo 'done'
