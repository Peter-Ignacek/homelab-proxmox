# AdGuard Home

## Overview

AdGuard Home provides site-local DNS filtering and ad-blocking for the two-site homelab. It is established infrastructure at both locations rather than a temporary test deployment.

## Deployment and site placement

| Site | Deployment |
|---|---|
| PVE-DE | Proxmox LXC, CT 101 |
| PVE-PL | Independent site-local instance |

Each installation uses three filter lists. Upstream DNS providers and synchronization mechanisms are intentionally not documented because they have not been verified here.

## Architecture

The DE and PL installations provide local DNS filtering for their respective sites. This keeps filtering close to clients and avoids making either site dependent on the other for basic DNS service.

## Security and maintenance

- Restrict administrative access to trusted management paths.
- Do not expose the administration interface publicly.
- Keep filter lists and the application updated through the normal maintenance process.
- Verify DNS resolution and filtering after updates or configuration changes.

## Homelab integration

AdGuard Home is site infrastructure for the PVE-DE and PVE-PL networks and operates alongside the reverse-proxy, monitoring, and backup services.
