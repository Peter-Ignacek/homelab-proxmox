# PVE-PL VMs

| VMID | Name | State after upgrade | vCPU | RAM | Disk | Bridge | On boot | Purpose | Notes |
|---:|---|---|---:|---:|---|---|---|---|---|
| 100 | `haos14.1` | running | 6 | 6144 MB | 32 GB | `vmbr1` | yes | Home Assistant OS | EFI Linux |
| 102 | `Winda` | stopped | 8 | 8192 MB | 77 GB | `vmbr1` | no | Windows 11 VM | Do not enroll EFI 2023 certs until BitLocker is checked |
| 500 | `clawbot` | running | 2 | 2048 MB | 32 GB | `vmbr0` | yes | Debian 13 / OpenClaw private AI agent | OK |
| 900 | `pbs-pl` | running | 2 | 4096 MB | 500 GB | `vmbr0` | yes | Proxmox Backup Server PL | EFI ms-cert=2023k fixed after upgrade |

Notes:

- VM 500 `clawbot` runs OpenClaw Gateway on port `18789` and is documented in [`../../docs/openclaw-clawbot.md`](../../docs/openclaw-clawbot.md).
- VM 900 `pbs-pl` was intentionally not backed up to the same PBS storage before the upgrade to avoid backing up PBS into itself.
- VM 102 `Winda` remains stopped with `onboot=0`; check BitLocker before any EFI certificate change.
