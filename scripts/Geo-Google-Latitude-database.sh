#!/bin/sh
################################################################################
#                                                                              #
#  This cron test to insure the daemon has not failed due to                   #
#  remote web and database connections.                                        #
#                                                                              #
################################################################################
BASENAME=`basename $0 .sh`
DIRNAME=`dirname $0`
PROGRAM="$DIRNAME/$BASENAME.pl"
PARAMETERS=""
if [ -r $PROGRAM ]
then
  PIDFILE="/var/run/$BASENAME.pid"
  if [ -r $PIDFILE ]
  then
    PID=`cat $PIDFILE`
    PS=`ps -p $PID -o pid=`
    if [ -z "$PS" ]
    then
      echo "Process not found restarting"
      perl $PROGRAM $PARAMETERS &
#   else
#     echo "We are running as expected"
    fi
  else
    echo "PID file was not readable"
    #Restart
    perl $PROGRAM $PARAMETERS &
  fi
else
  echo "Program: $PROGRAM is not executable"
fi
