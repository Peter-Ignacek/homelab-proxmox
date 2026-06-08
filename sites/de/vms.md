# PVE-DE VMs

| VMID | Name | State in report | vCPU | RAM | Disk | Bridge | On boot | Purpose |
|---:|---|---|---:|---:|---|---|---|---|
| 100 | `haos12.4` | running | 3 | 4096 MB | 32 GB | `vmbr1` | yes | Home Assistant OS |
| 901 | `pbs-de` | running | 2 | 2048 MB | 32 GB + 500 GB | `vmbr0` | yes | Proxmox Backup Server DE |

Notes:

- VM 100 was created with a Proxmox Helper Script / tteck Home Assistant OS helper.
- VM 901 has an additional 500 GB disk stored on `hdd-pbs-de`.
