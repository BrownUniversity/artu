# Variables
YML=test_templates.yaml
TAGS=NONE
ANSOPT=

# Help system
.DEFAULT_GOAL := help

#help:  @ List available tasks on this project
help:
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(MAKEFILE_LIST)| tr -d '#'  | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Collected targets
#secrets : @ Files to decrypt
SECRET_FILES=$(shell cat .blackbox/blackbox-files.txt)
$(SECRET_FILES): %: %.gpg
ifdef AUTOMATED
	gpg --decrypt --quiet --no-tty --yes $< > $@
else
	blackbox_decrypt_all_files
endif

# Targets

#artu.deploy: @ run deploy
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags deploy

#artu.transfer: @ run transfer
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags transfer

#artu.update: @ run update
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags update

#artu.cleaninstall: @ run cleaninstall
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags cleaninstall

#artu.shutdown: @ run shutdown
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags shutdown

#artu.uuid: @ run uuid
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags uuid

#artu.newuuid: @ run newuuid
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags newuuid

#artu.olduuid: @ run olduuid
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags olduuid

#artu.rename: @ run rename
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags rename

#artu.renamelatest: @ run renamelatest
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags renamelatest

#artu.renameold: @ run renameold
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags renameold

#artu.notes: @ run notes
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags notes

#artu.convert: @ run convert
artu.deploy: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags convert

#Checks
#check.artu: @ run artu with check and TAG
check.artu: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML} --tags ${TAG} --check

#artu: @ run it all
artu: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml ${ANSOPT} -i ${YML}
# Cleanup from tests
