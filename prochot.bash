#!/bin/bash

/sbin/modprobe msr

# Read register containing prochot bit. Usually the last bit defines if it's enabled or not
REGISTER=`/usr/sbin/rdmsr -d 0x1FC`

# If the bit it's 0, prochot is disabled, else it change the bit to 0 to disable
if [ $(($REGISTER % 2)) -eq 1 ];
then
        NEWREGISTER=$(($REGISTER - 1))
        sudo /usr/sbin/wrmsr -a 0x1FC $NEWREGISTER
else
        echo "Already fixed"
fi
