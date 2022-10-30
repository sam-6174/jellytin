# Deploy VPS Tunnel Stack


### Prerequisites

* Install [docker-compose](../docker_install.sh) on your VPS
* [Register](https://login.tailscale.com/start) for a Tailscale Account
* `Enable MagicDNS` for Tailscale [here](https://login.tailscale.com/admin/dns)


### Deploy Tunnel on VPS

1) Config `./.env` Secrets
    * Copy the variables template via `cp ./template.env ./.env`
    * Open `./.env` and set the SECRET values
1) Authenticate Tailscale Container
    * Execute `docker-compose run --rm tailscale`
    * Copy the URL from the above command's output
    * Paste the URL into your web browser
    * Authorize the container
    * The container's output should update with an eventual `health("overall"): ok`
    * `Ctrl-C` to kill the container
1) Disable Key Expiry for `vps-tunnel` machine
    * Via the [docs](https://tailscale.com/kb/1028/key-expiry/#disabling-key-expiry)
1) Deploy the Stack
    * Deploy via `docker-compose up -d`
    * Check the stack's health via `docker-compose ps`
      * All 3 containers should eventually have `State` = `Up`


### Configure NPM Admin

* Ensure you have a [Tailscale client](https://tailscale.com/download) running on your local machine
* Copy the value of your `Tailnet name` from [here](https://login.tailscale.com/admin/dns)
* Open the Nginx Proxy Manager admin gui via [`http://vps-tunnel.__TAILNET_NAME__:81`](http://vps-tunnel.__TAILNET_NAME__:81)
* Login to the gui with the below and reset your password:
  ```yml
  Email:    admin@example.com
  Password: changeme
  ```
  ☝️ Very important -- don't skip that step ⚠️
