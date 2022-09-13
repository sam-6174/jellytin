### Configure

* Copy the variables template via `cp ./template.env ./.env`
* Set the `CLOUDFLARED_TAG` within `./.env`, based on your arch

---

### Authorize Tunnel for Cloudflare Domain

* Execute `docker-compose run --rm cloudflared tunnel login`
* Copy the URL from the above command's output
* Paste the URL into your web browser
* Authorize the tunnel for `__MY_SITE__.__COM__`

---

### Create the Tunnel

* Execute `docker-compose run --rm cloudflared tunnel create __MY_SITE__`
* Copy the tunnel's UUID from the above command's output
  * Alternatively, get the UUID via `docker-compose run --rm cloudflared tunnel list`
* Execute the following to create your `config.yaml`:
  ```shell
  TUNNEL_UUID='<PASTE FROM ABOVE>'
  DOMAIN='__MY_SITE__.__COM__'

  sudo tee ./mounts/cloudflared/config.yaml <<EOF >/dev/null
  tunnel: $TUNNEL_UUID
  ingress:
    - hostname: '$DOMAIN'
      service: http://nginx_proxy_manager:80
    - hostname: '*.$DOMAIN'
      service: http://nginx_proxy_manager:80
    - service: http_status:404
  EOF
  ```
  * Validate the above config via `docker-compose run --rm cloudflared tunnel ingress validate`
* Configure Cloudflare DNS -> Tunnel via:
  * `docker-compose run --rm cloudflared tunnel route dns '__MY_SITE__' '__MY_SITE__.__COM__'`

---

### Deploy

`docker-compose up -d`

---

### Test the Tunnel

(note that the above DNS settings make take a second to propagate)

* Open [`https://__MY_SITE__.__COM__`](https://__MY_SITE__.__COM__) in your web browser
* You should see a page that says:

```
Congratulations!
You've successfully started the Nginx Proxy Manager.
If you're seeing this site then you're trying to access a host that isn't set up yet.
Log in to the Admin panel to get started.
```
