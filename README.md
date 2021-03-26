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
ansible-collection install git+https://github.com/libre-logic/ansible-collection-librelogic
```

- Include roles from the collection in your playbook:

```bash
- hosts: example.CHANGEME.org
  roles:
   - librelogic.librelogic.common
   - librelogic.librelogic.monitoring
   - librelogic.librelogic.docker
   - librelogic.librelogic.docker_nginx
   - ...
```

See [Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.


### Contributing

- Please report suggestions or problems you may encounter in [issues](https://github.com/libre-logic/ansible-collection-librelogic/issues)
- Please send patches via [pull request](https://github.com/libre-logic/ansible-collection-librelogic/pulls)


### License

[GNU GPL v3](LICENSE) unless stated otherwise in individual files.
