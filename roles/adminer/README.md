# librelogic.librelogic.adminer

This role will install and configure [adminer](https://www.adminer.org/)

> Adminer (formerly phpMinAdmin) is a full-featured database management tool written in PHP. Conversely to phpMyAdmin, it consist of a single file ready to deploy to the target server. Adminer is available for MySQL, MariaDB, PostgreSQL, SQLite, MS SQL, Oracle, Elasticsearch, MongoDB and others via plugin.


## Requirements/Dependencies/Example playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: my.CHANGEME.org
  roles:
     - librelogic.librelogic.common # optional
     - librelogic.librelogic.apache
     - librelogic.librelogic.php_fpm
     - librelogic.librelogic.adminer

# host_vars/my.CHANGEME.org/my.CHANGEME.org.yml
adminer_fqdn: adminer.CHANGEME.org

# ansible-vault edit host_vars/my.CHANGEME.org/my.CHANGEME.org.vault.yml
adminer_user: "CHANGEME"
adminer_password: "CHANGEME"
```

## License

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

## References

- https://github.com/libre-logic/ansible-collection-librelogic/
