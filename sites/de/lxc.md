# PVE-DE LXC containers

| CTID | Hostname | State in report | vCPU | RAM | Disk | Bridge | On boot | Purpose |
|---:|---|---|---:|---:|---|---|---|---|
| 101 | `adguard` | running | 1 | 512 MB | 4 GB | `vmbr1` | yes | AdGuard DNS |
| 102 | `uptimekuma` | running | 1 | 384 MB | 4 GB | `vmbr0` | yes | Monitoring |
| 103 | `nginxproxymanager` | running | 1 | 512 MB | 8 GB | `vmbr0`, static `192.168.178.181` | yes | Reverse proxy |
| 104 | `paperless-ngx` | running | 2 | 2048 MB | 40 GB | `vmbr0` | yes | Document management |
| 105 | `Duplicati` | running | 1 | 1024 MB | 12 GB | `vmbr0` | yes | Backup tooling |
| 106 | `filebrowser` | running | 1 | 512 MB | 4 GB | `vmbr0` | yes | File browser |
| 107 | `backrest` | running | 1 | 512 MB | 8 GB | `vmbr0` | yes | Restic/Backrest backup |
| 108 | `devops-lab-de` | running | 2 | 2048 MB | 16 GB | `vmbr0` | yes | DevOps lab |

Important bind mounts:

- `paperless-ngx`: `/mnt/duplicati-local/paperless-staging` mounted to `/mnt/staging`.
- `Duplicati`: `/mnt/ugreen` and `/mnt/duplicati-local` mounted into the container.
- `filebrowser`: `/mnt/duplicati-local/share`, `/mnt/hetzner`, and `/mnt/ugreen` mounted into the container.
