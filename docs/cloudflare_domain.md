# Purchase & Configure Cloudflare Domain

* Purchase your domain via [this](https://developers.cloudflare.com/registrar/get-started/register-domain)
* We'll assume that you purchase a domain of `__MY_SITE__.__COM__`
* Login to [cloudflare](https://cloudflare.com)
  * Add wildcard CNAME for subdomains
    * Go to `Websites` > `__MY_SITE__.__COM__` > `DNS` > `Add record`
      * `Type` = `CNAME`
      * `Name` = `*`
      * `Target` = `__MY_SITE__.__COM__`
      * `Proxy status` = Disabled
* Configure `<security stuff>`
  * Sorry, this isn't fully documented...
    * ... feel free to open a PR & improve this =)
  * Cloudflare will recommend multiple security settings for you, so explore around the dashboard, for example:
    * Under DNS management, it should prompt you to set various `DMARC` configs to prevent email spoofing
    * There should be a `Review Settings` button on the `Website Overview` dashboard, which points to a link like [this](https://dash.cloudflare.com/__WEBSITE_ID__/__MY_SITE__.__COM__/recommendations)
