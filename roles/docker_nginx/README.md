docker_nginx
=============

This role deploy a [nginx](https://en.wikipedia.org/wiki/Nginx) Docker Swarm service meant to be used as a [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) for other DOcker services. It also allow generating [Let's Encrypt](https://en.wikipedia.org/wiki/Let's_Encrypt) SSL/TLS certificates.

A docker [stack](https://docs.docker.com/engine/reference/commandline/stack/) running only the nginx service is created, along with an attachable 'nginx' network. Services from other stacks can attach to this network (it has to be declared as `external: true` in the application stack):

```yaml
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
```

Applications must install their own nginx configuration files under `/etc/docker/services-config/nginx/conf.d/` and notify the `restart nginx docker service` handler after installing/changing nginx configuration files.

Files placed under `/etc/docker/services-config/nginx/static/` will be available in `/usr/share/nginx/static/` inside the container.

Requirements/Dependencies
------------

- Ansible 2.9 or higher.
- The [`docker`](../docker) role
- Nginx binds to ports 80/443 directly on the host's network interface ([host mode networking](https://docs.docker.com/network/host/)). Therefore the host's firewall must allow incoming HTTP/HTTPS connections, for example using the [`common`](../common) role:

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



Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)


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
