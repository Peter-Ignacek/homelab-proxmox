# PVE-PL storage

| Storage | Type | Purpose | Notes |
|---|---|---|---|
| `local` | dir | ISO, backups, templates | `/var/lib/vz` |
| `local-lvm` | lvmthin | VM images and LXC root filesystems | main 1 TB NVMe |
| `pve-pl` | PBS | PBS backup target | server `10.50.50.10`, datastore `backup500` |

Additional mounts:

- `/mnt/nfs-plex` NFS mount to NAS path `<PRIVATE_IP>:/volume1/Plex`.

Backup note:

- Host configuration backup before the Proxmox VE 9 upgrade was stored locally and on the NAS. Do not commit the archive because it can contain sensitive host configuration such as WireGuard files.
