# librelogic.docker

An Ansible Role that installs [Docker](https://www.docker.com) on Linux.

## Requirements/Dependencies/example playbook

See [`meta/main.yml`](meta/main.yml)

```yaml
# playbook.yml
- hosts: my.CHANGEME.org
  roles:
    - nodiscc.xsrv.common # (optional) basic setup, hardening, firewall
    - nodiscc.xsrv.monitoring # (optional) system/container monitoring and health checks
    - librelogic.librelogic.docker

# required variables:
# none
```

See [`defaults/main.yml`](defaults/main.yml) for all configuration variables.

## License

[MIT](https://opensource.org/licenses/MIT)


## References

- https://github.com/libre-logic/ansible-collection/
- https://github.com/nodiscc/xsrv/tree/master/roles/docker
- https://github.com/geerlingguy/ansible-role-docker
