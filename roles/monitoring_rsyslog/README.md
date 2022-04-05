# librelogic.monitoring_rsyslog

This rolle will setup [rsyslog](https://en.wikipedia.org/wiki/Rsyslog) basic log aggregation, logrotate retention, and log forwarding over TCP/SSL/TLS, and [lnav](http://lnav.org/) log file viewer.
 
[![](https://screenshots.debian.net/shrine/screenshot/10371/simage/large-24897d7d91b1b5fc33cca4accd70781b.png)](https://screenshots.debian.net/package/lnav)


## Requirements/dependencies/example playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.common # (optional) basic setup, hardening, firewall
    - librelogic.librelogic.monitoring_rsyslog
    # - librelogic.librelogic.monitoring # (optional) full monitoring suite including monitoring_rsyslog
```

See [defaults/main.yml](defaults/main.yml) for all configuration variables


## License

[GNU GPLv3](../../LICENSE)


## References

- https://github.com/nodiscc/xsrv/tree/master/roles/monitoring_rsyslog

