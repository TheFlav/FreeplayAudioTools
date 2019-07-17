#!/usr/bin/env bash

INSTALL_DIR=/home/pi/Freeplay/$( ls /home/pi/Freeplay | grep -i freeplayaudiotools )

audio_mono ()
{
	sudo cp $INSTALL_DIR/asound.conf /etc/asound.conf
	sudo reboot
}

audio_stereo ()
{
	sudo rm /etc/asound.conf
	sudo reboot
}

hdmi_on ()
{
	sudo sed -i 's/^hdmi_drive=1/hdmi_drive=2/g' /boot/config.txt
}

hdmi_off ()
{
		sudo sed -i 's/^hdmi_drive=2/hdmi_drive=1/g' /boot/config.txt
}

INPUT=/tmp/menu.sh.$$

dialog --clear --title "Freeplay Audio Tools" \
	--menu "Choose a tool to use:" 15 50 5 \
	Mono_Audio "Switch to mono audio" \
	Stereo_Audio "Switch to stereo audio" \
	HDMI_Audio_On "Enable HDMI audio" \
	HDMI_Audio_Off "Disable HDMI audio" \
	Exit "Exit without any changes" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

case "$menuitem" in
	Mono_Audio) audio_mono;;
	Stereo_Audio) audio_stereo;;
	HDMI_Audio_On) hdmi_on;;
	HDMI_Audio_Off) hdmi_off;;
	Exit) echo "No changes made"; break;;
esac

[ -f "$INPUT" ] && rm "$INPUT"
