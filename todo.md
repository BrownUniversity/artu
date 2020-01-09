# Ansible
* role vs playbooks?
* location
  * Puppet server?
  * CI/CD server? 
  * Other?
* Tasks
  * deploy template
  * run update script via vmware-tools
  * wait for shutdown
  * convert VM to template
  * delete host on Satellite via API or Hammer?

# Vmware
* credentials?
* template naming?
* provisional template names?

# Satellite
* delete registration after update

# Bash
* must handle RHEL 6,7,8
* Error logging?
  * Export logs or leave in template?
* update script
  * register with Satellite
  * update OS
  * cleanup script
  * shutdown

# other?
* IP/Hostnames for running updates