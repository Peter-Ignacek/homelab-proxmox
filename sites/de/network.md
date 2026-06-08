# PVE-DE network

## Interfaces and bridges

| Bridge | Address | Gateway | Physical port | Purpose |
|---|---|---|---|---|
| `vmbr0` | `192.168.178.71/24` | `192.168.178.1` | `eno1` | Main LAN |
| `vmbr1` | IPv6 link-local / manual | none | USB 2.5G adapter `enx6c1ff7044e65` | Secondary bridge |
| `wg0` | `10.50.50.2/24` | none | WireGuard | Site-to-site VPN |

Routes:

- Default via `192.168.178.1` on `vmbr0`.
- `10.50.50.0/24` via `wg0`.
- `192.168.1.0/24` via `wg0`.
