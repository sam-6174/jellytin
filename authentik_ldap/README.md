!! UPDATE THIS README !!

* Copy the variables template via `cp ./template.env ./.env`
* Set the `SECRET` values within `./local.env`, as described BELOW
* Deploy via `docker-compose up -d`



===

Do the below via the Authentik Dashboard, under Applications > ...
  * Create an LDAP Outpost
    * `Name` = `LDAP-outpost`
    * `Type` = `LDAP`
  * Create an LDAP Provider
    * `Name` = `LDAP-provider`
    * `Bind DN` = `DC=ldap,DC=__MY_SITE__,DC=__COM__`  (assuming your domain is `__MY_SITE__.__COM__`)
    * `Certificate` = `self-signed`
  * Create an LDAP Application
    * `Name` = `LDAP-application`
    * `Slug` = `ldap-application`
    * `Provider` = `LDAP-provider`

---

From the Authentik Admin Dashboard, open `Directory` > `Tokens & App Passwords`
  * There should be a Token for an LDAP user auto-created by Authentik
  * Use this value for the SECRET `AUTHENTIK_LDAP__TOKEN` in [./.env](./.env)

---

Replace auto-deployed container
* Use the Portainer dashboard to find the container named `ak-outpost-ldap-outpost`
  * This container should *not* be attached to any Stack
    * This container was auto-deployed by Authentik
  * Stop the container
  * Now we've replaced this auto-deployed container with the docker-compose from this repo
* Deploy [./docker-compose.yml](./docker-compose.yml) by either...
  * ... creating a new Portainer Stack...
  * ... or adding to the [../authentik/](../authentik/) Portainer Stack
* Validate that the above docker container is working by checking its logs
* Remove the auto-deployed container
