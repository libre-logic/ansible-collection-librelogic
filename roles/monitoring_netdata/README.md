# librelogic.monitoring_netdata

This role will install and configure [Netdata](https://my-netdata.io/), a real-time, efficient, distributed performance and health monitoring system, and optional netdata modules/graphs:
 - [needrestart](https://gitlab.com/nodiscc/netdata-needrestart)
 - [logcount](https://gitlab.com/nodiscc/netdata-logcount)
 - [debsecan](https://gitlab.com/nodiscc/netdata-debsecan)

[![](https://i.imgur.com/vqfWelH.png)](https://i.imgur.com/vqfWelH.png)


## Requirements/dependencies/example playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.common # (optional) basic setup, hardening, firewall
    - librelogic.librelogic.monitoring_netdata
    # - librelogic.librelogic.monitoring # (optional) full monitoring suite including monitoring_netdata
```

See [defaults/main.yml](defaults/main.yml) for all configuration variables


## Usage

- Netdata dashboard access: https://my.CHANGEME.org:19999 (or https://IP_ADDRESS:19999)
- When there is an abnormal condition on the host, an alarm will be raised in the alarms panel of the dashboard, and a mail will be sent to the server admin e-mail address, using the system's Mail Transfer Agent (see the [common](../common) role and `msmtp*` variables)

[netdata documentation](https://docs.netdata.cloud/)


### Integration with other roles/manual configuration

To install custom `httpcheck`/`x509check`/`portcheck`/`processes` module/alarm, create relevant files in `/etc/netadata/{go,python,health}.d/$module_name.conf.d/` and notify the `assemble netadata configuration` [handler](https://gitlab.com/librelogic/librelogic/-/blob/master/roles/monitoring/handlers/main.yml) (`$module_name.conf` will be assembled from configuration fragments).

## License

[GNU GPLv3](../../LICENSE)


## References

- https://github.com/nodiscc/xsrv/tree/master/roles/monitoring_netdata
