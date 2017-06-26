# ChangeMAC
This is a script designed to "Change Wifi interface MAC address on macOS >= 10.10"

Be sure to check [github for the original](https://github.com/securitygeneration/scripts/blob/master/changeMAC.sh) but as of 10/13/16, the code is as follows: 

---

	#!/bin/bash
	# Change Wifi interface MAC address on macOS >= 10.10
	# Because there are times you want to change your wifi interface's MAC address ;)
	# By Sebastien Jeanquier (@securitygen)
	# Security Generation - http://www.securitygeneration.com
	#
	# -------------------------------------------------------------
	
	function usage {
		echo "Description: Set supplied or randomised Airport (Wifi) MAC address on en0."
		echo "Usage: sudo $0 [-r] {MAC address}"
		echo " 	Optional -r: Sets randomised MAC address"
		echo "	Otherwise sets supplied MAC address."
		echo "	MAC address is reset to default upon reboot."
		echo "	Must be run as root."
	}
	
	if [[ $# -eq 0 ]] || [ "$1" == "-h" ];
	then
		usage "$0";
		exit
	elif [[ $EUID -ne 0 ]]; then
		echo "[Error] Must be run as root."
		exit
	else
	
		# Read flags
		rflag=false
			while getopts r opt
			do
			    case "$opt" in
			      r)  rflag=true;;
			      \?)		# unknown flag
					usage "$0"; exit;;
			    esac
			done
			shift "$((OPTIND-1))"
	
		# Get new MAC address
		if [[ $rflag == true ]]; then
			# Generate random MAC
			newMAC=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/./0/2; s/.$//')
			randomised=" (random)"
		else
			# Check and use supplied MAC address
			newMAC=$1
		fi
	
		# Check resulting MAC address is valid
		re="^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$"
		if ! [[ $newMAC =~ $re ]] ; then
	   		echo "Error: new MAC address must be in format 00:aa:11:bb:22:cc (case insensitive), you entered: $newMAC" >&2; exit 1
			exit 1
		fi
	
		# Confirmation
		read -p "Are you sure you want to set your MAC address to: $newMAC$randomised? (y/N): " selection
		if [[ "$selection" != "y" ]]; then
			echo "Bailing out!"
			exit 0
		fi
	
		# Set new MAC address
		# 1) Disable airport interface
		sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
		# 2) Change MAC addess on en0
		sudo ifconfig en0 ether "$newMAC"
		# 3) Re-enable airport interface
		networksetup -detectnewhardware
	
		echo "[Done] Set $newMAC on en0."
	
	fi