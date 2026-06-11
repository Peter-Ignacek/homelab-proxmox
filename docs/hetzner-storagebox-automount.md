# Hetzner Storage Box automount on PVE-DE

Status: implemented on 2026-06-08.

## Goal

PVE-DE should mount the Hetzner Storage Box automatically when it is first accessed, without requiring a manual `sshfs` command after every reboot. The mount must not block Proxmox startup if Hetzner is temporarily unavailable.

The chosen solution is `systemd automount`:

- `mnt-hetzner.automount` is enabled and active after boot.
- `mnt-hetzner.mount` is triggered only when `/mnt/hetzner` is accessed.
- If idle for 600 seconds, the mount can be released automatically.

## Final remote path

The old path was wrong/empty:

```text
<HETZNER_STORAGEBOX_USER>@<HETZNER_STORAGEBOX_HOST>:/<REMOTE_PATH>
```

The correct active path is:

```text
<HETZNER_STORAGEBOX_USER>@<HETZNER_STORAGEBOX_HOST>:/<REMOTE_PATH>
```

Observed contents after correction:

```text
peperless
Sicherungsaufgabe1_20260607_194908810.ubk
```

## Authentication

Authentication uses the SSH key on PVE-DE:

```text
/<ROOT_GUARDIAN>/.ssh/hetzner_storagebox
```

The private key must not be committed to GitHub or Notion.

## Host mountpoint

```text
/mnt/hetzner
```

## Container integration

CT106 `filebrowser` receives the host mount via Proxmox bind mount:

```text
mp1: /mnt/hetzner,mp=/mnt/hetzner
```

Inside CT106, Filebrowser exposes it through the symlink:

```text
/srv/files/hetzner -> /mnt/hetzner
```

## systemd files

### `/etc/systemd/system/mnt-hetzner.mount`

```ini
[Unit]
Description=Hetzner Storage Box mount
Wants=network-online.target
After=network-online.target

[Mount]
What=<HETZNER_STORAGEBOX_USER>@<HETZNER_STORAGEBOX_HOST>:/<REMOTE_PATH>
Where=/mnt/hetzner
Type=fuse.sshfs
Options=_netdev,allow_other,uid=100000,gid=100000,default_permissions,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,port=23,IdentityFile=/<ROOT_GUARDIAN>/.ssh/hetzner_storagebox

[Install]
WantedBy=multi-user.target
```

### `/etc/systemd/system/mnt-hetzner.automount`

```ini
[Unit]
Description=Automount Hetzner Storage Box

[Automount]
Where=/mnt/hetzner
TimeoutIdleSec=600

[Install]
WantedBy=multi-user.target
```

## Enable / reload commands

```bash
systemctl daemon-reload
systemctl enable --now mnt-hetzner.automount
```

## Verification commands

```bash
systemctl status mnt-hetzner.automount --no-pager
ls -lah /mnt/hetzner
findmnt /mnt/hetzner
systemctl status mnt-hetzner.mount --no-pager
systemctl --failed
pct exec 106 -- ls -lah /mnt/hetzner
pct exec 106 -- ls -lah /srv/files/hetzner
```

Expected state:

```text
mnt-hetzner.automount: active (waiting)
mnt-hetzner.mount: active (mounted) after first access
systemctl --failed: 0 loaded units listed
```

## Notes

The old `/etc/fstab` entry was disabled/commented because it generated a failed mount unit during boot. The new automount approach is safer because it does not block Proxmox boot and only mounts on demand.
