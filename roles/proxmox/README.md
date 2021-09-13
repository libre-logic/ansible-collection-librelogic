# librelogic.librelogic.proxmox

This role will configure Proxmox hypervisors:

- automatic security and bugfix upgrades


## Requirements/Dependencies

- Ansible 2.10 or higher
- Proxmox VE >=5 on target host

## Configuration variables

See [defaults/main.yml](defaults/main.yml)


## Example playbook

```yaml
- hosts: my.CHANGEME.org
  roles:
     - librelogic.librelogic.common
     - librelogic.librelogic.proxmox
```

## License

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

## References

- https://github.com/libre-logic/ansible-collection-librelogic/

