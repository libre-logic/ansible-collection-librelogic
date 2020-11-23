monitoring
=============

This role will install a lightweight monitoring system on a Linux machine:
 - [Netdata](https://my-netdata.io/), a real-time, efficient, distributed performance and health monitoring system.
 - (Optional) netdata modules/graphs for [needrestart](https://gitlab.com/nodiscc/netdata-needrestart)
 - [lnav](http://lnav.org/) log viewer
 - (Optional) [lynis](https://cisofy.com/lynis/) security audit tool
 - rsyslog log retention policy

Usage
-----

### Netdata

Netdata dashboard can be reached ath **`http://host_name:19999`**. The firewall configuratino must allow incoming connections on port 19999. When there is an anormal condition on the host, an alarm will show up in the alamrs panel, and a mail will be sent using the system's Mail Tranfer Agent.

### lnav

Run `sudo lnav` on the host for an aggregated view of all machine logs. lnav supports filtering, searching and highlighting of log messages. Here are a few useful internal commands for lnav:

- `:filter-in <expression>` only display messages matching filter expression
- `:set-min-log-level debug|info|warning|error` only display messages above a defined log level.
- `:<TAB><TAB>` display internal command list
- `Ctrl+R` clear all filters/reset session
- `?` lnav help


Requirements
------------

This role requires Ansible 2.9 or higher.


Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

The [`common`](../common) role.

Example Playbook
----------------

```yaml
- hosts: my.CHANGEME.org
  become: True
  become_user: root
  roles:
    - common
    - monitoring
```


License
-------

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)


References
-----------------

- https://github.com/libre-logic/ansible-collection
- https://github.com/nodiscc/xsrv/tree/master/roles/monitoring
