This was modified from the NPM [docs](https://nginxproxymanager.com/setup/#running-the-app)

* Copy the variables template via `cp ./template.env ./.env`
* Open `./.env` and set the SECRET values
* Deploy via `docker-compose up -d`

After deploying, you can access the admin gui via [`http://__HOST_IP__:81`](http://__HOST_IP__:81)

---

Login to the gui with the below and reset your password:
```yml
Email:    admin@example.com
Password: changeme
```

☝️ Very important -- don't skip that step ⚠️
