# Route 👤 -> `VPS` -> `Nginx` -> `Tailscale` -> `Nginx`


### Configure `Nginx` -> `Tailscale` -> `Nginx`

Reminder for how to access Nginx Proxy Manager on the VPS:
* Copy the value of your `Tailnet name` from [here](https://login.tailscale.com/admin/dns)
* The admin gui is available at [`http://vps-tunnel.__TAILNET_NAME__:81`](http://vps-tunnel.__TAILNET_NAME__:81)

---

1) Create Cloudflare API Token
    * Open the API Token dashboard [here](https://dash.cloudflare.com/profile/api-tokens)
    * Click `Create Token`
    * Click `Use template` for `Edit zone DNS`
    * Under `Zone Resources` select `__MY_SITE__.__COM__`
    * Under `Client IP Address Filtering` set `Is in` = `__VPS_IP__`
    * Click `Continue to Summary` > `Create Token`
    * Copy and record the token
1) Add SSL Certificate to Nginx Proxy Manager on the VPS
    * Open the `SSL Certificates` tab in NPM
    * Click `Add SSL Certificate`
    * `Domain Names` = `*.__MY_SITE__.__COM__` and `__MY_SITE__.__COM__`
    * Enable `Use a DNS Challenge`
    * `DNS Provider` = `Cloudflare`
    * Update `Credentials File Content` with your Cloudflare API token from above
    * Click `Save`
1) Define Reverse Proxy for Nginx Proxy Manager on the VPS
    * Open the `Hosts` > `Proxy Hosts` tab in NPM
    * Click `Add Proxy Host`
    * Under the `Details` tab
      * `Domain Names` = `*.__MY_SITE__.__COM__`
      * `Scheme` = `http`
      * `Forward Host` = `__NPM-TUNNEL_IP__`
        * (Acquire the above IP from [here](https://login.tailscale.com/admin/machines))
      * `Port` = `80`
      * Enable `Block Common Exploits`
      * Enable `Websockets Support`
    * Under the `SSL` tab
      * `SSL Certificate` = *the certificate you created above*
      * Enable `Force SSL`
      * Enable `HTTP/2 Support`
    * Click `Save`
1) Define Redirection Host for Nginx Proxy Manager on the VPS
    * Open the `Hosts` > `Redirection Hosts` tab in NPM
    * Click `Add Redirection Host`
    * Under the `Details` tab
      * `Domain Names` = `__MY_SITE__.__COM__`
      * `Scheme` = `https`
      * `Forward Domain` = `auth.__MY_SITE__.__COM__`
      * `HTTP Code` = `301`
      * Enable `Preserve Path`
      * Enable `Block Common Exploits`
    * Under the `SSL` tab
      * `SSL Certificate` = *the certificate you created above*
      * Enable `Force SSL`
      * Enable `HTTP/2 Support`
    * Click `Save`


### Configure Cloudflare DNS -> `VPS`

* Login to the Cloudflare dashboard [here](https://dash.cloudflare.com)
* Click through to `Websites` > `__MY_SITE__.__COM__` > `DNS`
* Click `Edit` for `CNAME` of `__MY_SITE__.__COM__`
  * `Delete` the record
* Click `Add Record`
  * `Type` = `A`
  * `Name` = `__MY_SITE__.__COM__`
  * `IPv4 address` = `__VPS_IP__`
  * `Proxy status` = Disabled
