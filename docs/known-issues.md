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

## PVE-PL post Proxmox VE 9 follow-up

- Do not run `apt autoremove` immediately after the 2026-06-09 upgrade. Keep old 6.8 kernels for a few days as rollback fallback; reminder starts from 2026-06-16.
- VM 102 `Winda` remains stopped with `onboot=0`. Check BitLocker before considering `qm enroll-efi-keys 102` for EFI 2023 certificates.
- `pve8to9` reported cgroup warnings for some running CTs after services were started. There were no FAILURES, and CT services/mounts validated OK. Treat this as an observation.
- `pve8to9` found 18 old-format RRD files used only for historical data. Leave them for now; cleanup is optional later if historical metrics are not needed.
- LVM autoactivation notice for `local-lvm` is informational and does not require immediate action.
