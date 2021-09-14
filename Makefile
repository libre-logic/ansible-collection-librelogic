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
	ln -s docker roles/librelogic.librelogic.docker
	ln -s gitlab roles/librelogic.librelogic.gitlab
	source .venv/bin/activate && \
	cp tests/playbook.yml playbook.yml && \
	ansible-playbook playbook.yml --syntax-check && \
	ansible-lint -x role-name playbook.yml
	make clean

clean:
	-rm playbook.yml
	-rm -r roles/librelogic.librelogic.common
	-rm -r roles/librelogic.librelogic.docker
	-rm -r roles/librelogic.librelogic.gitlab
