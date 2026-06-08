# Proxmox subscription and repositories

Both nodes use the Proxmox no-subscription repository. Enterprise repositories are present but commented out.

## Current state after cleanup

Both nodes were cleaned up on 2026-06-08. The Proxmox repository line no longer contains the invalid Debian component `non-free`.

Clean Proxmox VE repository line on both nodes:

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

`apt update` completed cleanly on both nodes after the change.

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
