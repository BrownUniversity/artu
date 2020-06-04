#!/usr/bin/env bash
# Shell script to run update
KEY="Standard_QA"
YUMOPTS=""
YUMBIN=/usr/bin/yum
YUMARGS="-y -e 0"

# Subscribe to Satellite updates (PROD)
sat_reg() {
# RHN Register
  rpm --import http://unixrepo.services.brown.edu/217521F6.txt
  rpm -Uvh https://psatcit.services.brown.edu/pub/katello-ca-consumer-latest.noarch.rpm
  subscription-manager clean
  subscription-manager register --org BrownCIS --activationkey "$KEY"
  yum -y -d 0 -e 0 install katello-agent
}

# Run updates
yum_update() {
  $YUMBIN $YUMARGS $YUMOPTS --exclude=open-vm-tools update
}

clean_katello {
$YUMBIN $YUMARGS $YUMOPTS remove katello-ca-consumer'*'
}


sat_reg
yum_update
clean_katello