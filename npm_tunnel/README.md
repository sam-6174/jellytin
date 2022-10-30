1) Config `./.env`
    * Copy the variables template via `cp ./template.env ./.env`
1) Authenticate Tailscale Container
    * Execute `docker-compose run --rm npm-tailscale`
    * Copy the URL from the above command's output
    * Paste the URL into your web browser
    * Authorize the container
    * The container's output should update with an eventual `health("overall"): ok`
    * `Ctrl-C` to kill the container
1) Disable Key Expiry for `nginx-proxy-manager` machine
    * Via the [docs](https://tailscale.com/kb/1028/key-expiry/#disabling-key-expiry)
1) Deploy the Stack
    * Deploy via `docker-compose up -d`
1) Confirm Tailscale NPM access
    * Ensure you have a [Tailscale client](https://tailscale.com/download) running on your local machine
    * Copy the value of your `Tailnet name` from [here](https://login.tailscale.com/admin/dns)
    * Open the Nginx Proxy Manager admin gui via [`http://nginx-proxy-manager.__TAILNET_NAME__:81`](http://nginx-proxy-manager.__TAILNET_NAME__:81)
