#!/bin/bash
# the following is from https://unix.stackexchange.com/questions/144029/command-to-determine-ports-of-a-device-like-dev-ttyusb0

for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
    (
        syspath="${sysdevpath%/dev}"
        devname="$(udevadm info -q name -p $syspath)"
        [[ "$devname" == "bus/"* ]] && exit
        [[ ! "$devname" == *"ttyUSB"* ]] && exit
        UDEVADM_OUTPUT=$(udevadm info -q property --export -p $syspath)
        eval "${UDEVADM_OUTPUT}"
        [[ -z "$ID_SERIAL" ]] && exit
        if [ "$1" = "-v" ]; then
            echo "${UDEVADM_OUTPUT}"
        else
            echo "/dev/$devname - $ID_SERIAL"
        fi
    )
done

