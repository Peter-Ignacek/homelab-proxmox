# PVE-PL VMs

| VMID | Name | State in report | vCPU | RAM | Disk | Bridge | On boot | Purpose |
|---:|---|---|---:|---:|---|---|---|---|
| 100 | `haos14.1` | running | 6 | 6144 MB | 32 GB | `vmbr1` | yes | Home Assistant OS |
| 102 | `Winda` | stopped | 8 | 8192 MB | 77 GB | `vmbr1` | no/unspecified | Windows 11 VM |
| 500 | `clawbot` | running | 2 | 2048 MB | 32 GB | `vmbr0` | yes | Debian / Clawbot |
| 900 | `pbs-pl` | running | 2 | 4096 MB | 500 GB | `vmbr0` | yes | Proxmox Backup Server PL |
