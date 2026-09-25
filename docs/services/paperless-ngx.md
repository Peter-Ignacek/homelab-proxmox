# Paperless-ngx

## Overview

Paperless-ngx is the production document-management service on PVE-DE. It currently stores approximately 1,263 documents, 36 tags, and 26 document types.

## Deployment

| Item | Value |
|---|---|
| Site | PVE-DE |
| Deployment | Proxmox LXC, CT 104 |
| Guest OS | Debian GNU/Linux 13 |
| Installation | Community Scripts for Proxmox VE |

## Architecture and access

Paperless-ngx is reached through Nginx Proxy Manager using HTTPS with Let's Encrypt certificates. The public documentation intentionally omits private hostnames, addresses, and application credentials.

## Backup and resilience

Paperless data is protected at both the infrastructure and application/data-backup layers:

- Proxmox Backup Server protects the LXC guest.
- Duplicati creates encrypted backups of Paperless data.
- Duplicati destinations include local SSD storage, UGREEN storage at the PL site via SFTP, and Hetzner remote storage via SFTP.

This provides local, second-site, and remote backup coverage. Recovery procedures should validate both the guest and the application data.

## Security and maintenance

- Keep access behind the reverse-proxy and HTTPS layer.
- Do not publish application secrets, private URLs, or exported configuration.
- Apply guest and application updates through the normal maintenance process.
- Verify access and document availability after updates and backup restores.

## Homelab integration

Paperless-ngx is part of the PVE-DE document stack and integrates with Nginx Proxy Manager, Proxmox Backup Server, and Duplicati.
