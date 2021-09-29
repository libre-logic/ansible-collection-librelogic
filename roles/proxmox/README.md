# librelogic.librelogic.proxmox

This role will perform basic setup steps for a [Proxmox](https://www.proxmox.com/en/proxmox-ve) hypervisor:
- setup `pve-no-subscription` APT repositories

If the `librelogic.xsrv.common` role is enabled:
- protect the login form from brutefore using `fail2ban`
- automatic security upgrades for proxmox packages



## Requirements/eependencies/example playbook

See [meta/main.yml](meta/main.yml)

```yaml
# playbook.yml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.common # (optional) hardening/bruteforce protection/automatic security upgrades
    - librelogic.librelogic.monitoring # (optional) server monitoring and log aggregation
    - librelogic.librelogic.proxmox
```

See [defaults/main.yml](defaults/main.yml) for all configuration variables


## License

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

## References

- https://github.com/libre-logic/ansible-collection-librelogic/
- https://github.com/libre-logic/ansible-collection-librelogic/tree/master/roles/proxmox

