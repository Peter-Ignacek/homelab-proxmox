# PVE-DE hardware

| Component | Value |
|---|---|
| Vendor/model | Intel NUC10i7FNH |
| CPU | Intel Core i7-10710U |
| CPU topology | 6 cores / 12 threads |
| RAM | 16 GB |
| Main disk | Kingston NVMe 250 GB |
| Extra disk | WD Green 2 TB |
| Firmware | FNCML357.0052.2021.0409.1144 |

## Storage devices

- NVMe disk contains Proxmox OS, root filesystem and `local-lvm`.
- 2 TB SATA disk split into:
  - `/mnt/pve/hdd-pbs-de` around 501 GB, used for PBS-DE disk storage.
  - `/mnt/duplicati-local` around 1.3 TB, used as local Duplicati/staging storage.
