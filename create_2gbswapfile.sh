#!/bin/bash
set -eu
sudo dd if=/dev/zero of=/var/swapfile bs=1M count=2048
sudo mkswap /var/swapfile
sudo chmod 600 /var/swapfile
sudo swapon /var/swapfile
sudo cat /proc/swaps
echo "/var/swapfile  swap        swap    defaults        0   0" | sudo tee -a /etc/fstab
