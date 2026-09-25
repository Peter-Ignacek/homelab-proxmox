# Stirling PDF

## Purpose

Stirling PDF is a self-hosted document-processing service for common PDF operations such as merging, splitting, conversion, compression, and metadata or page manipulation.

## Deployment

| Item | Value |
|---|---|
| Host | PVE-DE |
| Deployment type | Dedicated Proxmox LXC container |
| Guest OS | Linux guest; distribution details are intentionally not published |
| Access | Internal service published through the homelab reverse-proxy layer |

The public documentation omits the guest ID, resource sizing, host addresses, private domains, and credentials.

## Access architecture

The service is reached through the existing reverse-proxy layer. The proxy provides the controlled HTTPS entry point, while the LXC remains on the trusted homelab network and is not intended to be directly exposed.

## Backup and data protection

The intended backup path is the PVE-DE Proxmox backup workflow and remote PBS target; verify guest inclusion in the active job after deployment. Processing workspaces and any retained files should be reviewed separately from the container backup so temporary data does not become an accidental long-term archive.

## Security considerations

- Treat uploaded PDFs as untrusted input and keep the service behind authenticated access.
- Do not expose the application port directly to the Internet.
- Review file-size, execution, and retention settings for the deployment.
- Keep application and operating-system updates current.
- Do not commit sample documents, secrets, private URLs, or service configuration containing credentials.

## Maintenance

Update the application and guest OS through the documented maintenance process. Before major changes, create and verify a Proxmox backup. Afterward, test representative PDF operations, reverse-proxy access, and monitoring status.

## Homelab integration

Stirling PDF complements the PVE-DE document stack alongside Paperless-ngx and shares the site's reverse-proxy, monitoring, and backup patterns. It is documented in `homelab-proxmox` rather than in a separate service repository.
