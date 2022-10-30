# Deploy Authentik LDAP Outpost


* Open the Authentik Admin Dashboard
  * Go to `Directory` > `Users`
    * Select `Create Service Account`
    * Name the user `service-ldap-outpost`
  * Go to `Applications` > `Providers`
    * Click `Create`
      * Select `LDAP Provider`
      * On the 2nd tab:
        * `Name` = `ldap-provider`
        * `Search Group` = `service-ldap-outpost`
        * `Base DN` = `DC=ldap,DC=__MY_SITE__,DC=__COM__`
        * Use default values for all other fields
  * Go to `Applications` > `Applications`
    * Click `Create`
      * `Name` = `ldap-application`
      * `Provider` = `ldap-provider`
  * Go to `Applications` > `Outposts`
    * Click `Create`
      * `Name` = `ldap-outpost`
      * `Type` = `LDAP`
      * `Integration` = `---------`
        * (We'll integrate by deploying via docker-compose)
      * `Applications` = `ldap-application`
    * Click `View Deployment Info` on the outpost you just created
      * (note that you must access the webui via [https](https://__HOST_IP__:9443))
      * Copy the `AUTHENTIK_TOKEN`
* Copy the variables template via `cp ./template.env ./secret.env`
  * Within `./secret.env`:
    * Update `AUTHENTIK_TOKEN` to the value you copied above
    * Update `AUTHENTIK_HOST_BROWSER` as necessary
* Deploy via `docker-compose up -d`
* Check that the deploy is working via `docker-compose logs`
  * You should see a message like `{"event":"Fetched outpost configuration", ...}`
