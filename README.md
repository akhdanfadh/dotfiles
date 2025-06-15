# dotfiles

This repo contains the configuration to setup my machines with [Ansible](https://www.ansible.com/) (automation platform) and [chezmoi](https://www.chezmoi.io/) (dotfile manager). Only supports Ubuntu and MacOS machines for now.

> [!WARNING]
> Work in progress! Not yet ready for public consumption, use for reference.

I built this initially with just chezmoi to set up my Ubuntu desktop and Macbook, but turns out I use this more than I thought for my Proxmox children (web servers, dev environments, etc.). Thing is [chezmoi scripting break its declarative appraoch](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/). So for better automation and [idempotency](https://en.wikipedia.org/wiki/Idempotence?useskin=vector), I use Ansible for the system setup and chezmoi specifically for dotfiles.

## Quick Start

> [!IMPORTANT]
> If you haven't already, **copy your SSH public key to the target machine** since the playbook will [hardened](<https://en.wikipedia.org/wiki/Hardening_(computing)?useskin=vector>) the remote machine. See [Common Cases](#ssh-public-key) section below.

The headless non-minimal setup currently requires at least 4GB available disk space.
Do the following on the **target machine**. Then, check `config.yaml` file. If LGTY, run `ansible-playbook ansible/main.yaml --ask-become-pass`.

```bash
sudo apt update && sudo apt install -y ansible git

mkdir -p "$HOME/.local/share" && cd "$_"
git clone https://github.com/akhdanfadh/dotfiles.git chezmoi
cd chezmoi
```

On MacOS,

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install ansible git

mkdir -p "$HOME/.local/share" && cd "$_"
git clone https://github.com/akhdanfadh/dotfiles.git chezmoi
cd chezmoi
```

## Common Cases

### Non-Root User

Typically, a new Proxmox LXC is on root user. The following creates one with sudo access and switch to it. Before doing this, do `USERNAME="yourusername"` first. To change password, use `passwd $USERNAME`.

```bash
adduser $USERNAME
usermod -aG sudo $USERNAME
su - $USERNAME
```

### SSH Public Key

Don't forget to copy your local public key to the remote machine. Before doing this, do `PUBKEY="put_your_public_key_here"` first.

```bash
mkdir -p $HOME/.ssh
touch $HOME/.ssh/authorized_keys
echo "$PUBKEY" >> $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys
```
