docker_nginx
=============

This roles generates a basic/hardened configuration for nginx docker containers. It allows dynamic deployment of reverse-proxies in front of other applications, using a simple `nginx_servers` configuration block (see [defaults/main.yml](defaults/main.yml)). It also supports, for each virtual server:
- automatic generation of self-signed SSL/TLS certificates
- using a pre-generated SSL/TLS certificate/key
- automatic generation of [Let's Encrypt](https://en.wikipedia.org/wiki/Let's_Encrypt) SSL/TLS certificates
- HTTP Basic Auth password protection

A docker stack running only the nginx service is created, along with an attachable 'nginx' network.
Services from other stacks can attach to this network (it has to be declared as 'external: true' in the stack):

```yaml
# use this network: directive in application stacks/compose files
version: '3'

networks:
  nginx:
    external: true

services:
  myapp:
    ...
    networks:
      - nginx
      - myapp-network
  db:
    ...
    networks:
      - myapp-network

```

Nginx binds to ports 80/443 directly on the host's network interface [host mode networking].
Therefore the host's firewall must allow incoming HTTP/HTTPS connections, for example using the [`common`](../common) role:

```yaml
firehol_networks:
  - name: "internet"
    src: "any"
    interface: "any"
    policy: "RETURN"
    allow_input:
      - { name: "http", src: "any" } # required by docker_nginx
      - { name: "https", src: "any" } # required by docker_nginx
      ...
```


Requirements
------------

- This role requires Ansible 2.9 or higher.
- Firewalls must allow incoming connections on port `tcp/80` for Let's Encrypt Certificate generation (HTTP-01 challenge)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)


Dependencies
------------

- The [`docker`](../docker)


Example Playbook
----------------

```yaml
- hosts: my.CHANGEME.org
  roles:
    - common
    - docker
    - docker_nginx
```

License
-------

[GPL-3.0](../LICENSE)

References/Documentation
------------

- https://github.com/libre-logic/ansible-collection
- https://docs.nginx.com/
- https://docs.docker.com/
- https://certbot.eff.org/
