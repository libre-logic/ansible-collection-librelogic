SHELL=/bin/bash

all: tests

venv:
	python3 -m venv .venv

install_ansible: venv
	source .venv/bin/activate && \
	pip3 install wheel && \
	pip3 install ansible==4.6.0 ansible-lint==5.4.0 cryptography==3.3.2 cffi==1.14.6

tests: install_ansible
	ln -s common roles/librelogic.librelogic.common
	ln -s monitoring roles/librelogic.librelogic.monitoring
	ln -s monitoring_rsyslog roles/librelogic.librelogic.monitoring_rsyslog
	ln -s monitoring_netdata roles/librelogic.librelogic.monitoring_netdata
	ln -s monitoring_utils roles/librelogic.librelogic.monitoring_utils
	ln -s docker roles/librelogic.librelogic.docker
	ln -s docker_nginx roles/librelogic.librelogic.docker_nginx
	ln -s gitlab roles/librelogic.librelogic.gitlab
	ln -s proxmox roles/librelogic.librelogic.proxmox
	ln -s mailcatcher roles/librelogic.librelogic.mailcatcher
	ln -s apache roles/librelogic.librelogic.apache
	ln -s php_fpm roles/librelogic.librelogic.php_fpm
	ln -s adminer roles/librelogic.librelogic.adminer
	ln -s gitlab_runner roles/librelogic.librelogic.gitlab_runner
	ln -s handlers roles/librelogic.librelogic.handlers
	source .venv/bin/activate && \
	cp tests/playbook.yml playbook.yml && \
	cp tests/inventory.yml inventory.yml && \
	cp -r tests/host_vars host_vars && \
	ansible-playbook playbook.yml --syntax-check && \
	ansible-lint -x role-name,ignore-errors,no-tabs playbook.yml && \
	ansible-playbook -i inventory.yml --check playbook.yml --tags="checks"
	make clean

clean:
	rm -f playbook.yml
	rm -f inventory.yml
	rm -rf host_vars
	rm -rf roles/librelogic.librelogic.common
	rm -rf roles/librelogic.librelogic.monitoring
	rm -rf roles/librelogic.librelogic.monitoring_rsyslog
	rm -rf roles/librelogic.librelogic.monitoring_netdata
	rm -rf roles/librelogic.librelogic.monitoring_utils
	rm -rf roles/librelogic.librelogic.docker
	rm -rf roles/librelogic.librelogic.docker_nginx
	rm -rf roles/librelogic.librelogic.gitlab
	rm -rf roles/librelogic.librelogic.proxmox
	rm -rf roles/librelogic.librelogic.mailcatcher
	rm -rf roles/librelogic.librelogic.apache
	rm -rf roles/librelogic.librelogic.php_fpm
	rm -rf roles/librelogic.librelogic.adminer
	rm -rf roles/librelogic.librelogic.gitlab_runner
	rm -rf roles/librelogic.librelogic.handlers
