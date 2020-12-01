# librelogic.docker

An Ansible Role that installs [Docker](https://www.docker.com) on Linux.

## Requirements/Dependencies

- Ansible 2.9+
- [`common`](../common) role.

## Role Variables

See [`defaults/main.yml`](defaults/main.yml)


## Example Playbook

```yaml
- hosts: docker0.CHANGEME.org
  roles:
    - common
    - docker
```

## License

[MIT](https://opensource.org/licenses/MIT)


## References

- https://github.com/libre-logic/ansible-collection/
- https://github.com/nodiscc/xsrv/tree/master/roles/docker
- https://github.com/geerlingguy/ansible-role-docker
