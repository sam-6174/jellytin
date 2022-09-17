<img src="./jellytin.png"></img>

# Jellytin

Put your local Jellyfin server in a tin, and securely serve it up on the internet 🚀


### Intro
This project is especially helpful if you:
1) Have a local Jellyfin server that you want to access over the internet
1) Do *not* currently have any infrastructure to expose services to the internet
1) Wish to hide + secure Jellyfin behind an identity provider

If you're wondering, "why can't I just expose my Jellyfin server to the internet?"
I recommend reading [Collection of potential security issues in Jellyfin](https://github.com/jellyfin/jellyfin/issues/5415)


### Dependencies
* [Authentik](https://goauthentik.io/)
  * Provide authentication via LDAP, SSO, etc.
* [Nginx Proxy Manager](https://nginxproxymanager.com/)
  * Proxy between `Cloudflare Tunnel` -> `Nginx Reverse Proxy` -> `Authentik` -> `Jellyfin`
* [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/)
  * Serve content without forwarding ports on your router


### Footnote
If you're using a Raspberry Pi, then you should run the [64-bit OS](https://www.raspberrypi.com/news/raspberry-pi-os-64-bit/).


# Instructions


### Install `docker` & `docker-compose`
* Skip if already installed on your system
* Otherwise, install via [./docker_install.sh](./docker_install.sh)

### Deploy Authentik
* Deploy via [./authentik/](./authentik/)
* Generalize yourself with [Outposts, Providers, & Applications](https://goauthentik.io/docs/terminology)
  * tl;dr to deploy an application in Authentik, you need an Outpost to service a Provider, which services an Application

### Deploy Nginx Proxy Manager
* Deploy via [./nginx_proxy_manager/](./nginx_proxy_manager/)

### Purchase & Configure Cloudflare Domain
* Configure via [./docs/cloudflare_domain.md](./docs/cloudflare_domain.md)

### Deploy Cloudflare Tunnel
* Deploy via [./cloudflare_tunnel/](./cloudflare_tunnel/)

### Configure Nginx -> Authentik
* Configure via [./docs/npm_to_authentik.md](./docs/npm_to_authentik.md)

### Configure Authentik -> Jellyfin
* Configure via [./docs/authentik_to_jellyfin.md](./docs/authentik_to_jellyfin.md)

### Deploy Authentik LDAP Service
* Deploy via [./authentik_ldap/](./authentik_ldap/)

### Configure Jellyfin for LDAP Authentication
* Configure via [./docs/jellyfin_ldap.md](./docs/jellyfin_ldap.md)

### Create Jellyfin Users via Authentik
* Create via [./docs/jellyfin_ldap_users.md](./docs/jellyfin_ldap_users.md)
