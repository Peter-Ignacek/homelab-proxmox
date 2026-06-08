# Known issues and cleanup tasks

## Completed cleanup

- Proxmox APT repository line cleaned on both nodes. The invalid `non-free` component was removed from the Proxmox repository entry.
- Debian Bookworm repository components were updated to include `non-free-firmware`.
- PVE-DE Hetzner failed mount was fixed by disabling the old `/etc/fstab` entry and replacing it with `systemd automount`.
- PVE-PL LXC disk usage was checked. Running containers are not critically full from inside the guest OS.
- `fstrim` reduced Plex LXC thin usage from almost full to normal.

## Both nodes

- `resolvectl` is not installed, so the recon script reports `command not found` for that command. This is harmless.
- Proxmox firewall status shows `disabled/running`; guest-specific firewall files exist on selected guests.
- Both nodes are standalone, not members of a Proxmox cluster.

## PVE-DE

- Hetzner Storage Box is now mounted on demand via `mnt-hetzner.automount`.
- Local CIFS mount to UGREEN shows high usage around 91% on the NAS share.
- PBS-PL connection had timeout messages during the report window.

## PVE-PL

- NFS Plex mount shows high NAS usage around 91%. Main consumers found: `Movies` around 8 TB and `TV` around 3.1 TB. Cleanup is content/manual, not a Proxmox issue.
- Windows VM `102 Winda` is stopped.
- CT108 `debian` is a stopped test container.
