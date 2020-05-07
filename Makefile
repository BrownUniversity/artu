# Variables
YML=templates.yaml
TAGS=NONE
ANSOPT= 
ANSCFG = ANSIBLE_CONFIG=ansible/ansible.cfg

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

.PHONY : all clean chmod artu

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
	chmod 755 files/runonweek.sh

# Targets
#install: @ setup cronjob
install: 
		${ANSCFG}  ansible-playbook ansible/artu-cron.yml

#artu.deploy: @ run deploy
artu.deploy: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags deploy

#artu.transfer: @ run transfer
artu.transfer: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags transfer

#artu.update: @ run update
artu.update: pass.yaml chmod.script
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags update

#artu.cleaninstall: @ run cleaninstall
artu.cleaninstall: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags cleaninstall

#artu.shutdown: @ run shutdown
artu.shutdown: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags shutdown


#artu.notes: @ run notes
artu.notes: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags "notes"

#artu.rename: @ run rename
artu.rename: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags rename

#artu.renamelatest: @ run renamelatest
artu.renamelatest: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags renamelatest

#artu.renameold: @ run renameold
artu.renameold: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags renameold

#Checks
#check.artu: @ run artu with check and TAG
check.artu: pass.yaml
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags ${TAGS} --check

#clean: @ clean all
clean: clean.shred

#clean.shred: @ Shred decrypted files
.PHONY: clean.shred
clean.shred: 
	SECRET_FILES=$(shell cat .blackbox/blackbox-files.txt)
	ifdef AUTOMATED
		rm -f $(SECRET_FILES)
	else
		blackbox_shred_all_files
	endif

#artu: @ run artu
artu: pass.yaml chmod.script
	${ANSCFG} ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML}

#all: @ run artu, then clean
all: artu clean