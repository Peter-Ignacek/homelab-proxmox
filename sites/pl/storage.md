# PVE-PL storage

| Storage | Type | Purpose | Notes |
|---|---|---|---|
| `local` | dir | ISO, backups, templates | `/var/lib/vz` |
| `local-lvm` | lvmthin | VM images and LXC root filesystems | main 1 TB NVMe |
| `pve-pl` | PBS | PBS backup target | server `10.50.50.10`, datastore `backup500` |

Additional mounts:

- `/mnt/nfs-plex` NFS mount to NAS path `192.168.1.100:/volume1/Plex`.
