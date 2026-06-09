# PVE-DE storage

| Storage | Type | Purpose | Notes |
|---|---|---|---|
| `local` | dir | ISO, backups, templates | `/var/lib/vz` |
| `local-lvm` | lvmthin | VM images and LXC root filesystems | main NVMe |
| `pbs-pl` | PBS | Remote PBS backup target | server `192.168.1.72`, datastore `backup-de` |
| `hdd-pbs-de` | dir | PBS-DE additional disk image storage | `/mnt/pve/hdd-pbs-de` |

Additional mounts:

- `/mnt/duplicati-local` on local 2 TB disk.
- `/mnt/ugreen` CIFS mount to NAS share `//192.168.1.100/proxmox-DE`.
- `/mnt/hetzner` is mounted on demand via systemd automount to Hetzner Storage Box path `<HETZNER_STORAGEBOX_USER>@<HETZNER_STORAGEBOX_HOST>:/<REMOTE_PATH>`. See `../../docs/hetzner-storagebox-automount.md`.
