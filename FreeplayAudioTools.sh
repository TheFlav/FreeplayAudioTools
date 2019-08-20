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


CMD=(dialog --clear --title "Freeplay Audio Tools" --menu "Choose a tool to use:" 15 50 5)

OPTIONS=(Mono_Audio "Switch to mono audio" \
	Stereo_Audio "Switch to stereo audio" \
	HDMI_Audio_On "Enable HDMI audio" \
	HDMI_Audio_Off "Disable HDMI audio" \
	Exit "Exit without any changes")


while true; do
	CHOICES=$("${CMD[@]}" "${OPTIONS[@]}" 2>&1 >/dev/tty)

#If cancelled, drop the dialog
if [ $? -ne 0  ]; then
	clear;
	exit;
fi;

for CHOICE in $CHOICES; do
	case $CHOICE in
		Mono_Audio) 
			dialog --title "Mono Audio" --yesno "This will mix the left and right audio channels so both can be heard on the speaker, but will also make the headphone output mono. Would you like to enable mono mixing?" 5 60
			RESP=$?
			case $RESP in
				0) dialog --title "Mono Audio" --infobox "Enabling Mono Audio. System will shut down and settings will be applied on next boot." 5 60; audio_mono;;
				1) dialog --title "Mono Audio" --infobox "NOT Enabling Mono Audio" 5 60;;
				255) dialog --title "Mono Audio" --infobox "Returning to main menu" 5 60;;
			esac
			;;
		Stereo_Audio)
			dialog --title "Stereo Audio" --yesno "This will separate the left and right audio channels, so the speaker will only play the right channel and headphones will have true stereo. Would you like to enable stereo audio?" 5 60
			RESP=$?
			case $RESP in
				0) dialog --title "Stereo Audio" --infobox "Turning Stereo Audio On. System will shut down and settings will be applied on next boot." 5 60;audio_stereo;;
				1) dialog --title "Stereo Audio" --infobox "NOT Turning Stereo Audio" 5 60;;
				255) dialog --title "Stereo Audio" --infobox "Returning to main menu" 5 60;;
			esac
			;;
		HDMI_Audio_On)
			dialog --title "HDMI Audio On" --yesno "This will turn HDMI audio on, which may break compatibility with some displays. Would you like to enable HDMI audio?" 5 60
			RESP=$?
			case $RESP in
				0) dialog --title "HDMI Audio On" --infobox "Turning HDMI Audio On. System will shut down and settings will be applied on next boot." 5 60;hdmi_on;;
				1) dialog --title "HDMI Audio On" --infobox "NOT Turning HDMI Audio On" 5 60;;
				255) dialog --title "HDMI Audio On" --infobox "Returning to main menu" 5 60;;
			esac
			;;
		HDMI_Audio_Off)
			dialog --title "HDMI Audio Off" --yesno "This will turn HDMI audio off, which has better comaptibility with most displays. Would you like to disable HDMI audio?" 5 60
			RESP=$?
			case $RESP in
				0) dialog --title "HDMI Audio Off" --infobox "Turning HDMI Audio Off. System will shut down and settings will be applied on next boot." 5 60;hdmi_off;;
				1) dialog --title "HDMI Audio Off" --infobox "NOT Turning HDMI Audio Off" 5 60;;
				255) dialog --title "HDMI Audio Off" --infobox "Returning to main menu" 5 60;;
			esac
			;;
		Exit)
			exit
			;;
	esac
done
done
