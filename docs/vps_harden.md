# Harden Your VPS

Unless otherwise noted, all commands are to be run on your VPS.

Your VPS provider should have given you credentials to SSH to your VPS, for example:

```shell
ssh "root@$VPS_IP"
# <enter password when prompted>
```


### Create Non-Root User

```shell
YOUR_USER='<your-new-username>'
useradd -m -s /bin/bash "$YOUR_USER"   # create user
passwd "$YOUR_USER"                    # set password
usermod -aG sudo "$YOUR_USER"          # add to sudo
id "$YOUR_USER"                        # should show sudo membership
which sudo || apt install sudo         # ensure sudo package install
su "$YOUR_USER"                        # use this user going forward
```


### Configure User SSH Key

Run these commands on your local machine

```shell
KEY_NAME='<your-key-name>'
VPS_IP='<your-vps-ip-address>'

# create your public+private key pair
ssh-keygen -t rsa -b 4096 -o -a 100 -f ~"/.ssh/$KEY_NAME"

# ensure keys are only read-writable by $USER
chmod 600 ~"/.ssh/$KEY_NAME" ~"/.ssh/$KEY_NAME.pub"

# install public key on VPS
ssh-copy-id -i ~"/.ssh/$KEY_NAME.pub" "$YOUR_USER@$VPS_IP"

# test login with private key
ssh -i ~"/.ssh/$KEY_NAME" "$YOUR_USER@$VPS_IP"
```


### Configure SSH Non-Standard Port

```shell
# get a random port
# https://unix.stackexchange.com/a/423052
SSH_RAND_PORT=`comm -23 <(seq 49152 65535 | sort) <(ss -Htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n 1`
echo "SSH_RAND_PORT = $SSH_RAND_PORT"

# update /etc/ssh/sshd_config
sudo sed -i.bak "s/^#Port 22$/Port $SSH_RAND_PORT/" /etc/ssh/sshd_config

# review changes
diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# reboot with changes
sudo systemctl restart sshd

# confirm reboot
systemctl status sshd

# from a shell on your local machine, confirm that you can connect via new port
ssh -i ~"/.ssh/$KEY_NAME" -p "$SSH_RAND_PORT" "$YOUR_USER@$VPS_IP"

# remove backup
sudo rm /etc/ssh/sshd_config.bak
```


### Configure SSH Client

Run these commands on your local machine to append to `~/.ssh/config`

```shell
VPS_SSH_NAME='vps'

cat << EOF >> ~/.ssh/config
Host $VPS_SSH_NAME
    Hostname $VPS_IP
    Port $SSH_RAND_PORT
    User $YOUR_USER
    IdentityFile ~"/.ssh/$KEY_NAME"
EOF

# test that you can SSH via config
ssh "$VPS_SSH_NAME"
```


### Limit SSH Login Methods

We are going to config the following in `/etc/ssh/sshd_config`:

```
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PermitRootLogin no
PermitRootLogin prohibit-password
```

After this, you will only be able to SSH using (1) a key and (2) a non-root user.

```shell
# update /etc/ssh/sshd_config
new_line=$'\n'
sudo sed -i.bak -r \
  -e 's/^#?ChallengeResponseAuthentication (yes|no)/ChallengeResponseAuthentication no/' \
  -e 's/^#?PasswordAuthentication (yes|no)/PasswordAuthentication no/' \
  -e 's/^#?UsePAM (yes|no)/UsePAM no/' \
  -e "s/^#?PermitRootLogin (yes|no)/PermitRootLogin no\\${new_line}PermitRootLogin prohibit-password/" \
  /etc/ssh/sshd_config

# review changes
diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# reboot with changes
sudo systemctl restart sshd

# confirm reboot
systemctl status sshd

# using your local machine, confirm that you can still connect
ssh "$VPS_SSH_NAME"

# remove backup
sudo rm /etc/ssh/sshd_config.bak
```

Run these commands on your local machine

```shell
# check that root is blocked
ssh -p "$SSH_RAND_PORT" "root@$VPS_IP"

# check that password is blocked
ssh -p "$SSH_RAND_PORT" "$YOUR_USER@$VPS_IP" -o 'PubkeyAuthentication=no'
```


### Disable SSH v1 Protocol

```shell
# backup
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# append protocol config
sudo tee -a /etc/ssh/sshd_config <<EOF >/dev/null

# Only allow SSH2
Protocol 2
EOF

# review changes
diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# reboot with changes
sudo systemctl restart sshd

# confirm reboot
systemctl status sshd

# using your local machine, confirm that you can still connect
ssh "$VPS_SSH_NAME"

# remove backup
sudo rm /etc/ssh/sshd_config.bak
```
