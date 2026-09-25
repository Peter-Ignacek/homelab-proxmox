# Nginx Proxy Manager

## Overview

Nginx Proxy Manager is the reverse-proxy and HTTPS entry layer for multiple self-hosted services in the homelab.

## Deployment and site placement

| Site | Deployment |
|---|---|
| PVE-DE | Proxmox LXC, CT 103 |
| PVE-PL | Independent site-local instance |

Both sites operate their own instance. The public documentation does not publish a complete hostname or domain inventory.

## Architecture

Nginx Proxy Manager provides multiple active proxy hosts, Let's Encrypt certificates, and automatic HTTPS termination. The environment includes both public services and services protected by access controls. Cloudflare is not required for this architecture.

## Security and resilience

- Keep upstream services on the homelab network and expose only the required proxy entry points.
- Use HTTPS and access controls appropriate to each service.
- Avoid publishing internal hostnames, addresses, or certificate-management secrets.
- Proxmox Backup Server protects the PVE-DE instance; the PL instance follows the corresponding site backup design.

## Maintenance

Maintain the guest OS and Nginx Proxy Manager through the normal update process. After changes, verify representative proxy hosts, certificate status, HTTPS termination, and access-controlled services.

## Homelab integration

Nginx Proxy Manager is shared infrastructure for services such as Paperless-ngx and other self-hosted applications at both sites. It is documented in `homelab-proxmox` rather than in a separate repository.
