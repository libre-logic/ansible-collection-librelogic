librelogic.common

This role will configure a basic Debian-based server:

- hostname
- DNS resolution (`/etc/resolv.conf`)
- sysctl/kernel settings: networking, swap/memory management, security
- [APT package manager configuration](tasks/apt.yml)
- [date/time and NTP synchronization](tasks/datetime.yml)
- [Linux user accounts](tasks/users.yml) (user account creation/deletion, resources, PAM restrictions)
- [cron task scheduler](tasks/cron.yml) (hardening, logging)
- [SSH server](tasks/ssh.yml) (hardening, chrooted SFTP accounts)
- [firewall](tasks/firewall.yml) (`firehol`)
- [fail2ban](tasks/fail2ban.yml) intrusion/bruteforce prevention system
- [outgoing mail](tasks/mail.yml) (forwarding through an external mail relay)
- streamlining/removal of unwanted packages
- `haveged` random number generator/entropy source for virtual machines
- installation of basic command-line utilities/diagnostic tools
- installation of additional trusted CA certificates

All components can be enabled/disabled independently

In addition, this role provides a procedure to upgrade Debian 10 hosts to Debian 11. The tag `utils-debian10to11` must be passed explicitly for this procedure to run.

## Requirements/dependencies/example playbook

See [meta/main.yml](meta/main.yml)


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

See [defaults/main.yml](defaults/main.yml) for all configuration variables

## Usage

- SSH access: `ssh user@example.org`
  - Windows clients: [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
- SFTP access: `sftp://user@example.org`
  - Linux clients: [Thunar](http://docs.xfce.org/xfce/thunar/start), [Nautilus](https://wiki.gnome.org/action/show/Apps/Nautilus), [Dolphin](https://www.kde.org/applications/system/dolphin/)), `sftp`, `rsync`, `scp`,
  - Windows clients: [WinSCP](https://winscp.net/eng/index.php)
- Upgrade from Debian 10 to Debian 11: `ansible-playbook --tags utils-debian10to11 playbook.yml`


## Troubleshooting

**Error: failed to lock apt for exclusive operation**: an APT package installation/upgrade is already running - temporary error, re-run the playbook.

**TASK [common : install firewall/network filtering tools]**: on first deployment the play can hang on this task (SSH connection devered by intial firewall startup). Stop the play with `^C`, kill the SSH process, re-run the playbook

**Package installation or upgrade blocked by apt-listbugs:** read the bug report on https://bugs.debian/org/$bugnumber and decide whether it should be ignored. Then, remove `/etc/apt/preferences.d/apt-listbugs` on the host and add the bug number to `apt_listbugs_ignore_list`.

## License

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

## References

- https://github.com/nodiscc/xsrv/tree/master/roles/common
- https://github.com/libre-logic/ansible-collection/

