#!/bin/sh
echo "Stopping web backend"
sudo svc -d /etc/service/hexabus_webbackend
echo "Stopping web frontend"
sudo svc -d /etc/service/hexabus_webfrontend
echo "Stopping midi interface"
sudo svc -d /etc/service/midi2hexabus
echo "Stopping energy flow simulator"
sudo svc -d /etc/service/simulate_energyflows
