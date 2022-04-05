# ansible-collection-librelogic

[Ansible](https://www.ansible.com/) roles for automated deployement and maintenance of Linux servers, network services and applications.

The following [roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) are available:

- [common](roles/common/) - configure a basic Debian-based server
- [monitoring](roles/monitoring/) - lightweight monitoring system
- [docker](roles/docker/) - Docker container platform
- [gitlab](roles/gitlab/) - software forge and DevOps platform
- [gitlab_runner](roles/gitlab_runner/) - Continuous INtegration runner for Gitlab
- [openldap](roles/openldap/) - LDAP directory server and web management interface
- [mailcatcher](roles/mailcatcher) - Simple SMTP server/mail interceptor and web interface
- [apache](roles/apache) - Apache Web server/reverse proxy
- [php_fpm](roles/php_fpm) - PHP interpreter / FastCGI interface
- [adminer](roles/adminer) - Database management in a single PHP file
- _DEPRECATED_ [docker_nginx](roles/docker_nginx/) - (deprecated) web server and reverse proxy for Docker Swarm services


See each role's `README.md` for information on how to use a specific component.


### Installation

- [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 2.12 or later
- Install the collection:

```bash
ansible-galaxy collection install git+https://github.com/libre-logic/ansible-collection-librelogic,master
```

- Include roles from the collection in your playbook:

```yaml
- hosts: my.CHANGEME.org
  roles:
   - librelogic.librelogic.common
   - librelogic.librelogic.monitoring
   - librelogic.librelogic.docker
   - librelogic.librelogic.gitlab
   - ...
```

See [Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.


### Upgrading

Reinstall the collection:

```bash
ansible-galaxy collection install --force git+https://github.com/libre-logic/ansible-collection-librelogic,master
```

Currently, only upgrading to the latest revision of the the `master` branch is supported. In the future, stable/tagged releases may be added.



### Contributing

- Please report suggestions or problems you may encounter in [issues](https://github.com/libre-logic/ansible-collection-librelogic/issues)
- Please send patches via [pull request](https://github.com/libre-logic/ansible-collection-librelogic/pulls)


### License

[GNU GPL v3](LICENSE) unless stated otherwise in individual files.
