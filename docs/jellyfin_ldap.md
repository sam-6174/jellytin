1) Open the Authentik Admin Dashboard
    * Go to `Directory` > `Users`
      * Click `📁 Root`
      * Click `˅` to expand user `service-ldap-outpost`
      * Click `Set Password`
      * You can use `openssl rand -base64 36` to generate a password
1) Install the [Jellyfin LDAP-Auth Plugin](https://github.com/jellyfin/jellyfin-plugin-ldapauth#installation)
1) Configure the plugin's settings via Jellyfin UI
    * `LDAP Server` = `__HOST_IP__`
    * `Secure LDAP` = false
    * `LDAP Base DN for searches` = `dc=ldap,dc=__MY_SITE__,dc=__COM__`
    * `LDAP Port` = `389`
    * `LDAP Attributes` = `cn`
    * `LDAP Name Attribute` = `cn`
    * `LDAP User Filter` = `(memberOf=cn=jellyfin-users,ou=groups,dc=ldap,dc=__MY_SITE__,dc=__COM__)`
    * `LDAP Admin Filter` = `(memberOf=cn=jellyfin-admins,ou=groups,dc=ldap,dc=__MY_SITE__,dc=__COM__)`
    * `LDAP Bind User` = `cn=service-ldap-outpost,ou=users,dc=ldap,dc=__MY_SITE__,dc=__COM__`
    * `LDAP Bind User Password` = `__PASSWORD_FROM_ABOVE__`
