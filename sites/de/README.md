# PVE-DE

German Proxmox site.

## Host

- Hostname: `pve`
- Hardware: Intel NUC10i7FNH
- CPU: Intel Core i7-10710U, 6 cores / 12 threads
- RAM: 16 GB
- OS: Debian trixie
- Proxmox VE: 9.2.3
- pve-manager: 9.2.3
- Kernel: 7.0.6-2-pve
- Main LAN IP: `192.168.178.71/24`
- Default gateway: `192.168.178.1`
- WireGuard: `10.50.50.2/24`

## Main purpose

- Home Assistant OS
- DNS filtering via AdGuard
- Reverse proxy via Nginx Proxy Manager
- Paperless-ngx document management
- Duplicati / Backrest / Filebrowser backup tooling
- PBS-DE VM
- DevOps lab LXC

## Upgrade reports

- [PVE-DE Upgrade Report - Proxmox VE 8 to 9](../../docs/upgrades/pve-de-pve9-upgrade-2026-06-09.md)
