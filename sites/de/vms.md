# PVE-DE VMs

| VMID | Name | State | vCPU | RAM | Disk | Bridge | On boot | Purpose | Notes |
|---:|---|---|---:|---:|---|---|---|---|---|
| 100 | `haos12.4` | running | 3 | 4096 MB | 32 GB | `vmbr1` | yes | Home Assistant OS | Created with Proxmox Helper Script / tteck Home Assistant OS helper |
| 501 | `hermes` | running | TBD | TBD | TBD | TBD | yes | Hermes Agent VM | Debian 13 Trixie, Hermes Agent v0.16.0, Telegram gateway active |
| 901 | `pbs-de` | running | 2 | 2048 MB | 32 GB + 500 GB | `vmbr0` | yes | Proxmox Backup Server DE | Additional 500 GB disk stored on `hdd-pbs-de` |

Notes:

- VM 501 `hermes` is documented in [`../../docs/hermes-agent-pve-de.md`](../../docs/hermes-agent-pve-de.md).
- VM 901 has an additional 500 GB disk stored on `hdd-pbs-de`.
