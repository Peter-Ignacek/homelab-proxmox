# PVE-PL network

## Interfaces and bridges

| Bridge | Address | Gateway | Physical port | Purpose |
|---|---|---|---|---|
| `vmbr0` | `192.168.1.250/24` | `192.168.1.1` | `enp172s0` | Main LAN |
| `vmbr1` | IPv6 link-local / manual | none | `enp173s0` | Secondary bridge |
| `wg0` | `10.50.50.1/24` | none | WireGuard | Site-to-site VPN |

Routes:

- Default via `192.168.1.1` on `vmbr0`.
- `10.50.50.0/24` via `wg0`.
