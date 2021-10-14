# librelogic.librelogic.mailcatcher

This role will install and configure [mailcatcher](https://github.com/sj26/mailcatcher)

> MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface. Run mailcatcher, set your favourite app to deliver to smtp://127.0.0.1:1025 instead of your default SMTP server, then check out http://127.0.0.1:1080 to see the mail that's arrived so far.


## Requirements/Dependencies/Example playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: my.CHANGEME.org
  roles:
     - librelogic.librelogic.common # optional
     - librelogic.librelogic.apache
     - librelogic.librelogic.mailcatcher

# host_vars/my.CHANGEME.org/my.CHANGEME.org.yml
mailcatcher_fqdn: mailcatcher.CHANGEME.org

# ansible-vault edit host_vars/my.CHANGEME.org/my.CHANGEME.org.vault.yml
mailcatcher_user: "CHANGEME"
mailcatcher_password: "CHANGEME"
```

## License

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt)

## References

- https://github.com/libre-logic/ansible-collection-librelogic/
- https://github.com/sj26/mailcatcher#how
- https://docs.ansible.com/ansible/latest/collections/community/general/gem_module.html
