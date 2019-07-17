#!/usr/bin/env bash

INSTALL_DIR=/home/pi/Freeplay/$( ls /home/pi/Freeplay | grep -i freeplayaudiotools )

mkdir -p "/home/pi/RetroPie/retropiemenu/Freeplay Options"
cp $INSTALL_DIR/FreeplayAudioTools.sh "/home/pi/RetroPie/retropiemenu/Freeplay Options/FreeplayAudioTools.sh"

if grep -q "Freeplay Audio Tools" /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml ; then
	echo "Audio Tools Menu Item Already Added"
else
	sudo sed -i 's|</gameList>|\t<game>\n\t\t<path>./Freeplay Options/FreeplayAudioTools.sh</path>\n\t\t<name>Freeplay Audio Tools</name>\n\t\t<desc>Tools to toggle between mono/stereo audio and enable HDMI audio</desc>\n\t\t<image>./icons/audiosettings.png</image>\n\t\t<playcount>0</playcount>\n\t\t<lastplayed>20180514T205700</lastplayed>\n\t</game>\n</gameList>|' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
fi

exit 0
