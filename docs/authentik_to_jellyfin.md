1) Open Nginx Proxy Manager and click `Add Proxy Host`
  * `Domain Names` = `jf.__MY_SITE__.__COM__`
  * `Scheme` = `http`
  * `Forward Hostname` = `authentik-server`
  * `Forward Port` = `9000`
  * enable `Block Common Exploits`
  * enable `Websockets Support`
2) Open the Authentik Admin Dashboard
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
3) You should now be able to access Jellyfin via [`https://jf.__MY_SITE__.__COM__`](https://jf.__MY_SITE__.__COM__)
