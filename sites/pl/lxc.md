# PVE-PL LXC containers

| CTID | Hostname | State in report | vCPU | RAM | Disk | Bridge | On boot | Purpose |
|---:|---|---|---:|---:|---|---|---|---|
| 101 | `plex` | running | 8 | 6144 MB | 32 GB | `vmbr1`, static `192.168.1.155` | yes | Plex media server |
| 103 | `rclone` | running | 1 | 512 MB | 2 GB | `vmbr0` | yes | Rclone sync |
| 104 | `tautulli` | running | 2 | 1024 MB | 4 GB | `vmbr0` | yes | Plex monitoring |
| 105 | `nginxproxymanager` | running | 2 | 2048 MB | 8 GB | `vmbr0` | yes | Reverse proxy |
| 106 | `overseerr` | running | 2 | 4096 MB | 8 GB | `vmbr0` | yes | Media requests |
| 107 | `uptimekuma` | running | 1 | 1024 MB | 4 GB | `vmbr0` | yes | Monitoring |
| 108 | `debian` | stopped | 1 | 512 MB | 2 GB | `vmbr0` | no | Debian test container |
| 109 | `backrest` | running | 1 | 512 MB | 8 GB | `vmbr0` | yes | Restic/Backrest backup |
| 110 | `netbox` | running | 2 | 2048 MB | 4 GB | `vmbr0` | yes | NetBox lab |

Important bind mounts:

- `plex`: `/mnt/nfs-plex` mounted to `/data`.
- `rclone`: `/mnt/nfs-plex` mounted to `/nas`.
- `plex`: has `/dev/dri` passthrough and additional device bind mounts for hardware access.
