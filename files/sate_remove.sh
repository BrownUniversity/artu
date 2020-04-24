
# Command to remove from Satellite using password

# Have script do this and pass the PW as an arg from var
#   in the encrypted file.

curl -X DELETE -s -k -u <USER>:'<PASSWORD>!' https://psatcit.services.brown.edu/api/v2/hosts/<HOSTNAME>.services.brown.edu