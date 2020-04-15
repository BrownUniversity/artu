# Variables


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
#test.deploy: @ test deploying templates
test.deploy: pass.yaml
	ansible-playbook ./tasks/deploy.yaml -i templates.yaml

#test.transfer: @ test update file transfer
test.transfer: pass.yaml
	ansible-playbook ./tasks/transfer.yaml -i templates.yaml

#test.update: @ test update command and script
test.update: pass.yaml
	ansible-playbook ./tasks/update.yaml -i templates.yaml

#test.cleaninstall: @ test clean the install
test.cleaninstall: pass.yaml
	ansible-playbook ./tasks/cleaninstall.yaml -i templates.yaml

#test.shutdown: @ test the shutdown
test.shutdown: pass.yaml
	ansible-playbook ./tasks/shutdown.yaml -i templates.yaml

#test.getuuidnewvm: @ test new VM UUID
test.getuuidnewvm: pass.yaml
	ansible-playbook ./tasks/getuuidnewvm.yaml -i templates.yaml

#test.getuuidoldtemplate: @ test old template UUID
test.getuuidoldtemplate: pass.yaml
	ansible-playbook ./tasks/getuuidoldtemplate.yaml -i templates.yaml

#test.renameold: @ test old template rename
test.renameold: pass.yaml
	ansible-playbook ./tasks/renameold.yaml -i templates.yaml

#test.renamelatest: @ test new VM rename
test.renamelatest: pass.yaml
	ansible-playbook ./tasks/renamelatest.yaml -i templates.yaml

#test.updatenotes: @ test updating notes
test.updatenotes: pass.yaml
	ansible-playbook ./tasks/updatenotes.yaml -i templates.yaml

#test.convert: @ test converting new to template
test.convert: pass.yaml
	ansible-playbook ./tasks/convert.yaml -i templates.yaml


# Cleanup from tests
