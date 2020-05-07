# artu - Automated RHEL Template Updates
For the regular updates of RHEL OS VM tempates to ensure security compliance and
reduce patching when deploying VMs and services.  

## Getting Started
To run on RHEL systems without blackbox set the AUTOMATED env.  
```export AUTOMATED=true```  

This is meant to be deployed with a couple commands, so that it can just be run and removed as needed.  

Clone repo [git@github.com:BrownUniversity/artu.git](git@github.com:BrownUniversity/artu.git) and then run ```make artu```.  

### Software used
GnuMake  
Ansible  
PowerShell  
Bash  
Satellite   

### Prerequisites
* Existing working template in Vcenter  
* System account on server that will run the code  

### Installing
Clone repo [git@github.com:BrownUniversity/artu.git](git@github.com:BrownUniversity/artu.git)

Once pulled down, run ```make install``` to set the crontabs
The crontabs will:  
1. Run the ARTU updater 1st Wednesday of the month
2. Pull any git code changes every Wednesday

## Deployment
Run make commands as needed. To see available commands, run ```make help```.

## Authors
Thomas DuVally <tduvally@brown.edu>  

## License
None  

## Acknowledgments

## Development
This is an internal project for Brown University, CIS-VO group. Access to this code is restricted.  
Code can be obtained at [BrownUniversity/artu](https://github.com/BrownUniversity/artu)  

## Sources
https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html  
