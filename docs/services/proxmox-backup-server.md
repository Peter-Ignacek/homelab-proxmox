# Proxmox Backup Server

## Overview

Proxmox Backup Server provides guest-level backup storage and recovery support for the two-site Proxmox homelab.

## Site placement

| Site | Service |
|---|---|
| Germany | PBS-DE |
| Poland | PBS-PL |

Both sites run an active PBS service and back up selected Proxmox guests rather than blindly backing up every VM and LXC.

## Backup architecture

- Backups run daily.
- The PVE-DE job runs around 03:00 and targets PBS-PL.
- The PVE-PL job runs around 02:30 using its configured PBS storage.
- The design provides cross-site backup resilience between Germany and Poland.
- The documented retention policy includes `keep-daily=7`, `keep-weekly=4`, and `keep-monthly=1`.

Exact verification jobs, datastore internals, and detailed PBS VM architecture are intentionally omitted because they are not verified in the public documentation.

## Security and maintenance

- Keep PBS administration and backup credentials private.
- Restrict access to trusted management paths.
- Monitor backup freshness and available storage.
- Test representative restores periodically and document recovery results without publishing sensitive configuration.
- Apply Proxmox Backup Server and guest updates through the normal maintenance process.

## Homelab integration

PBS provides the infrastructure-level backup layer for selected VMs and LXCs. It complements Duplicati, which handles encrypted application/data backups such as Paperless-ngx.
