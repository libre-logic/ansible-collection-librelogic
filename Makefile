SHELL=/bin/bash

all: tests

venv:
	python3 -m venv .venv

install_ansible: venv
	source .venv/bin/activate && \
	pip3 install wheel && \
	pip3 install ansible==2.10.3 ansible-lint==5.0.2 cryptography==3.3.2

tests: install_ansible
	ln -s common roles/librelogic.librelogic.common
	ln -s common roles/librelogic.librelogic.monitoring
	ln -s docker roles/librelogic.librelogic.docker
	ln -s docker roles/librelogic.librelogic.docker_nginx
	ln -s gitlab roles/librelogic.librelogic.gitlab
	ln -s proxmox roles/librelogic.librelogic.proxmox
	ln -s mailcatcher roles/librelogic.librelogic.mailcatcher
	ln -s apache roles/librelogic.librelogic.apache
	ln -s php_fpm roles/librelogic.librelogic.php_fpm
	ln -s adminer roles/librelogic.librelogic.adminer
	source .venv/bin/activate && \
	cp tests/playbook.yml playbook.yml && \
	ansible-playbook playbook.yml --syntax-check && \
	ansible-lint -x role-name,ignore-errors playbook.yml
	make clean

clean:
	rm -f playbook.yml
	rm -rf roles/librelogic.librelogic.common
	rm -rf roles/librelogic.librelogic.monitoring
	rm -rf roles/librelogic.librelogic.docker
	rm -rf roles/librelogic.librelogic.docker_nginx
	rm -rf roles/librelogic.librelogic.gitlab
	rm -rf roles/librelogic.librelogic.proxmox
	rm -rf roles/librelogic.librelogic.mailcatcher
	rm -rf roles/librelogic.librelogic.apache
	rm -rf roles/librelogic.librelogic.php_fpm
	rm -rf roles/librelogic.librelogic.adminer
