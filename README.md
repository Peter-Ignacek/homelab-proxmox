# homelab-proxmox

Documentation and inventory for the two-site Proxmox homelab.

## Sites

| Site | Host role | Hardware | Main IP | Proxmox | Notes |
|---|---|---|---|---|---|
| `de` | PVE-DE | Intel NUC10i7FNH, i7-10710U, 16 GB RAM | 192.168.178.71 | 9.2.3 / pve-manager 9.2.3 | Home Assistant, Paperless, AdGuard, NPM, Invoice Ninja, Stirling PDF, DocuSeal, Duplicati, PBS-DE |
| `pl` | PVE-PL | GEEKOM GT1 Mega, Core Ultra 7 155H, 32 GB RAM | 192.168.1.250 | 8.4.0 / pve-manager 8.4.19 | Home Assistant, Plex stack, PBS-PL, NetBox, Clawbot |

## Network overview

- PVE-DE LAN: `192.168.178.0/24`
- PVE-PL LAN: `192.168.1.0/24`
- WireGuard site-to-site network: `10.50.50.0/24`
- PVE-PL WireGuard endpoint: `10.50.50.1/24`
- PVE-DE WireGuard endpoint: `10.50.50.2/24`

## Repository purpose

This repo is intended as clean source material for Codex and future automation work. It documents:

- Proxmox hosts and hardware
- VM and LXC inventory
- Storage layout
- Network bridges and VPN
- Backup strategy
- Known issues and cleanup tasks
- Installed helper-script origins

## PVE-DE service inventory

- [Invoice Ninja](docs/services/invoice-ninja.md) — self-hosted invoicing and business administration.
- [Stirling PDF](docs/services/stirling-pdf.md) — self-hosted PDF processing.
- [DocuSeal](docs/services/docuseal.md) — self-hosted document signing.
- [Paperless-ngx](docs/services/paperless-ngx.md) — self-hosted document management.
- [Nginx Proxy Manager](docs/services/nginx-proxy-manager.md) — reverse proxy and HTTPS entry layer.
- [AdGuard Home](docs/services/adguard-home.md) — site-local DNS filtering.
- [Duplicati](docs/services/duplicati.md) — encrypted multi-destination application/data backups.
- [Proxmox Backup Server](docs/services/proxmox-backup-server.md) — daily selected VM/LXC backups across the two sites.


## Recent cleanup notes

- PVE-DE Hermes Agent VM 501 was installed and documented. See [docs/hermes-agent-pve-de.md](docs/hermes-agent-pve-de.md).
- PVE-DE was upgraded from Proxmox VE 8.4.19 to 9.2.3 on 2026-06-09. See [docs/upgrades/pve-de-pve9-upgrade-2026-06-09.md](docs/upgrades/pve-de-pve9-upgrade-2026-06-09.md).
- PVE-PL was upgraded to Proxmox VE 9.2.3 on 2026-06-09. See [docs/upgrades/pve-pl-pve9-upgrade-2026-06-09.md](docs/upgrades/pve-pl-pve9-upgrade-2026-06-09.md).
- APT/no-subscription repository cleanup completed on both Proxmox nodes.
- PVE-DE Hetzner Storage Box mount was migrated from a failed `/etc/fstab` mount to `systemd automount`. See [`docs/hetzner-storagebox-automount.md`](docs/hetzner-storagebox-automount.md).
- PVE-PL LXC disk usage was checked; running containers are not critically full.
- PVE-PL OpenClaw / Clawbot VM was documented. See [`docs/openclaw-clawbot.md`](docs/openclaw-clawbot.md).
- Three additional PVE-DE services were documented: [Invoice Ninja](docs/services/invoice-ninja.md), [Stirling PDF](docs/services/stirling-pdf.md), and [DocuSeal](docs/services/docuseal.md).
- NAS Plex share is at about 91% usage and requires manual media cleanup.

## Security note

Do not commit raw credentials, private keys, backup tokens, WireGuard private keys, API tokens, SSH private keys, or unredacted secret files. See [`SECURITY.md`](SECURITY.md).
