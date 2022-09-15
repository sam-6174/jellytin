1) Open the Authentik Admin Dashboard
  * Go to `Directory` > `Users`
  * Click `Create`
    * `Username` = `<name_of_your_jellyfin_user>`
    * `Groups` = `jellyfin-users`
  * Click `˅` to expand user `service-ldap-outpost`
    * Click `Set password`
    * Configure the user's password
2) You should now be able to login to Jellyfin with the above user via [`https://jf.__MY_SITE__.__COM__`](https://jf.__MY_SITE__.__COM__)
  * (note that with caching enabled on the LDAP Provider, it may take up to 5 minutes for the refresh to load a new user)
