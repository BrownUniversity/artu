# Variables
YML=templates.yaml
TAGS=NONE
ANSOPT= ANSIBLE_CONFIG=ansible.cfg

# Help system
.DEFAULT_GOAL := help

#help:  @ List available tasks on this project
help:
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(MAKEFILE_LIST)| tr -d '#'  | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#var.list: @ list vars
var.list: 
	@echo YML: template file to run. Default: ${YML}
	@echo TAGS: Tags to run for artu.check target. Default: ${TAGS}
	@echo ANSOPT: Options to ansible, like verbose. Default: ${ANSOPT}

# Collected targets
#secrets : @ Files to decrypt
SECRET_FILES=$(shell cat .blackbox/blackbox-files.txt)
$(SECRET_FILES): %: %.gpg
ifdef AUTOMATED
	gpg --decrypt --quiet --no-tty --yes $< > $@
else
	blackbox_decrypt_all_files
endif

#chmod.script: @ ensure scripts have execute perm
chmod.script:
	chmod 755 files/sat_remove.sh

# Targets

#artu.deploy: @ run deploy
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags deploy

#artu.transfer: @ run transfer
artu.transfer: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags transfer

#artu.update: @ run update
artu.update: pass.yaml chmod.script
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags update

#artu.cleaninstall: @ run cleaninstall
artu.cleaninstall: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags cleaninstall

#artu.shutdown: @ run shutdown
artu.shutdown: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags shutdown


#artu.notes: @ run notes
artu.notes: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags "notes"

#artu.rename: @ run rename
artu.rename: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags rename

#artu.renamelatest: @ run renamelatest
artu.renamelatest: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags renamelatest

#artu.renameold: @ run renameold
artu.renameold: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags renameold

#Checks
#check.artu: @ run artu with check and TAG
check.artu: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML} --tags ${TAGS} --check

#artu: @ run it all
artu: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook ${ANSOPT} deploy_it.yaml -i ${YML}
# Cleanup from tests
