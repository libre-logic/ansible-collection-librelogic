# librelogic.gitlab

Ansible role to deploy and configure [Gitlab](https://about.gitlab.com/) software forge, using the [all-in-one/"Omnibus"](https://about.gitlab.com/install/#debian) Debian package.


## Requirements/dependencies/example playbook

- 4GB RAM **minimum**
- When `gitlab_letsencrypt_enable: true` (the default), public DNS record pointing to the Gitlab instance's public IP address
- See [meta/main.yml](meta/main.yml)

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

The user performing backups must be able to run `/usr/bin/gitlab-backup` as root using `sudo`. For example using the [common](../common) role:

```yaml
linux_users:
  - name: remotebackup
    sudo_nopasswd_commands: [ '/usr/bin/rsync', '/usr/bin/gitlab-backup' ]
```

**Restoring backups:**

```bash
# deploy a working gitlab instance
user@controller:~$ ansible-playbook playbook.yml --tags=gitlab --limit=gitlab.CHANGEME.org

# see https://docs.gitlab.com/ee/raketasks/backup_restore.html#restore-prerequisites
# mount your target host home directory using sshfs
user@controller:~$ mkdir gitlab-restore
user@controller:~$ sshfs user@gitlab: gitlab-restore
# transfer latest backups from your backup server to the target host (~1h30/25GB)
user@controller:~$ rsync --archive --compress --verbose --progress --rsync-path='/usr/bin/sudo /usr/bin/rsync' --fake-super user@backup.example.org:/var/backups/rsnapshot/daily.0/gitlab.example.org/var/opt/gitlab/backups/latest_gitlab_backup.tar gitlab-restore/
user@controller:~$ rsync --archive --compress --verbose --progress --rsync-path='/usr/bin/sudo /usr/bin/rsync' --fake-super user@backup.example.org:/var/backups/rsnapshot/daily.0/gitlab.example.org/etc/gitlab/gitlab-secrets.json gitlab-restore/
user@controller:~$ ssh gitlab.CHANGEME.org

user@gitlab:~$ sudo mv latest_gitlab_backup.tar /var/opt/gitlab/backups/
user@gitlab:~$ sudo chown -R git:git /var/opt/gitlab/backups/
user@gitlab:~$ sudo mv gitlab-secrets.json /etc/gitlab/gitlab-secrets.json
user@gitlab:~$ sudo chown root:root /etc/gitlab/gitlab-secrets.json
user@gitlab:~$ sudo chmod 0600 /etc/gitlab/gitlab-secrets.json
user@gitlab:~$ sudo gitlab-ctl stop puma
user@gitlab:~$ sudo gitlab-ctl stop sidekiq
user@gitlab:~$ sudo gitlab-ctl status
user@gitlab:~$ sudo gitlab-backup restore BACKUP=latest
# Unpacking backup ... done
# Be sure to stop Puma, Sidekiq, and any other process that
# connects to the database before proceeding. For Omnibus
# installs, see the following link for more information:
# https://docs.gitlab.com/ee/raketasks/backup_restore.html#restore-for-omnibus-gitlab-installations
# Before restoring the database, we will remove all existing
# tables to avoid future upgrade problems. Be aware that if you have
# custom tables in the GitLab database these tables and all data will be
# removed.
# Do you want to continue (yes/no)? yes
# Removing all tables. Press `Ctrl-C` within 5 seconds to abort
# 2022-02-03 16:15:49 +0100 -- Cleaning the database ... 
# 2022-02-03 16:17:09 +0100 -- done
# 2022-02-03 16:17:09 +0100 -- Restoring database ... 
# NOTE some errors are expected, https://gitlab.com/gitlab-org/gitlab/-/issues/266988, https://gitlab.com/gitlab-org/gitlab/-/blob/626397fd57ea432a217e0c3b6b6fc8e0b6575e14/lib/backup/database.rb#L11-17
# ...
# 2022-02-03 16:38:16 +0100 -- done
# 2022-02-03 16:38:16 +0100 -- Restoring uploads ... 
# 2022-02-03 16:38:41 +0100 -- done
# 2022-02-03 16:38:41 +0100 -- Restoring builds ... 
# 2022-02-03 16:38:41 +0100 -- done
# 2022-02-03 16:38:41 +0100 -- Restoring artifacts ... 
# 2022-02-03 16:39:44 +0100 -- done
# 2022-02-03 16:39:44 +0100 -- Restoring pages ... 
# 2022-02-03 16:39:44 +0100 -- done
# 2022-02-03 16:39:44 +0100 -- Restoring lfs objects ... 
# 2022-02-03 16:39:45 +0100 -- done
# 2022-02-03 16:39:45 +0100 -- Restoring terraform states ... 
# 2022-02-03 16:39:45 +0100 -- done
# 2022-02-03 16:39:45 +0100 -- Restoring container registry images ... 
# 2022-02-03 16:48:45 +0100 -- done
# 2022-02-03 16:48:45 +0100 -- Restoring packages ...
# 2022-02-03 16:49:39 +0100 -- done
# This task will now rebuild the authorized_keys file.
# You will lose any data stored in the authorized_keys file.
# Do you want to continue (yes/no)? yes
# Deleting backups/tmp ... done
# Warning: Your gitlab.rb and gitlab-secrets.json files contain sensitive data 
# and are not included in this backup. You will need to restore these files manually.
# Restore task is done.
# Transfering ownership of /var/opt/gitlab/gitlab-rails/shared/registry to registry

user@gitlab:~$ sudo gitlab-ctl reconfigure
user@gitlab:~$ sudo gitlab-ctl restart
user@gitlab:~$ sudo gitlab-rake gitlab:check SANITIZE=true # if this fails, maybe Gitlab has not finished starting up, try again
user@gitlab:~$ sudo gitlab-rake gitlab:doctor:secrets
user@gitlab:~$ sudo gitlab-rake gitlab:artifacts:check # optional
sudo gitlab-rake gitlab:lfs:check # optional
sudo gitlab-rake gitlab:uploads:check # optional
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
