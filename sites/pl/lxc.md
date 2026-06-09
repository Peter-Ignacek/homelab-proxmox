# PVE-PL LXC containers

| CTID | Hostname | State after upgrade | vCPU | RAM | Disk | Bridge | On boot | Purpose | Validation notes |
|---:|---|---|---:|---:|---|---|---|---|---|
| 101 | `plex` | running | 8 | 6144 MB | 32 GB | `vmbr1`, static `192.168.1.155` | yes | Plex media server | NFS `/data` OK, Plex listening on 32400 |
| 103 | `rclone` | running | 1 | 512 MB | 2 GB | `vmbr0` | yes | Rclone sync | NFS `/nas` OK, rclone service active on 3000 |
| 104 | `tautulli` | running | 2 | 1024 MB | 4 GB | `vmbr0` | yes | Plex monitoring | OK |
| 105 | `nginxproxymanager` | running | 2 | 2048 MB | 8 GB | `vmbr0` | yes | Reverse proxy | ports 80/81/443 listening |
| 106 | `overseerr` | running | 2 | 4096 MB | 8 GB | `vmbr0` | yes | Media requests | OK |
| 107 | `uptimekuma` | running | 1 | 1024 MB | 4 GB | `vmbr0` | yes | Monitoring | port 3001 listening |
| 108 | `debian` | stopped | 1 | 512 MB | 2 GB | `vmbr0` | no | Debian test container | intentionally stopped |
| 109 | `backrest` | running | 1 | 512 MB | 8 GB | `vmbr0` | yes | Restic/Backrest backup | port 9898 listening |
| 110 | `netbox` | running | 2 | 2048 MB | 4 GB | `vmbr0` | yes | NetBox lab | postgres, redis, gunicorn, apache active |

Important bind mounts:

- `plex`: `/mnt/nfs-plex` mounted to `/data`.
- `rclone`: `/mnt/nfs-plex` mounted to `/nas`.
- `plex`: has `/dev/dri` passthrough and additional device bind mounts for hardware access.
