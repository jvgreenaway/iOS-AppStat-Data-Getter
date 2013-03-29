#!/bin/bash

REMOTEFILE='com.clezz.AppStat.plist'
LOCALDIR=~/Projects/Quantified\ Self\ Data\ Acquisition/App\ Stat\ Raw\ Data/
REMOTEDIR='/private/var/mobile/Library/Preferences/'

DATE=$(date +"%Y-%m-%d-%H-%M")
LOCALFILE='iphone-app-stat-'$DATE'.plist'

echo 'Attempting to reteive App Stat plists'


for DEVICE in james-iphone james-ipad
do
	echo 'Doing ' $DEVICE
	scp mobile@$DEVICE.local:"$REMOTEDIR$REMOTEFILE" "$LOCALDIR""$DEVICE""-app-stat-$DATE.plist"
	ssh mobile@$DEVICE.local "rm $REMOTEDIR$REMOTEFILE"
done

