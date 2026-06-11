# Security notes

This repository should contain documentation only.

Do not commit:

- `/etc/pve/priv/*`
- SSH private keys
- WireGuard private keys or full peer configs
- Proxmox Backup Server tokens or passwords
- Duplicati passwords / passphrases
- NPM Cloudflare or DNS API tokens
- Paperless secret keys or <ADMIN_WIZARD> passwords
- Filebrowser or Backrest credentials
- NAS credentials or CIFS credential files
- Full SMART serial numbers if the repo is public
- 1Password credentials, service account tokens, or `op` tokens
- Telegram Bot tokens
- Anthropic API keys
- OpenClaw gateway password files, including `~/.openclaw/gateway-password`

Internal IP addresses are included because they are useful for homelab documentation. If this repo is made public, consider replacing private IPs with placeholders.
