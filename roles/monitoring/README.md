monitoring
=============

This role will install a lightweight monitoring system on a Linux machine:
 - [Netdata](https://my-netdata.io/), a real-time, efficient, distributed performance and health monitoring system.
 - (optional) netdata modules/graphs for [needrestart](https://gitlab.com/nodiscc/netdata-needrestart)
 - (optional) [lnav](http://lnav.org/) log viewer, [logwatch](https://packages.debian.org/sid/logwatch) log analyzer, [debsums](https://packages.debian.org/sid/debsums) integrity verification tool
 - (optional) [lynis](https://cisofy.com/lynis/) security audit tool
 - rsyslog log retention policy


Requirements/Dependencies/Example playbook
------------

Ansible 2.9 or higher

```yaml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.common # required
    - librelogic.librelogic.monitoring
```


Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)


Usage
-----

### netdata

Access the netdata dashboard at **`http://$inventory_hostname:19999`**. Firewall configuration must allow incoming connections on port 19999. When there is an anormal condition on the host, an alarm will show up in the alamrs panel, and a mail will be sent using the system's Mail Tranfer Agent.

### lnav

Run `sudo lnav` on the host for an aggregated view of all machine logs. lnav supports filtering, searching and highlighting of log messages. Here are a few useful internal commands for lnav:

- `:filter-in <expression>` only display messages matching filter expression
- `:set-min-log-level debug|info|warning|error` only display messages above a defined log level.
- `:<TAB><TAB>` display internal command list
- `Ctrl+R` clear all filters/reset session
- `?` lnav help




License
-------

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)


References
-----------------

- https://github.com/libre-logic/ansible-collection
- https://github.com/nodiscc/xsrv/tree/master/roles/monitoring
