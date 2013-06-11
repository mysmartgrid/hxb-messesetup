#!/bin/sh
echo "Starting web backend"
sudo svc -u /etc/service/hexabus_webbackend
echo "Starting web frontend"
sudo svc -u /etc/service/hexabus_webfrontend
echo "Starting midi interface"
sudo svc -u /etc/service/midi2hexabus
echo "Starting energy flow simulator"
sudo svc -u /etc/service/simulate_energyflows
