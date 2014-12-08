#!/bin/bash
rsync -avz --exclude=".git*" ~/Dev/Project/hf/app/ www@192.168.10.16:/data1/www/dev_cloud/fuqiang