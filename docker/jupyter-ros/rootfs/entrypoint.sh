#!/bin/sh

. /opt/ros/noetic/setup.sh

if which "$1" > /dev/null 2>&1 ; then
	$EXEC "$@"
else
	echo $@ | $EXEC $SHELL -li
fi
