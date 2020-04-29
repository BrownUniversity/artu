#!/usr/bin/bash
# Command to remove from Satellite using password

HOSTNAME=$1
USER=$2
PASSWORD=$3

/usr/bin/curl -X DELETE -s -k -u $USER:$PASSWORD https://psatcit.services.brown.edu/api/v2/hosts/$HOSTNAME.services.brown.edu