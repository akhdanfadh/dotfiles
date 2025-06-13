# Dotfiles & Bootstrapping

Quick configuration for my dev setup, which is usually a Proxmox Ubuntu LXC.

THIS REPO IS WORK IN PROGRESS! It was only chezmoi files in the chezmoi directory, but now I want to use ansible instead for scripting and chezmoi specifically for dotfiles.

## Quick Start

```bash
sudo apt update && sudo apt install -y ansible git

cd $HOME
git clone https://github.com/akhdanfadh/mini-dotfiles.git .dotfiles
cd .dotfiles
```

### Proxmox Specific

Typically, a new Proxmox LXC is on root user. This creates one with sudo access and switch to it. To change password, use `passwd $USERNAME`. Before doing this, do `USERNAME="yourusername"` first.

```bash
adduser $USERNAME
usermod -aG sudo $USERNAME
su - $USERNAME
```

### SSH Public Key

Don't forget to copy your **local** public key to the remote machine. Before doing this, do `PUBKEY="put_your_public_key_here"` first.

```bash
mkdir -p $HOME/.ssh
touch $HOME/.ssh/authorized_keys
echo "$PUBKEY" >> $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys
```
