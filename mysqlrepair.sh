#!/bin/bash
##########################################################################
# Repair Tables MySQL                                                    #
#                                                                        #
##########################################################################

DBUSER="admin"
DBPASS=`cat /etc/psa/.psa.shadow`
MYSQLBIN="/usr/bin/mysql"
TABLES="articoli,  documenti, pagamento"
REPAIRCMD="REPAIR TABLE $TABLES";
DATABASENAME="helpdesk";
###############################################################################


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
