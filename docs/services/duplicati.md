# Duplicati

## Overview

Duplicati is the application and data-backup layer on PVE-DE, complementing Proxmox-level guest backups.

## Deployment

| Item | Value |
|---|---|
| Site | PVE-DE |
| Deployment | Proxmox LXC, CT 105 |
| Backup protection | Encrypted backups to multiple destinations |

## Backup architecture

Paperless-ngx data is backed up to:

- local storage on PVE-DE;
- UGREEN storage at the PL site via SFTP;
- Hetzner remote storage via SFTP.

The design provides local, second-site, and remote backup coverage. Duplicati is used in addition to Proxmox Backup Server rather than as a replacement for guest-level backups.

## Security and resilience

- Backups are encrypted.
- Keep backup passwords, passphrases, destination credentials, and exported configuration outside Git.
- Protect the backup administration interface and limit access to trusted management paths.
- Test restoration of representative application data as part of recovery maintenance.

## Maintenance

Maintain the guest OS and Duplicati through the normal update process. After upgrades, verify backup execution and perform read-only checks of the configured destinations. Exact schedules and retention policies are intentionally omitted because they were not verified for this public document.

## Homelab integration

Duplicati protects application data such as Paperless-ngx, while Proxmox Backup Server protects selected VMs and LXCs. Together they provide layered backup coverage across local, second-site, and remote storage.
