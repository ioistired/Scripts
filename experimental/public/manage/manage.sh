#!/bin/bash

# Shell functions

brightness() {
	echo "Current brightness: $(cat /sys/class/backlight/nv_backlight/brightness)"
	echo "Brightness range: 0 - $(cat /sys/class/backlight/nv_backlight/max_brightness)"
	echo -n "Brightness (enter to quit): "
	read INPUT
	if [ "$INPUT" ]
	then
		sudo su -c "echo '$INPUT' > /sys/class/backlight/nv_backlight/brightness"
		echo ""
		brightness
	fi
}

battery() {
	cat /sys/class/power_supply/BAT0/status
	cat /sys/class/power_supply/BAT0/capacity
	echo "Press enter to continue..."
	read
	#sleep 1s
}

# Shell main
echo "Requesting sudo privileges..."
sudo echo ""

clear

while [ true ]
do
	echo "quit (q), brightness (br), battery (bat), volume (vol), sound source (s), bluetooth headphones (bt), launch application (la), screen settings (scr)"
	read INPUT
	echo ""

	case $INPUT in
		"q")	echo "Quitting..."
			exit;;

		"br") 	brightness;;

		"bat")	battery;;

		"vol")	echo "volume";;

		"s")	echo "sound source";;

		"bt")	echo "bluetooth";;

		"la")	echo "launch app";;

		"scr")	echo "screen";;

		*)	echo "Command not found!"
			sleep 0.5s;;
	esac

	sleep 0.5s
	clear
done

exit