common
=============

This role will install/configure a basic Debian-based server. 

- hostname
- DNS resolution (`/etc/resolv.conf`)
- sysctl/kernel settings: networking, swap/memory management, security
- APT package management, automatic daily security updates
- NTP date/time synchronization
- SSH server configuration/hardening
- firewall (`firehol`)
- Intrusion/bruteforce detention and prevention system (`fail2ban`)
- user accounts, resources, PAM restrictions
- `sftponly` group: chrooted, SFTP-only accounts
- outgoing mail (through a SMTP relay)
- basic command-line utilities/diagnostic tools
- streamlining/Removal of unwanted packages
- `haveged` random number generator/entropy source for virtual machines
- (Optional) Installation of additional trusted CA certificates

All components can be enabled/disabled independently

Requirements/Dependencies
------------

- Ansible 2.8 or higher
- Basic Debian GNU/Linux 9/10 netinstall on host
- Ansible inventory hostname resolves to the host FQDN (using DNS, /etc/hosts...)
- SSH server reachable from the controller
- User account on the host, member of the `sudo` group, for which you know the password
- Controller SSH key authorized on this user account (`ssh-copy-id user@host`)


Configuration variables
-----------------------

See [defaults/main.yml](defaults/main.yml)


Example playbook
-----------------

```yaml
- hosts: my.example.org
  roles:
     - common

# ansible-vault edit host_vars/my.example.org/my.example.org.vault.yml
vault_msmtp_host: "smtp.CHANGEME.org"
vault_msmtp_username: "CHANGEME"
vault_msmtp_password: "CHANGEME"
vault_msmtp_admin_email: "CHANGEME@CHANGEME.org"
```

License
-------

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

References
-----------------

- https://github.com/nodiscc/xsrv/tree/master/roles/common
- https://github.com/libre-logic/ansible-collection/


Troubleshooting
---------------

**Error: failed to lock apt for exclusive operation**: an APT package installation/upgrade is already running - temporary error, re-run the playbook.

**TASK [common : install firewall/network filtering tools]**: on first deployment the play can hang on this task (SSH connection devered by intial firewall startup). Stop the play with `^C`, kill the SSH process, re-run the playbook

**Package installation or upgrade blocked by apt-listbugs:** read the bug report on https://bugs.debian/org/$bugnumber and decide whether it should be ignored. Then, remove `/etc/apt/preferences.d/apt-listbugs` on the host and add the bug number to `apt_listbugs_ignore_list`.
