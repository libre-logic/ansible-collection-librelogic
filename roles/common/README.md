librelogic.common

This role will configure a basic Debian-based server

- Hostname
- DNS resolution (`/etc/resolv.conf`)
- sysctl/kernel settings: networking, swap/memory management, security
- APT package management, automatic daily security updates
- NTP date/time synchronization, timezone
- SSH server configuration/hardening
  - `sftponly` group: chrooted, SFTP-only accounts
- firewall (`firehol`)
- intrusion/bruteforce detention and prevention system (`fail2ban`)
- user accounts, resources, PAM restrictions
- outgoing mail (through a SMTP relay)
- streamlining/removal of unwanted packages
- installation of basic command-line utilities/diagnostic tools
- installation of additional trusted CA certificates

All components can be enabled/disabled independently

## Requirements/Dependencies/example playbook

See [`meta/main.yml`](meta/main.yml)

```yaml
# playbook.yml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.common

# required variables:
# ansible-vault edit host_vars/my.example.org/my.example.org.vault.yml
ansible_user: "CHANGEME"
ansible_become_pass: "CHANGEME"

# if setup_msmtp: yes
setup_msmtp: yes
msmtp_smtp_host: "smtp.CHANGEME.org"
msmtp_smtp_user: "CHANGEME"
msmtp_smtp_password: "CHANGEME"
msmtp_admin_email: "CHANGEME@CHANGEME.org"
```

See [`defaults/main.yml`](defaults/main.yml) for all configuration variables.

## License

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

## References

- https://github.com/nodiscc/xsrv/tree/master/roles/common
- https://github.com/libre-logic/ansible-collection/


## Usage

- Upgrade from Debian 10 to Debian 11: `ansible-playbook --verbose --tags utils-debian10to11 playbook.yml && ansible-playbook playbook.yml`


## Troubleshooting

**Error: failed to lock apt for exclusive operation**: an APT package installation/upgrade is already running - temporary error, re-run the playbook.

**TASK [common : install firewall/network filtering tools]**: on first deployment the play can hang on this task (SSH connection devered by intial firewall startup). Stop the play with `^C`, kill the SSH process, re-run the playbook

**Package installation or upgrade blocked by apt-listbugs:** read the bug report on https://bugs.debian/org/$bugnumber and decide whether it should be ignored. Then, remove `/etc/apt/preferences.d/apt-listbugs` on the host and add the bug number to `apt_listbugs_ignore_list`.
