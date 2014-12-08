#!/bin/bash
REMOTE_SERVER=tuan@tc-lbs-16g-map00.tc.baidu.com
LOCAL_ONLY=${1:=0}
[[ ! -e build.sh ]] && exit 2;
[[ ! -x build.sh ]] && chmod +x build.sh
./build.sh
cd output
tar xvzf *.tar.gz -C $HOME/dev/odp/
[[ $LOCAL_ONLY -eq 1 ]] && exit 0;

scp *.tar.gz $REMOTE_SERVER:fuqiang/src/source.tar.gz
ssh $REMOTE_SERVER "cd /home/tuan/fuqiang/src; tar xvzf source.tar.gz -C /home/tuan/odp/"
