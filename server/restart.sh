#!/bin/bash
echo "restarting nginx..."
sudo kill -1 $(cat /usr/local/var/run/nginx.pid)
echo "nginx done"
