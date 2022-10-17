#/bin/bash

set -eu

if `grep -q '$MYETH0IP $MYWLAN0IP' ~/.bashrc`; then
    echo "already updated"
else
    echo '' >> ~/.bashrc
    echo 'export MYWLAN0IP=$(ifconfig wlan0 2>/dev/null | grep -o -E "([0-9]+\.){3}[0-9]+" | head -n1)' >> ~/.bashrc
    echo 'export MYETH0IP=$(ifconfig eth0 2>/dev/null | grep -o -E "([0-9]+\.){3}[0-9]+" | head -n1)' >> ~/.bashrc
    echo 'export ROS_IP=$(echo $MYETH0IP $MYWLAN0IP 127.0.0.1 | cut -d'\'' '\'' -f1)' >> ~/.bashrc
    echo 'export ROS_MASTER_URI=http://$ROS_IP:11311' >> ~/.bashrc
    echo "updated"
fi
