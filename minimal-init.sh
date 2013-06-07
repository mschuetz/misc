#!/bin/bash -e

SCRIPT=...
PIDFILE=..
USER=www-data
GROUP=www-data
RETVAL=0
case "$1" in
        start)
                echo "Starting $SCRIPT"
                su $USER -c $SCRIPT
                RETVAL=$?
  ;;
        stop)
                echo "Stopping $SCRIPT"
                kill $(< $PIDFILE)
                RETVAL=$?
  ;;
        restart)
                echo "Restarting $SCRIPT"
                kill $(< $PIDFILE)
                su $USER -c $SCRIPT
                RETVAL=$?
  ;;
        *)
                echo "Usage: $0 {start|stop|restart}"
                exit 1
  ;;
esac
exit $RETVAL
