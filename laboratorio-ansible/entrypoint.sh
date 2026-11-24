#!/bin/bash
set -e

# Necesario para control: el volumen con nombre puede montarse como root:root
chown ubuntu:ubuntu /home/ubuntu
chmod 755 /home/ubuntu

service ssh start
service cron start

exec sleep infinity