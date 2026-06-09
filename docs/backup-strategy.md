# Backup strategy

## PVE-DE

PVE-DE has a Proxmox backup job configured at `03:00`.

Backed up guests:

```text
100,101,102,103,104,105,106,107,108
```

Target storage:

```text
pbs-pl
```

Pruning:

```text
keep-daily=7, keep-weekly=4, keep-monthly=1
```

Additional host config backup cron:

```text
30 1 * * * /bin/bash -lc 'cd /root/pve-config-backup && ./backup-pve.sh' >> /var/log/pve-config-backup.log 2>&1
```

Current Hetzner Storage Box state:

- The old failed `/etc/fstab` mount was disabled.
- Hetzner Storage Box is now mounted on demand via `systemd automount`.
- Host mountpoint: `/mnt/hetzner`.
- Remote path: `<HETZNER_STORAGEBOX_USER>@<HETZNER_STORAGEBOX_HOST>:/<REMOTE_PATH>`.
- CT106 Filebrowser bind mount remains `mp1: /mnt/hetzner,mp=/mnt/hetzner`.

Known observation from report:

- PVE-DE logs showed temporary connection timeouts to `pbs-pl` at `192.168.1.72:8007` during the report window.

## PVE-PL

PVE-PL has PBS storage configured as `pve-pl` pointing to `10.50.50.10`, datastore `backup500`.

Further check recommended:

```bash
cat /etc/pve/jobs.cfg
```

and confirm which guests are included in active backup jobs.
