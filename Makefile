# Variables
YML=test_templates.yaml

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

# Tests

#check.artu: @ run artu with check
check.artu: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml -i ${YML} --check

#artu: @ run it all
artu: pass.yaml
	ANSIBLE_ROLES_PATH=../ ansible-playbook deploy_it.yaml -i ${YML}
# Cleanup from tests
