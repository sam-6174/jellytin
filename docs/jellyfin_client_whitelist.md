# Jellyfin Dynamic IP Whitelist


### Background

Currently, only web browsers are capable of accessing
a Jellyfin server behind Authentik.

See examples [here](https://github.com/jellyfin/jellyfin-android/issues/123),
[here](https://features.jellyfin.org/posts/471/header-authentication),
& [here](https://features.jellyfin.org/posts/1461/capability-to-specify-client-certificate-for-android-client).

Following below is a work-around for the lack of authentication
mechanisms supported by the various Jellyfin [clients](https://jellyfin.org/clients/)
(Android, etc.).

The end result is that the Jellyfin server will be accessible
via any of the client apps, while still not exposed to the
internet at large.


You may recall that our current setup flows like this:

👤 -> `VPS` -> `Nginx` -> `Tailscale` -> `Nginx` -> `Authentik` -> `Jellyfin Login Screen`

The work-around implemented here instead does this:

👤 -> `VPS` -> `Nginx` -> `Tailscale` -> `{Nginx IP Check}` -> `Jellyfin Login Screen`


The logic of the `{Nginx IP Check}` works like this:

1) Nginx directly queries Authentik via API to
   check if the client IP address is associated
   with an unexpired Authentik session
    * (Authentik sessions expire after 2 weeks)
1) If the check passes, then Nginx proxies
   directly to Jellyfin, bypassing Authentik
    * (Nginx caches allowed IP addresses for 24 hours)

---

### Create an Authentik API Token

* Open Authentik Admin web ui
* Click `Directory` > `Tokens & App Passwords` > `Create`
  * `Identifier` = `npm-ip-whitelist`
  * `User` = `akadmin`
  * `Intent` = `API Token`
  * Disable `Expiration`
* Click the 📋 button to copy the `npm-ip-whitelist` token
  * (We'll use this below)


### Configure Nginx Proxy Manager

(Use Nginx Proxy Manager running on your local
network, *not* on your VPS).

* Open NPM and click `Add Proxy Host`
* Click the `Details` tab
  * `Domain Names` = `jellyfin-whitelist.__MY_SITE__.__COM__`
  * `Scheme` = `http`
  * `Hostname` = `does-not-exist`
    * (we'll configure this elsewhere)
  * `Port` = `4321`
    * (we'll configure this elsewhere)
  * Enable `Block Common Exploits`
  * Enable `Websockets Support`
* Click the `Custom locations` tab
  * Click `Add location`
    * `location` = `/`
    * `Scheme` = `http`
    * `Hostname` = `__JELLYFIN_IP__`
    * `Port` = `__JELLYFIN_PORT__`
    * Click the ⚙️ button to enter your custom Nginx configuration:
      * Paste the contents of [./jellyfin_client_whitelist.conf](./jellyfin_client_whitelist.conf)
  * Click `Add location`
    * `location` = `/authentik_sessions/`
    * `Scheme` = `http`
    * `Hostname` = `authentik-server/api/v3/core/authenticated_sessions/`
    * `Port` = `9000`
    * Click the ⚙️ button to enter your custom Nginx configuration:
      ```nginx
      internal;
      proxy_pass_request_headers off;
      proxy_pass_request_body off;
      proxy_set_header Accept "application/json";
      proxy_set_header Authorization "Bearer __Authentik_API_Token__";
      ```
      * (Replace `__Authentik_API_Token__` with the value from prior)
  * `Save` the proxy


### Test the Whitelist

* Failure/Block Mode
  * Try to access `https://jellyfin-whitelist.__MY_SITE__.__COM__` from a new IP address
    * (Use your phone, vpn, etc.)
  * You should get a `403 Forbidden` error
* Success/Allow Mode
  * Login to `https://auth.__MY_SITE__.__COM__`
  * Now visit `https://jellyfin-whitelist.__MY_SITE__.__COM__`
  * You should get the Jellyfin login page

---

In order to use the Jellyfin clients:

1) Login to `https://auth.__MY_SITE__.__COM__` from a web browser
1) Use `https://jellyfin-whitelist.__MY_SITE__.__COM__:443` from your app

☝️ do (1) and (2) from the same IP address
