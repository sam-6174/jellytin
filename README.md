<img src="./jellytin.png"></img>

# Jellytin

Put your local Jellyfin server in a tin, and securely serve it up on the internet 🚀


### Intro
This project is especially helpful if you:
1) Have a local Jellyfin server that you want to access over the internet
1) Do *not* currently have any infrastructure to expose services to the internet
1) Wish to hide + secure Jellyfin behind an identity provider
   1) (and also wish to access Jellyfin via non-browser clients, e.g. Android app)


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
* Purchase your domain via [this](https://developers.cloudflare.com/registrar/get-started/register-domain)
* We'll assume that you purchase a domain of `__MY_SITE__.__COM__`
* Configure `<security stuff>`
* Disable `<caching stuff>`
* Add wildcard CNAME


### Deploy Cloudflare Tunnel
* Deploy via [./cloudflare_tunnel/](./cloudflare_tunnel/)


### Configure Nginx -> Authentik
* Open Nginx Proxy Manager and click `Add Proxy Host`
  * Under the `Details` tab, set these values:
    * `Domain Names` = `auth.__MY_SITE__.__COM__`
    * `Scheme` = `http`
    * `Forward Hostname` = `authentik-server`
    * `Forward Port` = `9000`
    * enable `Cache Assets`
    * enable `Block Common Exploits`
    * enable `Websockets Support`
* You should now be able to access Authentik via [`https://auth.__MY_SITE__.__COM__`](https://auth.__MY_SITE__.__COM__)


### Configure Authentik -> Jellyfin
1) Open Nginx Proxy Manager and click `Add Proxy Host`
  * `Domain Names` = `jf.__MY_SITE__.__COM__`
  * `Scheme` = `http`
  * `Forward Hostname` = `authentik-server`
  * `Forward Port` = `9000`
  * enable `Block Common Exploits`
  * enable `Websockets Support`
1) Open the Authentik Admin Dashboard
  * Go to `Applications` > `Providers`
    * Click `Create`
      * Select `Proxy Provider`
      * On the 2nd tab:
        * `Name` = `jellyfin-provider`
        * `Authorization flow` = `Authorize Application (default-provider-authorization-explicit-consent)`
        * `External host` = `https://jf.__MY_SITE__.__COM__`
        * `Internal host` = `http://__JELLYFIN_IP__:__JELLYFIN_PORT__`
  * Go to `Applications` > `Applications`
    * Click `Create`
      * `Name` = `Jellyfin`
      * `Provider` = `jellyfin-provider`
      * Under `UI settings`
        * Upload a nice looking `Icon`, e.g. [this](https://jellyfin.org/images/banner-dark.svg)
  * Go to `Applications` > `Outposts`
    * Click the 📝 icon to update `authentik Embedded Outpost`
      * Add `Jellyfin` to the list of `Applications`
      * In `Configuration`, ensure that you have `authentik_host: https://auth.__MY_SITE__.__COM__`
1) You should now be able to access Jellyfin via [`https://jf.__MY_SITE__.__COM__`](https://jf.__MY_SITE__.__COM__)


### Deploy Authentik LDAP Service
* Deploy via [./authentik_ldap/](./authentik_ldap/)


### Configure Jellyfin for LDAP Authentication
* xx




Install Nginx Proxy Manager
https://geekscircuit.com/set-up-authentik-sso-with-nginx-proxy-manager/
https://docs.ibracorp.io/authentik/authentik/authentik-proxy-solution


configure authentik ldap
  - https://github.com/jellyfin/jellyfin-plugin-ldapauth/issues/120
  - https://goauthentik.io/integrations/services/pfsense/
  - https://goauthentik.io/integrations/services/sssd/
