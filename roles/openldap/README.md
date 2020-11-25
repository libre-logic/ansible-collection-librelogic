# openldap

This role sets up OpenLDAP, a [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol) directory service, and web applications for LDAP directory management:
 - [LDAP Account Manager](https://ldap-account-manager.org/)
 - [LTB Self-Service Password](https://ltb-project.org/documentation/self-service-password).

LDAP Accountmanager is made available at https://ldap.CHANGEME.org/lam. SSP is made available at https://ldap.CHANGEME.org/ssp


## Dependencies/Requirements

- Ansible 2.7 or higher
- [apache](../apache] role
- [common](../common] role (optional)
 
An apache virtualhost must be defined in the host configuration. For example:

```yaml
apache_virtualhosts:
  - servername: "ldap.CHANGEME.org"
    documentroot: "/var/www/"
    cert_mode: "selfsigned"
```


# Configuration Variables

See [defaults/main.yml](defaults/main.yml)


## Usage

### LDAP Structure

* The _Users DN_ (DN under which all user account objects are stored) is `ou=Users,dc=CHANGEME,dc=org`.
* A full user DN is in the form `dc=exampleuser,ou=Users,dc=CHANGEME,dc=org`
* The _Base DN_ is `dc=CHANGEME,dc=org`
* LDAP users can be managed at https://ldap.CHANGEME.org/lam/templates/lists/list.php?type=user
* LDAP groups can be managed at https://ldap.CHANGEME.org/lam/templates/lists/list.php?type=group

#### Utilisateurs système (root et bind)

LDAP `admin` (root) and `bind` users are system accounts and are not visible in LDAP Account Manager main users view. These LDAP users are managed by ansible.
It is mandatory to define passwords for these users in host variables.

- The admin/root user DN is `cn=admin,dc=CHANGEME,dc=org`. This account should only be used for LDAP administration.
- An unprivilegied user `cn=bind,ou=system,dc=CHANGEME,dc=org` is created by ansible. This account should be configured in applications/services that rely on LDAP authentication (so that they can search the LDAP tree for valud user accounts)

### Backups

See the included backup script [files/usr_local_bin_backup-ldap.sh](files/usr_local_bin_backup-ldap.sh).

Alternatively, to dump contents of the OpenLDAP database, use `sudo slapcat` from the host itself, or `sudo ldapsearch -w $openldap_server_bind_password -H ldap://ldap.CHANGEME.org -D "cn=bind,ou=system,dc=CHANGEME,dc=org"` from a remote host.

**Restoring backups:**

```bash
# Purge target LDAP database
ssh -t ldap-test.EXAMPLE.org sudo apt purge slapd
# reinstall openLDAP
ansible-playbook playbook.yml --limit ldap-test.CHANGEME.org --tags openldap
# upload LDAP backups to the target host
rsync -avP $local_backups_path/daily.0/var/backups/rsnapshot/daily.0/ldap.EXAMPLE.org/var/backups/slapd/slapd-backup.ldif ldap-test.EXAMPLE.org:
# restore ldap backup from LDIF file
ssh -t ldap-test.EXAMPLE.org sudo slapadd -c -l slapd-backup.ldif
# Manually check LDAP database contents using LDAP Accoutn Manager / https://ldap-test.EXAMPLE.org/lam
```

### Accessing LDAP Account Manager configuration

Access to LDAP Account Manager configuation from https://ldap.CHANGEME.org/lam/templates/config/index.php is locked for security reasons. LAM should only be configured
from your ansible playbook. If you need temporary access to LAM configuration, uncomment password directives in

- `/etc/ldap-account-manager/config.cfg` to access _Edit general settings_(`password: monpasswordtemporaire`)
- `/var/lib/ldap-account-manager/config/lam.conf` to access _Edit server profiles_ (`Passwd: monpasswordtemporaire`)

Passwords can be set in cleartext - don't forget to comment them back when you are done.
Running the playbook will overwrite any manual configuration change made from the web interface - only use the web interface to test and validate changes, and report necessary configuration changes to files in the `templates/` directory of the roles if you need to persist your changes. 



# License

[GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.txt)


# References

- https://github.com/nodiscc/xsrv/tree/master/roles/openldap


