# Route Internet -> VPS -> Tailscale

Open an SSH Tunnel on your **local** machine

```shell
VPS_SSH_NAME='vps'
ssh -L 8181:localhost:81 "$VPS_SSH_NAME"
```

---

Now you can access the admin gui via [`http://localhost:8181`](http://localhost:8181)

Login to the gui with the below and reset your password:
```yml
Email:    admin@example.com
Password: changeme
```

☝️ Very important -- don't skip that step ⚠️

---
