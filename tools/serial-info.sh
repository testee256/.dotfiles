#!/bin/bash

udevadm info -a $1 | grep -i '{bInterfaceNumber}\|{serial}\|{idVendor}\|{idProduct}'

