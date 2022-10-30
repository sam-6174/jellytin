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
    * Via the [docs](https://web.archive.org/web/20221019082019/https://tailscale.com/kb/1028/key-expiry/#disabling-key-expiry)
1) Deploy the Stack
    * Deploy via `docker-compose up -d`
