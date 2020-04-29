#!/usr/bin/bash
# Command to remove from Satellite using password

$1=HOSTNAME
$2=USER
$3=PASSWORD

/usr/bin/curl -X DELETE -s -k -u $USER:'$PASSWORD' https://psatcit.services.brown.edu/api/v2/hosts/$HOSTNAME.services.brown.edu