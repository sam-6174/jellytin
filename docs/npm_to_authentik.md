# Configure Nginx -> Authentik

(Use Nginx Proxy Manager running on your local
network, *not* on your VPS).

* Open NPM and click `Add Proxy Host`
  * Under the `Details` tab, set these values:
    * `Domain Names` = `*.__MY_SITE__.__COM__`
    * `Scheme` = `http`
    * `Forward Hostname` = `authentik-server`
    * `Forward Port` = `9000`
    * enable `Block Common Exploits`
    * enable `Websockets Support`
* You should now be able to access Authentik via [`https://auth.__MY_SITE__.__COM__`](https://auth.__MY_SITE__.__COM__)
