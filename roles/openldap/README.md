# xsrv.openldap

This role will install and configure [OpenLDAP](https://en.wikipedia.org/wiki/OpenLDAP), a [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol) directory server, and optionally the [LDAP Account Manager](https://ldap-account-manager.org/) web management interface

[![](https://screenshots.debian.net/screenshots/000/006/946/thumb.png)](https://screenshots.debian.net/package/ldap-account-manager)
[![](https://screenshots.debian.net/screenshots/000/016/087/thumb.png)](https://screenshots.debian.net/package/ldap-account-manager)


## Requirements/dependencies

- Ansible 2.9 or higher.
- [common](../common) role
- [apache](../apache) role (if `openldap_setup_lam` is enabled)
- [backup](../backup) role (optional, automatic backups)


## Role Variables

See [defaults/main.yml](defaults/main.yml)


## License

[GNU GPLv3](../../LICENSE)


## References

- https://stdout.root.sx/links/?searchtags=doc+ldap
- https://stdout.root.sx/links/?searchtags=doc+idmanagement


## Usage

- **CN**: Common Name (non-unique identifier for an entry, relative to the container it is in - eg `jane.doe`)
- **DN**: Distinguished Name (unique identifier, full path from root of the LDAP tree to the object - eg. `cn=jane.doe,ou=Users,dc=CHANGEME,dc=org`)
- **DC**: Domain Component (component of a distinguished name - eg. `jane.doe,` `CHANGEME`, `org`...)
- **Base DN** or **Search base**: the top of your domain hierarchy, eg. `dc=CHANGEME,dc=org`
- **Users DN** container for the whole users hierarchy - eg. `ou=Users,dc=CHANGEME,dc=org`
- **OU**: [Organizational Unit](https://ldapwiki.com/wiki/OrganizationalUnit) (arbitrary subtree/subdirectory in LDAP hierarchy), for organizational/separation purposes - **not** permissions management purposes)
- **Group:** a list ([posixGroup](https://ldapwiki.com/wiki/PosixGroup)) of user DNs with a specific role/access level, for permissions management purposes - **not** organizational purposes. eg. `access_fileshare_XYZ`, `access_application_XYZ`, `access_instant_messaging`...)

**Admin user:** The admin/root user DN is `cn=admin,dc=CHANGEME,dc=org`. This account should only be used for LDAP administration. It is stored outside the Users DN, and not visible in LDAP Account Manager main users view. This user is managed by ansible.

**Bind user:** The `cn=bind,ou=system,dc=CHANGEME,dc=org` user is managed by ansible, it is stored outside the Users DN, and not visible in LDAP Account Manager main users view. It is an unprivilegied account, allowed to enumerate the LDAP directory - use this account to configure applications/services that make use of LDAP authentication (so that they can search the LDAP tree for valud user accounts).

**Backups:** see the included [rsnapshot configuration](templates/etc_rsnasphot.d_openldap.conf.j2) and [openldap dump script](templates/usr_local_bin_openldap-dump.sh.j2). If your backup user is a non-root account it should be allowed to run `slapcat` as root without password, for example using the [common](../common) role:

```yaml
linux_users:
  - name: remotebackup
    sudo_nopasswd_commands: ["/usr/sbin/slapcat"]
```

Alternatively, to dump contents of the OpenLDAP database, use `sudo slapcat` from the host itself, or `sudo ldapsearch -w $openldap_server_bind_password -H ldap://ldap.CHANGEME.org -D "cn=bind,ou=system,dc=CHANGEME,dc=org"` from a remote host.

**Restoring backups:**

```bash
# Purge target LDAP database
ssh -t ldap.CHANGEME.org sudo apt purge slapd
# reinstall openLDAP
ansible-playbook playbook.yml --limit ldap.CHANGEME.org --tags openldap
# upload LDAP backups to the target host
rsync -avP $local_backups_path/daily.0/var/backups/rsnapshot/daily.0/ldap.CHANGEME.org/var/backups/openldap/slapd-backup.ldif ldap.CHANGEME.org:
# restore ldap backup from LDIF file
ssh -t ldap.CHANGEME.org sudo slapadd -c -l slapd-backup.ldif
# Manually check LDAP database contents using LDAP Account Manager at https://ldap.CHANGEME.org/
```


**Accessing LDAP account manager settings:** LAM should be configured from the templates provided by this role. If you need to temporarily access LAM settings from the web interface (your changes will be overwritten on the next ansible deployment), edit these files:
- `/var/www/{{ ldap_account_manager_fqdn }}/config/config.cfg`: `password: CHANGEME`
- `/var/www/{{ ldap_account_manager_fqdn }}/config/lam.conf`, `Passwd: CHANGEME`
