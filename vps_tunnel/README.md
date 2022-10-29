# VPS Tunnel

Since Cloudflare Tunnel is limited to html traffic, we will host our own tunnel.

This means that you must rent a VPS.

[BuyKVM](https://buyvm.net/kvm-dedicated-server-slices/) is only $2/month, but any VPS with an IPv4 address will do.

The rest of this readme assumes that you have a VPS running a flavor of Debian.


### Harden VPS

* Harden according to [`./vps_harden.md`](./vps_harden.md)


### Deploy Tailscale + NPM

* Deploy via [`./vps_deploy.md`](./vps_deploy.md)


### Configure VPS Routing

* Configure via [`./vps_routing.md`](./vps_routing.md)
