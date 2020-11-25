# ansible-collection-librelogic

[Ansible](https://www.ansible.com/) roles for automated deployement and maintenance of Linux servers, network services and applications.

The following [roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) are available:

- [common](common/)
- [monitoring](monitoring/)
- [docker](docker/)
- [docker_nginx](docker_nginx/)
- [openldap](openldap/)

See each role's README.md for information on how to use a specific component.


### Installation

- [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 2.10 or later
- Install the collection:

```bash
ansible-collection install git+https://github.com/librelogic/ansible-collection-librelogic
```

- Include the collection in your playbook:

```bash
- hosts: all
  collections:
   - librelogic.librelogic

- hosts: example.CHANGEME.org
  roles:
   - librelogic.librelogic.common
   - librelogic.librelogic.monitoring
   - librelogic.librelogic.docker
   - librelogic.librelogic.docker_nginx
   - ...
```

See [Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.


### License

[GNU GPL v3](LICENSE) unless stated otherwise in individual files.
