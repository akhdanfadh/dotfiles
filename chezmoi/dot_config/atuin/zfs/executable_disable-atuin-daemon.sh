#!/bin/bash
# Reverts the Atuin systemd user service setup

systemctl --user stop atuin.service
systemctl --user disable atuin.service
rm ~/.config/systemd/user/atuin.service
systemctl --user daemon-reload
