#!/usr/bin/env bash
set -e
PASSWD_FILE=~/.vnc/vncpwd
if [ ! -f "${PASSWD_FILE}" ]; then
    echo "Setting up VNC server password under ${PASSWD_FILE}"
    PASSWD_DIR=$(dirname ${PASSWD_FILE})
    [ -d ${PASSWD_DIR} ] || mkdir -p ${PASSWD_DIR}
    x11vnc -storepasswd ${PASSWD_FILE}
fi
x11vnc -auth /run/user/121/gdm/Xauthority -forever -noxdamage --noxrecord -repeat -rfbauth ${PASSWD_FILE} -rfbport 5900 -shared -display :1

