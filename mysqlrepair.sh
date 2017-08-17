#!/bin/bash

##########################################################################
# 																		 #
# Repair Tables MySQL                                                    #
#                                                                        #
##########################################################################

DBUSER="admin"
DBPASS=`cat /etc/psa/.psa.shadow`
MYSQLBIN="/usr/bin/mysql"
TABLES="articoli,  documenti, pagamento"
REPAIRCMD="REPAIR TABLE $TABLES";
DATABASENAME="helpdesk";

#
# Load config file if exists
#
CONFIG_DIR=$( dirname "$(readlink -f "$0")" )
CONFIG_FILE="$CONFIG_DIR/mysqlrepair.config"

if [[ -f $CONFIG_FILE ]]; then
   echo "Loading settings from $CONFIG_FILE."
   source $CONFIG_FILE
else
   echo "Could not load settings from $CONFIG_FILE (file does not exist), script use default settings."
fi


_now=$(date +%Y-%m-%d.%H.%M.%S)
echo "start at ${_now}"

echo "Setting command ..."
if [ -z $DBPASS ] && [ -z $DBUSER ]; then
        MYSQLCOMMAND="$MYSQLBIN $DATABASENAME";
elif [ -z $DBPASS ] && [ ! -z $DBUSER ]; then
        MYSQLCOMMAND="$MYSQLBIN -u$DBUSER $DATABASENAME";
else
        MYSQLCOMMAND="$MYSQLBIN -u$DBUSER -p$DBPASS $DATABASENAME";
fi

echo $REPAIRCMD
RESULT=`echo "$REPAIRCMD" |$MYSQLCOMMAND`
echo " "
echo $RESULT
echo " "

_lap1=$(date +%Y-%m-%d.%H.%M.%S)
echo "finish at ${_lap1}"
