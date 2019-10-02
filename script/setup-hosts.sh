#!/bin/bash

cat >> /etc/hosts <<EOF
192.168.33.11  master-1
192.168.33.12  master-2
192.168.33.12  master-3
192.168.33.21  worker-1
192.168.33.22  worker-2
192.168.33.23  worker-2
192.168.33.30  loadbalancer
EOF
