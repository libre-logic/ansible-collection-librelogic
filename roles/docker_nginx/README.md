# librelogic.librelogic.docker_nginx

This role deploys a [nginx](https://en.wikipedia.org/wiki/Nginx) Docker Swarm service for use as a [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) for other Docker services, and allows generating [Let's Encrypt](https://en.wikipedia.org/wiki/Let's_Encrypt) SSL/TLS certificates.

A docker [stack](https://docs.docker.com/engine/reference/commandline/stack/) running a single `nginx-reverseproxy` service is created, along with an attachable 'nginx' network. 

**DEPRECATED** This role is deprecated in favor of the [apache](../apache) role. If you are still using this role, please adapt your nginx configuration for apache, then set `docker_nginx_remove: yes` before applying the apache role (this will remove the nginx Docker service/configuration and allow apache to bind port 80/443).

## Requirements/dependencies/example Playbook

See [meta/main.yml](meta/main.yml)

```yaml
- hosts: my.CHANGEME.org
  roles:
    - librelogic.librelogic.docker
    - librelogic.librelogic.docker_nginx

# host_vars/my.CHANGEME.org/myCHANGEME.org.yml
nginx_letsencrypt_certificates:
  - myapplication.CHANGEME.org
```

See [defaults/main.yml](defaults/main.yml) for all configuration variables

To use `nginx_letsencrypt_certificates`, ports tcp/80,443 must be reachable from the Internet ([certbot](https://certbot.eff.org/docs/using.html) uses the [HTTP-01 challenge](https://certbot.eff.org/docs/challenges.html#http-01-challenge)).



## Integration with other roles

Other Docker services must define an `external: true` `nginx` network, and attach it:

```yaml
# docker-compose.myapplication.yml
version: '3'
# the nginx network must be declared as external: true
networks:
  nginx:
    external: true
services:
  myapp:
    ...
    networks:
      - nginx
      - myapp-network
    # required to read let's encrypt certificates/keys from containers
    volumes:
      - /etc/letsencrypt:/etc/letsencrypt:ro
```

Other Docker services must install their nginx configuration files under `/etc/docker/services-config/nginx/conf.d/` and restart the `nginx-reverseproxy` swarm service:

```yaml
- name: copy nginx reverseproxy configuration for myapplication
  template:
    src: "etc_docker_services-config/nginx_conf.d_myapplication.conf.j2"
    dest: "/etc/docker/services-config/nginx/conf.d/myapplication.conf"
    owner: root
    group: root
    mode: 0644
  notify: restart nginx docker service
```

```nginx
# etc_docker_services-config/nginx_conf.d_myapplication.conf.j2
server {
    listen 443 ssl;
    server_name {{ myapplication_fqdn }};

{% if myapplication_https_mode == 'selfsigned' %}
    ssl_certificate /etc/ssl/certs/{{ myapplication_fqdn }}.crt;
    ssl_certificate_key /etc/ssl/private/{{ myapplication_fqdn }}.key;
{% elif myapplication_https_mode == 'letsencrypt' %}
    ssl_certificate /etc/letsencrypt/live/{{ myapplication_fqdn }}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live//{{ myapplication_fqdn }}/privkey.pem;
{% endif %}
```

Files placed under `/etc/docker/services-config/nginx/static/` will be available in `/usr/share/nginx/static/` inside the container.



## Limitations

- The Docker bridge IP address is seen/logged from the container instead of the real user IP address (https://github.com/moby/moby/issues/25526)
- [Host-mode networking](https://docs.docker.com/network/host/) bypasses host firewall rules - tcp/80 and 443 are always exposed to `any`

## License

[GPL-3.0](../LICENSE)

## References/Documentation

- https://github.com/libre-logic/ansible-collection
- https://docs.nginx.com/
- https://docs.docker.com/
- https://certbot.eff.org/
