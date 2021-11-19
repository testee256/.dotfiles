#!/usr/bin/env bash
set -e
set -o pipefail

>&2 echo "Please unplug the USB cable and press any key to continue ..."
read -n 1
serial-list.sh -v > /tmp/_serial_list1.txt
>&2 echo "Please plug the USB cable and press any key to continue ..."
read -n 1
serial-list.sh -v > /tmp/_serial_list2.txt
diff --new-line-format="%L" --old-line-format="" --unchanged-line-format="" /tmp/_serial_list1.txt /tmp/_serial_list2.txt

