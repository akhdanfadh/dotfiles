# dotfiles

This repo contains the configuration to setup my machines.
It is using [chezmoi](https://www.chezmoi.io/), dotfile manager to automate the setup.
This automated setup is currently only configured for Ubuntu (server or desktop) and MacOS machines.

## Installation

```bash
export GITHUB_USERNAME=akhdanfadh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

## References

- Chezmoi's creator dotfiles, heavy with scripts: [twpayne](https://github.com/twpayne/dotfiles) 
- Reliance on Ansible playbook: [logandonley](https://github.com/logandonley/dotfiles) 
