# Route Internet -> VPS -> Tailscale


### Configure Tailscale

* Disable Key Expiry for `vps-tunnel` machine, via the [docs](https://web.archive.org/web/20221019082019/https://tailscale.com/kb/1028/key-expiry/#disabling-key-expiry)
* `Enable MagicDNS` [here](https://login.tailscale.com/admin/dns)
  * Also, copy the value of your `Tailnet name`
* Config Tailscale ACL
  * TODO


### Configure NPM Admin

* With the `vps-tunnel` running from [`./vps_deploy.md`](./vps_deploy.md), you can now access the VPS via Tailscale
* Ensure you have a [Tailscale client](https://tailscale.com/download) running on your local machine
* Open the Nginx Proxy Manager admin gui via [`http://vps-tunnel.__TAILNET_NAME__:81`](http://vps-tunnel.__TAILNET_NAME__:81) (copied from above)
* Login to the gui with the below and reset your password:
  ```yml
  Email:    admin@example.com
  Password: changeme
  ```
  ☝️ Very important -- don't skip that step ⚠️


### Configure NPM Proxy

* TODO


### Expose VPS to Internet

* TODO


### Configure Cloudflare DNS -> VPS

* TODO
