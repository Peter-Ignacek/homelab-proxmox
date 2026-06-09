# PVE-DE Upgrade Report - Proxmox VE 8 to 9

Date: 2026-06-09

Host: PVE-DE

Scope: Proxmox VE host upgrade and post-upgrade validation. Documentation only.

## Result

PVE-DE was upgraded from Proxmox VE 8.4.19 to Proxmox VE 9.2.3.

The host is now running kernel 7.0.6-2-pve on Debian trixie.

## Final State

| Area | Verified result |
|---|---|
| Proxmox version | pve-manager/9.2.3/d0fde103346cf89a |
| Meta package | proxmox-ve 9.2.0 |
| Running kernel | 7.0.6-2-pve |
| Debian base | trixie |
| APT status | All packages are up to date |
| Failed services | 0 loaded units listed |
| Storage active | local, local-lvm, hdd-pbs-de, pbs-pl |
| WireGuard | wg0 active; remote pings verified during post-upgrade check |
| Guests | VM 100, VM 901, CT 101-108 running |
| Earlier nmbd issue | Resolved after reboot; nmbd active/running |

## Repository State

The host uses the Proxmox VE no-subscription repository in deb822 format:

```text
# /etc/apt/sources.list.d/proxmox.sources
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
```

The enterprise repository is disabled because this homelab host has no paid Proxmox subscription. Any old enterprise source such as `pve-enterprise.list` or `pve-enterprise.sources` should remain disabled for this no-subscription setup.

## Validation Summary

- `apt update`: all packages up to date
- `systemctl --failed`: 0 failed units
- `pve-manager`: 9.2.3
- `proxmox-ve`: 9.2.0
- running kernel: 7.0.6-2-pve
- storage active: local, local-lvm, hdd-pbs-de, pbs-pl
- guests running: VM 100, VM 901, CT 101-108
- nmbd failure during upgrade resolved after reboot

## Guest Inventory

| ID | Type | Name | Final state |
|---:|---|---|---|
| 100 | VM | haos12.4 | running |
| 901 | VM | pbs-de | running |
| 101 | CT | adguard | running |
| 102 | CT | uptimekuma | running |
| 103 | CT | nginxproxymanager | running |
| 104 | CT | paperless-ngx | running |
| 105 | CT | Duplicati | running |
| 106 | CT | filebrowser | running |
| 107 | CT | backrest | running |
| 108 | CT | devops-lab-de | running |

## Verified Mounts

| Scope | Path / mapping | Status |
|---|---|---|
| Host | /mnt/hetzner via sshfs automount | active |
| Host | /mnt/ugreen via CIFS automount | active |
| Host | /mnt/duplicati-local | active |
| Host | /mnt/pve/hdd-pbs-de | active |
| CT104 paperless | host /mnt/duplicati-local/paperless-staging -> CT /mnt/staging | OK |
| CT105 Duplicati | host /mnt/ugreen -> CT /mnt/ugreen | OK |
| CT105 Duplicati | host /mnt/duplicati-local -> CT /mnt/local-backup | OK |
| CT106 filebrowser | host /mnt/duplicati-local/share -> CT /srv/files | OK |
| CT106 filebrowser | host /mnt/hetzner -> CT /mnt/hetzner | OK |
| CT106 filebrowser | host /mnt/ugreen -> CT /mnt/ugreen | OK |

## Rollback And Cleanup Notes

Do not run `apt autoremove` immediately after the upgrade. Keep old 6.8 kernels for a few days as a rollback fallback. After a stable period, perform a cautious kernel/package cleanup.

## Source Note

Repository naming and support level should follow the official Proxmox VE package repository documentation. The no-subscription repository does not require a subscription key, while the enterprise repository requires a valid subscription.
