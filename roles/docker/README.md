# Docker

An Ansible Role that installs [Docker](https://www.docker.com) on Linux.

## Requirements

This role requires Ansible 2.9+

## Role Variables

See [`defaults/main.yml`](defaults/main.yml)

## Dependencies

The [`common`](../common) role.


## Example Playbook

```yaml
- hosts: docker.CHANGEME.org
  roles:
    - common
    - docker
```

## License

MIT / BSD

## References

- https://github.com/libre-logic/ansible-collection/
- https://github.com/geerlingguy/ansible-role-docker
- https://github.com/nodiscc/xsrv/tree/master/roles/docker
