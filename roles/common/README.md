common
=============

This role will install/configure various base components for Debian/Ubuntu systems:

- Hostname
- APT package management (package sources and preferences)
- Automatic security upgrades
- Creation of additional user accounts
- Hardened OpenSSH server, authorized SSH keys
- (Optional) chrooted, read-only SFTP-only accounts for members of the `sftponly` group
 - Use your administrative account to upload/move files to SFTP chroots, they are read-only by design
- Hardened kernel configuration (sysctl: networking/memor management/tracing)
- `remotebackup` User accepting remote SSH connections from a backup server (public key only), only allowed to run `sudo rsync --server` without password.
- (Optional) Installation of additional trusted CA certificates
  - place your certificates in a `certificates/` directory at the root of the playbook, named `*.crt`, and set `install_ca_certificates` to `yes`)
- (Optional) `msmtp` SMTP client/sendmail-compatible MTA to send system mail via an SMTP relay.



Requirements/Dependencies
------------

- This role requires Ansible 2.9 or higher.

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)


License
-------

[GPL-3.0](../LICENSE)


References
-----------------

- https://github.com/nodiscc/xsrv/tree/master/roles/common
- https://github.com/libre-logic/ansible-collection/


Troubleshooting
---------------

**Error: failed to lock apt for exclusive operation**: an APT package installation/upgrade is already running - temporary error, re-run the playbook.

**TASK [common : install firewall/network filtering tools]**: on first deployment the play can hang on this task (SSH connection devered by intial firewall startup). Stop the play with `^C`, kill the SSH process, re-run the playbook
