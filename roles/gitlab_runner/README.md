# librelogic.librelogic.gitlab_runner

Ansible role to deploy and configure [Gitlab Runner](https://docs.gitlab.com/runner/), a continuous integration runner for the Gitlab software forge.

## Requirements/dependencies/example playbook

See [meta/main.yml](defaults/main.yml)

```yaml
- hosts: runner.CHANGEME.org
  roles:
    - nodiscc.xsrv.common
    - librelogic.librelogic.docker
    - librelogic.librelogic.gitlab_runner

# host_vars/runner.CHANGEME.org/runner.CHANGEME.org.yml
gitlab_runner_gitlab_url: "https://gitlab.CHANGEME.com"

# host_vars/runner.CHANGEME.org/runner.CHANGEME.org.vault.yml
gitlab_runner_registration_token: "CHANGEME"
gitlab_runner_api_token: "CHANGEME"
```

See [defaults/main.yml](defaults/main.yml) for all configuration variables


## License

GPL-3.0

## References/Documentation

- https://github.com/libre-logic/ansible-collection/
- https://docs.gitlab.com/runner/install/linux-repository.html
- https://docs.gitlab.com/runner/register/index.html
- https://docs.ansible.com/ansible/latest/modules/gitlab_runner_module.html
- https://docs.gitlab.com/runner/configuration/index.html
- https://docs.gitlab.com/ee/ci/runners/
- https://docs.gitlab.com/runner/configuration/
