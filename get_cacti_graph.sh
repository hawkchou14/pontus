#!/bin/sh

############################################################################################
# This script let you get the URL associated to any interface graph                        #
# You should:                                                                              #
#    + Change the HOST vble with the IP address of the cacti server (mysql database)       #
#    + Change the DATABASE vlbe with the name of the database in mysql                     #
#    + Change the DATABASE_USER vble with the username of the cacti database               #
#    + Change the DATABASE_PASS vble with the password of the cacti database in your mysql #
############################################################################################

MYSQL="/usr/bin/mysql"
AWK="/usr/bin/awk"
   # In the next lines, you should change to the proper values according your server config
HOST="127.0.0.1" 
DATABASE="cacti"
DATABASE_USER="cacti"
DATABASE_PASS="cacti"


HOST_ID=`$MYSQL -u $DATABASE_USER -p$DATABASE_PASS $DATABASE -sN -e "select id from host where hostname='$1';"`
IFACE_INDEX=`$MYSQL -u $DATABASE_USER -p$DATABASE_PASS $DATABASE -sN -e "select snmp_index from host_snmp_cache where field_name='ifName' and field_value='$2' and host_id='$HOST_ID';"`
GRAPH_ID=`$MYSQL -u $DATABASE_USER -p$DATABASE_PASS $DATABASE -sN -e "select id from graph_local where host_id='$HOST_ID' and snmp_index='$IFACE_INDEX';"`

echo -e "Host Name=$1|Host ID=$HOST_ID|IFace Index=$IFACE_INDEX|Graph ID=$GRAPH_ID\n"

echo -e "URL = http://$HOST/cacti/graph.php?local_graph_id=$GRAPH_ID"

