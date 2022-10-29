# Deploy Tailscale + NPM

Execute the below on your VPS

1) Config `./.env` Secrets
    * Copy the variables template via `cp ./template.env ./.env`
    * Open `./.env` and set the SECRET values
1) Authenticate Tailscale Container
    * Execute `docker-compose run --rm tailscale tailscale up`
    * Copy the URL from the above command's output
    * Paste the URL into your web browser
    * Authorize the container
1) Deploy the Stack
    * Deploy via `docker-compose up -d`
