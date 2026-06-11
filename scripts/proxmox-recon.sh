#!/usr/bin/env bash
set -euo pipefail

HOST="$(hostname)"
DATE="$(date +%F_%H-%M-%S)"
OUT="/<ROOT_GUARDIAN>/proxmox-recon-${HOST}-${DATE}.md"

section() {
  echo
  echo "## $1"
  echo
}

cmd() {
  echo
  echo '```bash'
  echo "# $*"
  echo '```'
  echo
  echo '```text'
  "$@" 2>&1 || true
  echo '```'
  echo
}

{
echo "# Proxmox Recon Report"
echo
echo "- Host: ${HOST}"
echo "- Date: $(date -Is)"
echo "- User: $(whoami)"
echo

section "System / Proxmox Version"
cmd hostnamectl
cmd pveversion -v
cmd uname -a
cmd uptime

section "CPU"
cmd lscpu

section "RAM"
cmd free -h

section "Disks / Block Devices"
cmd lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL,SERIAL
cmd df -h -x tmpfs -x devtmpfs
cmd findmnt

section "Storage / Proxmox Storage"
cmd pvesm status
cmd cat /etc/pve/storage.cfg

section "ZFS / LVM"
cmd zpool status
cmd zfs list
cmd pvs
cmd vgs
cmd lvs

section "Network"
cmd ip -br addr
cmd ip route
cmd cat /etc/network/interfaces
cmd bridge link
cmd cat /etc/hosts

section "Firewall"
cmd pve-firewall status
cmd find /etc/pve/firewall -maxdepth 2 -type f -print

section "Cluster / Datacenter Config"
cmd pvecm status
cmd cat /etc/pve/datacenter.cfg
cmd ls -la /etc/pve

section "APT Repositories / Subscription Status"
cmd cat /etc/apt/sources.list
cmd find /etc/apt/sources.list.d -maxdepth 1 -type f -print -exec sh -c 'echo "--- $1"; cat "$1"' _ {} \;
cmd apt-cache policy proxmox-ve pve-manager
cmd apt update

section "VM List"
cmd qm list

section "LXC List"
cmd pct list

section "VM Configs"
for id in $(qm list | awk 'NR>1 {print $1}'); do
  section "VM ${id} config"
  cmd qm config "$id"
done

section "LXC Configs"
for id in $(pct list | awk 'NR>1 {print $1}'); do
  section "LXC ${id} config"
  cmd pct config "$id"
done

section "Running Services"
cmd systemctl --failed
cmd systemctl status pveproxy pvedaemon pvestatd pve-cluster corosync

section "Backup Jobs"
cmd cat /etc/pve/jobs.cfg
cmd find /etc/pve -maxdepth 3 -type f | grep -Ei 'vzdump|backup|jobs' || true

section "Cron / Timers"
cmd crontab -l
cmd ls -la /etc/cron.d
cmd systemctl list-timers --all

section "Helper Scripts / Shell History Hints"
cmd grep -RiE "tteck|community-scripts|post-pve|no-subscription|pve-no-subscription|enterprise|nag|helper" /<ROOT_GUARDIAN> /etc/apt /etc/pve 2>/dev/null

section "Installed Packages - Relevant"
cmd dpkg -l | grep -Ei "proxmox|pve-|qemu|lxc|zfs|ceph|tailscale|wireguard|rclone|duplicati|pbs|backup|smart|lm-sensors|iotop|iftop|htop"

section "Redaction Notes"
echo "- Before publishing to GitHub, check this report for public IPs, hostnames, serial numbers, MAC addresses, tokens, passwords, WireGuard keys, API keys."
echo "- Do not commit private keys from /etc/pve/priv, /etc/ssh, /<ROOT_GUARDIAN>, backup credentials, or cloud credentials."

} > "$OUT"

echo "Report created: $OUT"
