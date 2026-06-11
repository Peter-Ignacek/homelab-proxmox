# PVE-PL Upgrade Report - Proxmox VE 8 to 9

Date: 2026-06-09

Host: PVE-PL

Scope: Proxmox VE host upgrade and post-upgrade validation. Documentation only. This report is specific to PVE-PL and does not change the PVE-DE record.

## Result

PVE-PL was upgraded from Proxmox VE 8 to Proxmox VE 9.2.3.

The host is now running kernel 7.0.6-2-pve on Debian trixie.

## Final State

| Area | Verified result |
|---|---|
| Host | pve / PVE-PL |
| Proxmox version | Proxmox VE 9.2.3 |
| Running kernel | 7.0.6-2-pve |
| Repositories | Debian trixie + Proxmox pve-no-subscription |
| Enterprise repo | disabled |
| Ceph repo | disabled; Ceph unused |
| APT status | All packages are up to date |
| Failed services | 0 loaded units listed |
| pve8to9 | FAILURES 0 |
| Storage active | local, local-lvm, pve-pl |
| PBS storage | pve-pl active, datastore backup500 |
| WireGuard | wg0 active; all peers had fresh handshakes |
| NFS host mount | /mnt/nfs-plex active |

## Pre-Upgrade Backups

Fresh VM/CT backups were created before the upgrade to the Proxmox PBS storage named `pve-pl`, using datastore `backup500`.

Backed up guests:

- VM 100 haos14.1
- VM 102 Winda
- VM 500 clawbot
- CT 101 plex
- CT 103 rclone
- CT 104 tautulli
- CT 105 nginxproxymanager
- CT 106 overseerr
- CT 107 uptimekuma
- CT 108 debian
- CT 109 backrest
- CT 110 netbox

VM 900 `pbs-pl` was intentionally not backed up to the same PBS storage to avoid backing up the PBS VM into itself.

A host configuration backup was also created:

```text
/<ROOT_GUARDIAN>/pve-pl-host-config-before-pve9-2026-06-09-1436.tar.gz
/mnt/nfs-plex/_proxmox-host-backups/pve-pl/pve-pl-host-config-before-pve9-2026-06-09-1436.tar.gz
```

Do not commit the host configuration archive to this repository. It can contain sensitive configuration, including files under `/etc/wireguard`.

## Migration Work Completed

- Repaired the bootloader by removing the blocking `systemd-boot` package and reconfiguring GRUB EFI with removable EFI fallback.
- Installed `intel-microcode` and rebooted before the upgrade.
- Moved `net.ipv4.ip_forward=1` from `/etc/sysctl.conf` to `/etc/sysctl.d/99-pve-local-routing.conf`.
- Verified `pve8to9` before upgrade after stopping guests: WARNINGS 0, FAILURES 0.
- Switched repositories to Debian trixie and Proxmox VE 9 no-subscription.
- Disabled the enterprise repo and old Ceph Quincy repo because Ceph is not used.
- Ran the full upgrade to Proxmox VE 9.2.3.
- Rebooted into kernel 7.0.6-2-pve.
- Restored `onboot` for target VMs/CTs and started services.
- Fixed EFI UEFI 2023 certificates for VM 900 `pbs-pl` using `qm enroll-efi-keys 900`.

## Guest Inventory After Upgrade

| ID | Name | Type | Final state | Notes |
|---:|---|---|---|---|
| 100 | haos14.1 | VM | running | onboot=1, EFI Linux |
| 102 | Winda | VM | stopped | onboot=0, Windows 11; EFI ms-cert=2023k not changed pending BitLocker check |
| 500 | clawbot | VM | running | onboot=1 |
| 900 | pbs-pl | VM | running | onboot=1, EFI ms-cert=2023k |
| 101 | plex | CT | running | NFS /data OK |
| 103 | rclone | CT | running | NFS /nas OK, rclone service active |
| 104 | tautulli | CT | running | OK |
| 105 | nginxproxymanager | CT | running | ports 80/81/443 listening |
| 106 | overseerr | CT | running | OK |
| 107 | uptimekuma | CT | running | port 3001 listening |
| 108 | debian | CT | stopped | onboot=0 |
| 109 | backrest | CT | running | port 9898 listening |
| 110 | netbox | CT | running | postgres, redis, gunicorn, apache active |

## Validation Summary

- `pve-manager`: pve-manager/9.2.3/d0fde103346cf89a
- running kernel: 7.0.6-2-pve
- `apt update`: all packages are up to date
- `systemctl --failed`: 0 loaded units listed
- `pvesm status`: local, local-lvm, pve-pl active
- WireGuard `wg0`: all three peers had fresh handshakes
- host NFS `/mnt/nfs-plex`: mounted from NAS and active
- CT 101 Plex: `/data` mounted from NAS; Plex listening on port 32400
- CT 103 rclone: `/nas` mounted from NAS; `rclone.service` active and listening on port 3000
- CT 105 Nginx Proxy Manager: nginx listening on ports 80/81/443
- CT 107 Uptime Kuma: service listening on port 3001
- CT 109 Backrest: service listening on port 9898
- CT 110 NetBox: postgres, redis, gunicorn and apache listening

## Known Warnings And Decisions

- `pve8to9` cgroup warnings for CTs appeared after containers were started. There were no FAILURES, containers are running, and services/mounts validated OK. Treat this as an observation, not a blocker.
- VM 102 `Winda` remains stopped with `onboot=0`. Do not run `qm enroll-efi-keys 102` until BitLocker has been checked inside Windows.
- `pve8to9` found 18 old-format RRD files used only for historical data. Leave them for now; cleanup is optional later if historical metrics are not needed.
- LVM autoactivation notice for `local-lvm` is informational and does not need immediate action.
- Do not run `apt autoremove` immediately after the upgrade. Keep old 6.8 kernels for a few days as rollback fallback. Reminder starts from 2026-06-16.

## Follow-Up

- Check BitLocker status for VM 102 before considering EFI 2023 certificate enrollment.
- After a stable period, cautiously review old kernels and package cleanup.
- Optionally review old RRD files later if historical metrics are no longer needed.
