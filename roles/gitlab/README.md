# librelogic.gitlab

Ansible role to deploy and configure [Gitlab](https://about.gitlab.com/) software forge, using the [all-in-one/"Omnibus"](https://about.gitlab.com/install/#debian) Debian package.


## Requirements/dependencies/example playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: gitlab.CHANGEME.org
  roles:
    - librelogic.librelogic.common # optional
    - librelogic.librelogic.monitoring # optional
    - gitlab

# host_vars/gitlab.CHANGEME.org/gitlab.CHANGEME.org.yml
gitlab_fqdn: gitlab.CHANGEME.org
gitlab_registry_fqdn: registry.CHANGEME.org

# ansible-vault edit host_vars/gitlab.CHANGEME.org/gitlab.CHANGEME.org.yml
gitlab_initial_root_password: "CHANGEME"
gitlab_initial_shared_runners_registration_token: "CHANGEME"
```

See [defaults/main.yml](defaults/main.yml) for all configuration variables


## Usage
-------

## Post-installation

- Login (_Standard_) as `root` with the password defined in `gitlab_root_password`
- Go to `Admin Area` (https://gitlab.CHANGEME.org/admin)
- Settings > General (https://gitlab.CHANGEME.org/admin/application_settings)
  - Visibility and access controls > `Restricted visibility levels`: public (if this is a private instance)
  - Account and limit > `Gravatar enabled`: no (prevent contacting an external gravatar service)
  - Account and limit > `Maximum attachment size (MB)`: 50 (if you need larger attachments)
  - Sign-up restrictions > `Sign up Enabled`: no (to disable new user self-registration and let admin/LDAP manage gitlab accounts)
- Integrations https://gitlab.CHANGEME.org/admin/application_settings/integrations
  - Third party offers > `Do not display offers from third parties within GitLab`: yes
- Test LDAP authentication: logout, then login (_LDAP_) with a LDAP user account. Gitlab accounts for LDAP users are created on their first login. User administration is available at https://gitlab.CHANGEME.org/admin/users
- Update the instance logo: https://gitlab.CHANGEME.org/admin/appearance
- Define default labels: https://gitlab.CHANGEME.org/admin/labels
- Go to https://gitlab.CHANGEME.org/admin/runners, and increase **Maximum job timeout** for each runner if needed.

## Backups

Run `sudo gitlab-backup create BACKUP=latest GZIP_RSYNCABLE=yes`, then backup the `/var/opt/gitlab/backups/` and `/etc/gitlab` directories. For example from a remote backup server running the [rsnapshot](../rsnapshot) role:

```yaml
rsnapshot_backup_execs:
  - 'ssh remotebackup@gitlab.CHANGEME.org sudo gitlab-backup create BACKUP=latest GZIP_RSYNCABLE=yes'

rsnapshot_backup_jobs:
  - { user: 'remotebackup', host: 'gitlab.CHANGEME.org', path: '/var/opt/gitlab/backups/' }
  - { user: 'remotebackup', host: 'gitlab.CHANGEME.org', path: '/etc/gitlab' }
```

The user performing backups must be able to run `/usr/bin/gitlab-backup` as root using `sudo`. For example suing the [common](../common) role:

```yaml
linux_users:
  - name: remotebackup
    sudo_nopasswd_commands: [ '/usr/bin/rsync', '/usr/bin/gitlab-backup' ]
```


## License

GNU GPLv3

## References/Documentation

- https://github.com/nodiscc/xsrv/tree/master/roles/gitlab
- https://docs.gitlab.com/omnibus/README.html
- https://docs.gitlab.com/omnibus/settings/configuration.html
- https://docs.gitlab.com/omnibus/package-information/defaults.html
- https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template



## Mirroring repositories

To mirror a repository from another Gitlab instance, to your own instance:

- Access your Gitlab instance, create an empty repository with the same name as the source repository (ex. https://gitlab.CHANGEME.org/group/myproject)
 - Copyt the original project description and prepend `[MIRROR]` to it (to prevent inadvertent pushes that would be overwritten by mirroring or cause it to fail)
- Access `Settings > Access tokens` (ex. https://gitlab.CHANGEME.org/group/myproject/-/settings/access_tokens)
  - Create a token with `scope: write_repository` (for example named `myproject-mirror`) and copy it to the clipboard
- Access the source project on the upstream gitlab instance
  - Access `Settings > Repository` (ex. https://sourcegitlab.CHANGEME.net/group/myproject/-/settings/repository)
  - Unfold `Mirroring repositories` et set up mirroring:
  - Git repository URL: `https://myproject-mirror@gitlab.CHANGEME.org/group/myproject`
  - Mirror direction: `Push`
  - Authentication method: `Password`
  - Password: the access token generated on the target instance
  - Click `Mirror repository`
  - Click `Update now` and reload the page to check for completion (`Last successful update: just now`)
- Check on the target instance that the repository has been mirrored correctly
