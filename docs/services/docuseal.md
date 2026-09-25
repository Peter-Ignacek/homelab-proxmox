# DocuSeal

## Purpose

DocuSeal is a self-hosted document-signing service for preparing signing workflows, collecting signatures, and tracking document status without sending documents to a third-party SaaS platform by default.

## Deployment

| Item | Value |
|---|---|
| Host | PVE-DE |
| Deployment type | Dedicated Proxmox LXC container |
| Guest OS | Linux guest; distribution details are intentionally not published |
| Access | Internal service published through the homelab reverse-proxy layer |

The public documentation omits the guest ID, resource sizing, host addresses, private domains, and credentials.

## Access architecture

DocuSeal is accessed through the existing reverse-proxy layer with HTTPS and authenticated access. The application guest is kept on the homelab network rather than being exposed directly.

## Backup and data protection

The intended backup path is the PVE-DE Proxmox backup workflow and remote PBS target; verify guest inclusion in the active job after deployment. Signing records, uploaded documents, and application metadata should be restored and tested together; backup restoration should be treated as a documented recovery exercise.

## Security considerations

- Keep signing workflows behind authenticated HTTPS access.
- Use least-privilege accounts and review signer and administrator roles.
- Protect uploaded documents and signing metadata as sensitive business data.
- Store mail, webhook, and application secrets outside Git.
- Review retention, auditability, and legal requirements before using the service for production agreements.

## Maintenance

Apply application and operating-system updates through the normal maintenance process. Take and verify a Proxmox backup before upgrades, then test login, document upload, signing workflow completion, and reverse-proxy access.

## Homelab integration

DocuSeal is part of the PVE-DE document and business-services layer. It shares the site's reverse-proxy, monitoring, and backup architecture and is documented in `homelab-proxmox` instead of a separate repository.
