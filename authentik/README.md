# Deploy Authentik


The contents in this directory have been modified from the Authentik [docs](https://goauthentik.io/docs/installation/docker-compose/).

* Copy the variables template via `cp ./template.env ./.env`
* Set the `SECRET` values within `./.env`, as described by the above docs
* Deploy via `docker-compose up -d`

---

Login to the gui via below and set the admin password:
> [`http://__HOST_IP__:9000/if/flow/initial-setup/`](http://__HOST_IP__:9000/if/flow/initial-setup/)

☝️ Very important -- don't skip that step ⚠️

---

* Open the admin dashboard gui, and go to `Flows & Stages` > `Stages`.
* Click the 📝 icon to update `default-authentication-identification`
* Set `Password stage` = `default-authentication-password`

---

After deploying, you can access the gui via [`http://__HOST_IP__:9000`](http://__HOST_IP__:9000)
