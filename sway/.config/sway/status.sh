#!/bin/bash

while true; do
	# Beispiel: Systemzeit und Datum
	datetime=$(date +"%Y-%m-%d %H:%M:%S")

	# Beispiel: CPU-Temperatur
	temp=$(vcgencmd measure_temp | cut -d'=' -f2)

	# Beispiel: Freier Speicher
	mem=$(free -h | grep Speicher | awk '{print $4}')

	# Ausgabe für Swaybar
	echo "CPU Temp: $temp | Free Mem: $mem | $datetime"

	sleep 1
done
