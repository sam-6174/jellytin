# Route 👤 -> `VPS` -> `Nginx` -> `Tailscale` -> `Nginx`


### Configure Tailscale

* Config Tailscale ACL [here](https://login.tailscale.com/admin/acls)
* Replace `__YOUR_EMAIL__` in the below Access Control config
  ```json
  {
    "groups": {
      "group:tailscale-admin": ["__YOUR_EMAIL__"],
    },
    "tagOwners": {
      "tag:vps-tunnel": ["group:tailscale-admin"],
      "tag:npm-tunnel": ["group:tailscale-admin"],
    },
    "acls": [
      {
        "action": "accept",
        "src": ["group:tailscale-admin"],
        "dst": ["*:*"],
      },
      {
        "action": "accept",
        "src": ["tag:vps-tunnel"],
        "dst": ["tag:npm-tunnel:80"],
      },
    ],
    "tests": [
      { // Accept admin
        "src":    "group:tailscale-admin",
        "accept": ["tag:npm-tunnel:123"],
      },
      { // Accept admin
        "src":    "group:tailscale-admin",
        "accept": ["tag:vps-tunnel:456"],
      },
      { // Accept VPS Tunnel -> NPM Tunnel
        "src":    "tag:vps-tunnel",
        "accept": ["tag:npm-tunnel:80"],
      },
      { // Deny NPM Tunnel -> VPS Tunnel
        "src":  "tag:npm-tunnel",
        "deny": ["tag:vps-tunnel:80"],
      },
    ],
  }
  ```


### Configure `Nginx` -> `Tailscale` -> `Nginx`

* TODO


### Expose VPS to Internet

* TODO


### Configure Cloudflare DNS -> `VPS`

* TODO
