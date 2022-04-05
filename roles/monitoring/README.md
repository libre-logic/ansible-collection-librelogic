# librelogic.monitoring

This role will install a monitoring, alerting and logging system on a Linux machine. It is an alias for the following roles:
 - [librelogic.librelogic.monitoring_rsyslog](../monitoring_rsyslog)
 - [librelogic.librelogic.monitoring_netdata](../monitoring_netdata)
 - [librelogic.librelogic.monitoring_utils](../monitoring_utils)

## Requirements/dependencies/example playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.common # (optional) basic setup, hardening, firewall
    - librelogic.librelogic.monitoring
    # or enable only specific roles:
    # - librelogic.librelogic.monitoring_rsyslog
    # - librelogic.librelogic.monitoring_netdata
    # - librelogic.librelogic.monitoring_lynis
```

## License

[GNU GPLv3](../../LICENSE)


## References

- https://github.com/nodiscc/xsrv/tree/master/roles/monitoring
