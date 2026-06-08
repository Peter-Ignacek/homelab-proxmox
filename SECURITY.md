# Security notes

This repository should contain documentation only.

Do not commit:

- `/etc/pve/priv/*`
- SSH private keys
- WireGuard private keys or full peer configs
- Proxmox Backup Server tokens or passwords
- Duplicati passwords / passphrases
- NPM Cloudflare or DNS API tokens
- Paperless secret keys or admin passwords
- Filebrowser or Backrest credentials
- NAS credentials or CIFS credential files
- Full SMART serial numbers if the repo is public

Internal IP addresses are included because they are useful for homelab documentation. If this repo is made public, consider replacing private IPs with placeholders.
