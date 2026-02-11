SHELL=/bin/bash

all: tests

venv:
	python3 -m venv .venv

install_ansible: venv
	source .venv/bin/activate && \
	pip3 install wheel && \
	pip3 install ansible==7.7.0 ansible-lint cryptography cffi

prepare: install_ansible clean
# 	ln -s common roles/librelogic.librelogic.common
# 	ln -s monitoring roles/librelogic.librelogic.monitoring
# 	ln -s monitoring_rsyslog roles/librelogic.librelogic.monitoring_rsyslog
# 	ln -s monitoring_netdata roles/librelogic.librelogic.monitoring_netdata
# 	ln -s monitoring_utils roles/librelogic.librelogic.monitoring_utils
	ln -s docker roles/librelogic.librelogic.docker
	ln -s docker_nginx roles/librelogic.librelogic.docker_nginx
	ln -s gitlab roles/librelogic.librelogic.gitlab
	ln -s proxmox roles/librelogic.librelogic.proxmox
	ln -s mailcatcher roles/librelogic.librelogic.mailcatcher
# 	ln -s apache roles/librelogic.librelogic.apache
	ln -s adminer roles/librelogic.librelogic.adminer
	ln -s gitlab_runner roles/librelogic.librelogic.gitlab_runner
	ln -s handlers roles/librelogic.librelogic.handlers
	cp tests/playbook.yml playbook.yml && \
	cp tests/inventory.yml inventory.yml && \
	cp -r tests/host_vars host_vars

tests: install_ansible prepare
	source .venv/bin/activate && \
	ansible-playbook playbook.yml -i ./inventory.yml --syntax-check && \
	ansible-lint -x role-name,ignore-errors,no-tabs playbook.yml && \
	ansible-playbook -i ./inventory.yml --check playbook.yml --tags="checks"
	make clean

fix_lint: prepare
	source .venv/bin/activate && \
	ansible-lint playbook.yml --fix
	make clean

clean:
	rm -f playbook.yml
	rm -f inventory.yml
	rm -rf host_vars
# 	rm -rf roles/librelogic.librelogic.common
# 	rm -rf roles/librelogic.librelogic.monitoring
# 	rm -rf roles/librelogic.librelogic.monitoring_rsyslog
# 	rm -rf roles/librelogic.librelogic.monitoring_netdata
# 	rm -rf roles/librelogic.librelogic.monitoring_utils
	rm -rf roles/librelogic.librelogic.docker
	rm -rf roles/librelogic.librelogic.docker_nginx
	rm -rf roles/librelogic.librelogic.gitlab
	rm -rf roles/librelogic.librelogic.proxmox
	rm -rf roles/librelogic.librelogic.mailcatcher
# 	rm -rf roles/librelogic.librelogic.apache
	rm -rf roles/librelogic.librelogic.adminer
	rm -rf roles/librelogic.librelogic.gitlab_runner
	rm -rf roles/librelogic.librelogic.handlers

#######################
##### MAINTENANCE #####

.PHONY update_roles: # MAJ des rôles depuis https://github.com/libre-logic/ansible-collection-librelogic
update_roles: install_ansible
	source .venv/bin/activate && \
	ansible-galaxy collection install --force -r requirements.yml
