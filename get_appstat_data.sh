#!/bin/bash

# Config
REMOTEFILE="com.clezz.AppStat.plist"
LOCALDIR="~/Projects/Quantified\ Self\ Data\ Acquisition/App\ Stat\ Raw\ Data/"
REMOTEDIR="/private/var/mobile/Library/Preferences/"

# Local Vars
data_string=$(date +"%Y-%m-%d-%H-%M")
devices_complete=()
device_online=false



echo 'Retrieving AppStat files...'


# Loop though my device names

for DEVICE in james-iphone james-ipad
do
	echo 
	echo "Working on '"$DEVICE"':"

	# Ping test 
	# Technique from http://ubuntuforums.org/showthread.php?t=851997&s=72c1785c7e70be1572c0ed090fc3880f&p=5336096#post5336096
	ping -c 1 "$DEVICE".local &> /dev/null

	if [ "$?" -eq 0 ]; 
	then
		# We're good to go!
		echo "Online!"

		# Grab file and remove
		echo "Grabbing..."
		scp mobile@$DEVICE.local:"$REMOTEDIR$REMOTEFILE" "$LOCALDIR""$DEVICE""-app-stat-$data_string.plist"
		
		echo "Deleting..."
		ssh mobile@$DEVICE.local "rm $REMOTEDIR$REMOTEFILE"

		# Append to complete array
		devices_complete+=($DEVICE)
		echo "Complete!"

	else
		# Unreachable error
		echo "Unreachable :("

	fi

done

echo

# Print out results from opperation

if [[ ${#devices_complete[@]} -gt 0 ]]; then
	echo 'Successfully complete: '

	for device in $devices_complete
	do
		echo $device
	done

else
	echo 'No devices complete.'
fi







