<p align="center">
  <img src="./assets/jellytin-dark.svg#gh-dark-mode-only" width="300">
  <img src="./assets/jellytin-light.svg#gh-light-mode-only" width="300">
</p>

# Jellytin

Put your local Jellyfin server in a tin, and securely serve it up on the internet 🚀


### Intro
This project is especially helpful if you:
1) Have a local Jellyfin server that you want to access over the internet
1) Do *not* currently have any infrastructure to expose services to the internet
1) Wish to hide + secure Jellyfin behind an identity provider

If you're wondering, "why can't I just expose my Jellyfin server to the internet?"
I recommend reading [Collection of potential security issues in Jellyfin](https://github.com/jellyfin/jellyfin/issues/5415)

The final deployment looks like this:

👤 -> `VPS` -> `Nginx` -> `Tailscale` -> `Nginx` -> `Authentik` -> `Jellyfin`


### Dependencies
* Virtual Private Server (VPS)
  * Additional layer of security, e.g. hide your personal IP
* [Nginx Proxy Manager](https://nginxproxymanager.com/)
  * Management UI for Nginx
* [Tailscale](https://tailscale.com/)
  * Tunnel from VPS to your local network
* [Authentik](https://goauthentik.io/)
  * Provide authentication via LDAP, SSO, etc.
* [Jellyfin](https://jellyfin.org/downloads/)
  * You should already have a Jellyfin server


### Future Improvements

1) This setup currently only allows for access to Jellyfin via web clients.
Jellyfin lacks external authentication capabilities for other clients.
See examples [here](https://github.com/jellyfin/jellyfin-android/issues/123),
[here](https://features.jellyfin.org/posts/471/header-authentication),
& [here](https://features.jellyfin.org/posts/1461/capability-to-specify-client-certificate-for-android-client).

1) Keep an eye on Jellyfin's [SSO plugin](https://github.com/9p4/jellyfin-plugin-sso)
and incorporate it here, once it is stable and no longer "100% alpha software."

1) Await NPM's [Fail2Ban feature request](https://github.com/NginxProxyManager/nginx-proxy-manager/issues/39).

1) Await NPM's [CrowdSec feature request](https://github.com/NginxProxyManager/nginx-proxy-manager/issues/1131).


### Footnote
If you're using a Raspberry Pi, then you will need the [64-bit OS](https://www.raspberrypi.com/news/raspberry-pi-os-64-bit/).


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

### Harden Your VPS
* Harden via [./docs/vps_harden.md](./docs/vps_harden.md)

### Deploy VPS Tunnel
* Deploy via [./vps_tunnel/](./vps_tunnel/)

### Deploy NPM Tunnel
* Deploy via [./npm_tunnel/](./npm_tunnel/)

### Configure Tunnel Routing
* Configure via [./docs/vps_routing.md](./docs/vps_routing.md)

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

---

### The End 🎉

You can use the helper script at [`./all.sh`](./all.sh) to control this stack.
