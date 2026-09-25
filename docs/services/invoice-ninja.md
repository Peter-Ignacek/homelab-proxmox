# Invoice Ninja

## Purpose

Invoice Ninja is a self-hosted invoicing and business-administration service for managing customers, products, estimates, invoices, payments, and related business records.

## Deployment

| Item | Value |
|---|---|
| Host | PVE-DE |
| Deployment type | Dedicated Proxmox LXC container |
| Guest OS | Linux guest; distribution details are intentionally not published |
| Access | Internal service published through the homelab reverse-proxy layer |

The public documentation omits the guest ID, resource sizing, host addresses, private domains, and credentials.

## Access architecture

Users reach the service through the existing reverse-proxy layer. TLS termination, access control, and any public exposure are handled at that boundary; the container itself is not intended to be directly exposed to the Internet.

## Backup and data protection

The intended backup path is the PVE-DE Proxmox backup workflow and its remote PBS target. Confirm that the service guest and its application data are included in the active job after deployment. Application data and database consistency should be considered together during recovery planning. Do not store exported credentials, tokens, or unredacted configuration in this repository.

## Security considerations

- Keep the administrative interface behind the reverse proxy and authenticated access controls.
- Use HTTPS for browser and API access.
- Store application secrets outside Git and rotate them through the normal secret-management process.
- Restrict outbound mail and payment-related integrations to the minimum required scope.
- Review user roles, invoice data exposure, and audit requirements before enabling external access.

## Maintenance

Apply operating-system and application updates through the service's documented upgrade procedure. Take and verify a Proxmox backup before major application or database upgrades, then perform a read-only health check through the proxy and confirm that invoice data remains available.

## Homelab integration

Invoice Ninja is part of the PVE-DE business-services layer and shares the site's reverse-proxy, monitoring, and backup architecture. It is documented here rather than maintained as a separate repository.
