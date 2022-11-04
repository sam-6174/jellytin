# Configure Authentik -> Jellyfin

* Open the Authentik Admin Dashboard
* Go to `Directory` > `Groups`
  * `Create` two groups:
    1) `jellyfin-users`
    1) `jellyfin-admins`
* Go to `Applications` > `Providers`
  * Click `Create`
    * Select `Proxy Provider`
    * On the 2nd tab:
      * `Name` = `jellyfin-provider`
      * `Authorization flow` = `Authorize Application (default-provider-authorization-implicit-consent)`
      * `External host` = `https://jf.__MY_SITE__.__COM__`
      * `Internal host` = `http://__JELLYFIN_IP__:__JELLYFIN_PORT__`
* Go to `Applications` > `Applications`
  * Click `Create`
    * `Name` = `Jellyfin`
    * `Provider` = `jellyfin-provider`
    * Under `UI settings`
      * Upload an `Icon`, e.g. [this](../assets/jellyfin.svg)
  * Click `Jellyfin` (the app you just created) > `Policy / Group / User Bindings`
    * `Create Binding` for each `Group`:
      1) `jellyfin-users`
      1) `jellyfin-admins`
      1) `authentik Admins`
* Go to `Applications` > `Outposts`
  * Click the 📝 icon to update `authentik Embedded Outpost`
    * Add `Jellyfin` to the list of `Applications`
    * In `Configuration`, ensure that you have `authentik_host: https://auth.__MY_SITE__.__COM__`
* You should now be able to access Jellyfin via [`https://jf.__MY_SITE__.__COM__`](https://jf.__MY_SITE__.__COM__)
