# Deploy Tailscale


1) Config `./.env`
    * Copy the variables template via `cp ./template.env ./.env`
1) Authenticate Tailscale Container
    * Execute `docker-compose run --rm tailscale /bin/sh /tailscale/run.sh`
    * Copy the URL from the above command's output
    * Paste the URL into your web browser
    * Authorize the container
    * The container's output should update with an eventual `health("overall"): ok`
    * `Ctrl-C` to kill the container
1) Disable Key Expiry for `npm-tunnel` machine
    * Via the [docs](https://tailscale.com/kb/1028/key-expiry/#disabling-key-expiry)
1) Deploy the Stack
    * Deploy via `docker-compose up -d`
    * Check tailscale status:
      ```shell
      docker exec -it $(docker container ls | grep tailscale | awk '{print $1}') tailscale status
      ```
