# Inventory summary: PVE-PL

Updated after Proxmox VE 9 upgrade validation on 2026-06-09.

## Host

GEEKOM GT1 Mega, Intel Core Ultra 7 155H, 32 GB RAM, Debian trixie, Proxmox VE 9.2.3.

- pve-manager: 9.2.3
- running kernel: 7.0.6-2-pve
- pve8to9: FAILURES 0
- failed services: 0 loaded units listed

## Guests

- VMs: 4
- LXC containers: 9
- Running after upgrade: VM 100, VM 500, VM 900, CT 101, CT 103-107, CT 109-110
- Intentionally stopped: VM 102, CT 108

See:

- `../sites/pl/vms.md`
- `../sites/pl/lxc.md`
- `../docs/upgrades/pve-pl-pve9-upgrade-2026-06-09.md`
