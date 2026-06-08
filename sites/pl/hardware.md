# PVE-PL hardware

| Component | Value |
|---|---|
| Vendor/model | GEEKOM GT1 Mega |
| CPU | Intel Core Ultra 7 155H |
| CPU topology | 16 cores / 22 logical CPUs shown by Linux |
| RAM | 32 GB |
| Main disk | Kingston OM8PGP41024N-A0, 1 TB NVMe |
| Firmware | 0.50 |

## Storage devices

- 1 TB NVMe contains Proxmox OS, root filesystem and `local-lvm`.
- NFS mount `/mnt/nfs-plex` points to NAS path `192.168.1.100:/volume1/Plex`.
