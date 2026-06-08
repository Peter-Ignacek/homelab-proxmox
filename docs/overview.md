# Overview

The homelab consists of two independent single-node Proxmox VE installations connected by WireGuard:

- `PVE-DE`: German site, Intel NUC based, LAN `192.168.178.0/24`.
- `PVE-PL`: Polish site, GEEKOM GT1 Mega based, LAN `192.168.1.0/24`.

Both nodes are standalone Proxmox nodes, not members of a Proxmox cluster. Both are running Proxmox VE 8.4 on Debian 12 Bookworm with the no-subscription repository enabled.

Main workloads:

- Home Assistant OS on both sites.
- Proxmox Backup Server VMs on both sites.
- Reverse proxy via Nginx Proxy Manager.
- Monitoring via Uptime Kuma.
- Backup tooling via Duplicati / Backrest / PBS.
- Media stack on PL: Plex, Tautulli, Overseerr, rclone.
- Document stack on DE: Paperless-ngx, Filebrowser, Duplicati.
- Lab/dev services: devops-lab-de, OpenClaw / Clawbot, NetBox.
