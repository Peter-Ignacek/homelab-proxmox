# OpenClaw / Clawbot VM on PVE-PL

Status: implemented on PVE-PL.

## Goal

OpenClaw runs as a private AI agent on a small Proxmox VM named `clawbot`.

The agent is intended as a technical assistant for homelab work, applications, websites, GitHub, Home Assistant, and small automation tasks.

The LLM backend uses Anthropic API. There is no local Ollama or GPU requirement.

## VM

| Item | Value |
|---|---|
| Proxmox host | `PVE-PL` |
| VM name | `clawbot` |
| Guest OS | Debian 13 / Trixie |
| User | `xxxxxxxxxxxxxx` |
| VM IP | `192.168.1.71` |
| SSH access | Windows SSH config alias `clawbot` |

Example SSH config entry:

```text
Host clawbot
    HostName 192.168.1.71
    User piotr
    Port 22
```

Connect:

```bash
ssh clawbot
```

## Installed components

Base packages:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y sudo qemu-guest-agent curl git nano ca-certificates
```

Docker was installed and verified:

```text
Docker version 29.5.3
Docker Compose version v5.1.4
```

OpenClaw was installed through npm:

```bash
sudo npm install -g openclaw@latest
```

OpenClaw version:

```text
OpenClaw 2026.6.1
```

## OpenClaw Gateway

The gateway runs as a systemd user service for user `piotr`.

Service file:

```text
/home/piotr/.config/systemd/user/openclaw-gateway.service
```

Port:

```text
18789
```

Bind mode:

```text
lan
```

Service command:

```bash
/usr/bin/openclaw gateway run --bind lan --auth password --password-file /home/piotr/.openclaw/gateway-password --port 18789 --force
```

Do not commit the password file or its contents.

Operational commands:

```bash
systemctl --user status openclaw-gateway
systemctl --user restart openclaw-gateway
ss -tulpn | grep 18789
```

Expected listener:

```text
0.0.0.0:18789
```

## Reverse proxy / HTTPS

Dashboard URL:

```text
https://openclaw.pl.ignacek.com
```

Nginx Proxy Manager proxy host:

| Setting | Value |
|---|---|
| Scheme | `http` |
| Forward hostname / IP | `192.168.1.71` |
| Forward port | `18789` |
| Websockets support | ON |
| Block common exploits | ON |
| Cache assets | OFF |
| Force SSL | ON |
| HTTP/2 support | ON |

The NPM Access List with Basic Auth was disabled because it can break WebSocket traffic.

Security is handled by:

1. HTTPS
2. OpenClaw Gateway password
3. Device pairing

## OpenClaw reverse proxy config

Allowed origins and trusted proxies were added to OpenClaw config:

```json
{
  "gateway": {
    "controlUi": {
      "allowedOrigins": [
        "https://openclaw.pl.ignacek.com",
        "http://localhost:18789",
        "http://127.0.0.1:18789"
      ]
    },
    "trustedProxies": [
      "192.168.1.58",
      "127.0.0.1",
      "::1"
    ]
  }
}
```

`192.168.1.58` is the Nginx Proxy Manager IP as seen by OpenClaw.

## Device pairing

OpenClaw requires approval for new browsers and devices.

```bash
openclaw devices list
openclaw devices approve <REQUEST_ID>
```

Each new browser, profile, phone, or computer can require a separate approval.

## Telegram bot

A Telegram bot was created through BotFather.

Bot handle:

```text
@ujazd_openclaw_bot
```

Telegram is used as the daily chat channel with Clawbot. The dashboard is used for administration, debugging, and configuration.

Pairing commands:

```bash
openclaw pairing list
openclaw pairing approve <CODE_OR_REQUEST_ID>
```

## Agent persona

Agent name:

```text
Clawbot
```

Persona files on the VM:

```text
/home/piotr/.openclaw/workspace/IDENTITY.md
/home/piotr/.openclaw/workspace/USER.md
/home/piotr/.openclaw/workspace/SOUL.md
/home/piotr/.openclaw/workspace/MEMORY.md
```

Persona summary:

- private AI agent for technical work
- scope: Proxmox, Docker, Home Assistant, GitHub, websites, small applications, homelab documentation
- language: Polish
- style: concrete, technical, lightly sarcastic, no bullshit

Safety rules:

1. Plan first.
2. Wait for user approval.
3. Execute only after approval.
4. Do not delete files without asking.
5. Do not use root without explicit approval.
6. Do not touch passwords, tokens, or 1Password without asking.
7. For Home Assistant, Proxmox, Docker, and GitHub, prepare a dry run first.

## Anthropic model

OpenClaw was initially run on Opus and then switched to Sonnet to reduce cost and token usage.

Current default model:

```text
anthropic/claude-sonnet-4-6
```

Completed changes:

1. Added Sonnet to the allowed model list.
2. Set Sonnet as primary/default.
3. Reloaded/restarted the gateway.
4. Switched the active Telegram session to Sonnet.

## Token saving mode

A token-saving mode was added in `MEMORY.md`.

Rules:

- answer briefly unless the user asks for details
- do not read the whole workspace without need
- do not load large logs; use grep, tail, and head
- for commands, show only the important results
- do not use heartbeats or proactive checks without approval
- do not summarize large files without asking
- for tool calls, plan first, then run the minimal command

`HEARTBEAT.md` is disabled and has no active tasks.

## Safety test

The safety workflow was tested:

```text
plan -> approval -> execution
```

Result:

- Clawbot prepared a plan before creating a test file.
- After approval, it created the test file.
- Before deleting the file, it asked for approval.
- After approval, it deleted the file.

The safety workflow works as expected.

## Security notes

Do not commit these values or files:

- `~/.openclaw/gateway-password`
- Anthropic API key
- Telegram Bot token
- 1Password credentials
- any password or token files

Only placeholders are safe for documentation:

```text
ANTHROPIC_API_KEY=<REDACTED>
TELEGRAM_BOT_TOKEN=<REDACTED>
GATEWAY_PASSWORD=<REDACTED>
```

## Useful commands

```bash
systemctl --user status openclaw-gateway
systemctl --user restart openclaw-gateway
journalctl --user -u openclaw-gateway.service -n 100 --no-pager
openclaw status
openclaw devices list
openclaw devices approve <REQUEST_ID>
openclaw pairing list
openclaw pairing approve <CODE>
openclaw gateway usage-cost
openclaw gateway usage-cost --password "$(cat ~/.openclaw/gateway-password)"
```

## Current state

- VM is running.
- SSH works.
- Docker works.
- OpenClaw works.
- Dashboard works over HTTPS.
- Nginx Proxy Manager works.
- WebSocket works.
- Device pairing works.
- Telegram bot works.
- Clawbot persona is saved.
- Sonnet is the default model.
- Heartbeat is disabled.
- Token-saving mode is active.
- Safety test passed.
