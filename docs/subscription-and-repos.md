# Proxmox subscription and repositories

Both nodes use the Proxmox no-subscription repository. Enterprise repositories are disabled/commented out because no paid Proxmox subscription is used.

## PVE-DE after Proxmox VE 9 upgrade

PVE-DE was upgraded to Proxmox VE 9.2.3 on 2026-06-09. The host now uses the Proxmox VE 9 no-subscription repository in deb822 format:

```text
# /etc/apt/sources.list.d/proxmox.sources
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
```

The enterprise repository is disabled for this no-subscription homelab setup. Any old enterprise source such as `pve-enterprise.list` or `pve-enterprise.sources` should remain disabled.

`apt update` completed without 401 Unauthorized and reported all packages up to date after the cleanup.

## PVE-PL state after 2026-06-08 cleanup

PVE-PL was cleaned up on 2026-06-08. The Proxmox repository line no longer contains the invalid Debian component `non-free`.

Clean Proxmox VE repository line:

```text
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
```

Enterprise repository remains disabled/commented:

```text
# deb https://enterprise.proxmox.com/debian/pve bookworm pve-enterprise
```

Ceph no-subscription repository is configured:

```text
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
```

Debian Bookworm repository components were also cleaned up to include `non-free-firmware`:

```text
contrib non-free non-free-firmware main
```

`apt update` completed cleanly after the change.

## Helper scripts

The machines contain workloads created with older `tteck/Proxmox` helper scripts and newer `community-scripts/ProxmoxVE` helper scripts.

Detected origins include:

- Home Assistant OS helper script
- AdGuard LXC helper script
- Plex LXC helper script
- Uptime Kuma LXC helper script
- Nginx Proxy Manager LXC helper script
- Paperless-ngx LXC helper script
- Filebrowser LXC helper script
- Backrest LXC helper script
- NetBox LXC helper script
- Rclone / Tautulli / Overseerr helper scripts
