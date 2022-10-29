# Deploy Tailscale + NPM

Prerequisites:

  * Install [docker-compose](../docker_install.sh) on your VPS
  * [Register](https://login.tailscale.com/start) for a Tailscale Account


Execute the below on your VPS:

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
1) Deploy the Stack
    * Deploy via `docker-compose up -d`
    * Check the stack's health via `docker-compose ps`
      * All 3 containers should eventually have `State` = `Up`
