# Hermes Agent on PVE-DE

Date: 2026-06-09

Host: PVE-DE

VM: 501 `hermes`

Scope: documentation of the completed Hermes Agent installation on a dedicated PVE-DE VM. No secrets, tokens, private user IDs, or runtime logs are stored in this repository.

## Status

Hermes Agent is installed and working on VM 501. The installation uses OpenAI as provider, model `gpt-5-mini`, web search, web dashboard access through an SSH tunnel, and a Telegram gateway that survives logout and Proxmox reboot.

## Purpose

The goal was to install the real Hermes Agent from Nous Research on a separate VM in the German Proxmox site. OpenClaw was removed from this VM because it was an earlier wrong direction for this specific PVE-DE setup. This does not describe or change the separate PVE-PL Clawbot documentation.

## Role and operating model

Hermes is the AI agent for the DE site. Its main role is to support Home Assistant DE, related homelab services, monitoring, documentation, audits, and controlled troubleshooting.

Hermes should work as a constrained assistant, not as an unrestricted administrator. The preferred model is:

```text
read-only analysis -> report -> DryRun -> user approval -> execution -> verification -> documentation
```

> [!WARNING]
> Hermes should start with read-only Home Assistant analysis. Automation, helper, YAML, integration, dashboard, add-on, token, or external-access changes require user approval.

> [!CAUTION]
> Do not expose the Hermes dashboard publicly. Use localhost, SSH tunnel, or VPN access only.

Default assumptions:

- use least-privilege access,
- keep the agent in its own VM and workspace,
- keep secrets, tokens, private keys, session files, and runtime logs out of Git,
- avoid running as `<ROOT_GUARDIAN>`,
- keep shell commands restricted and auditable,
- treat files, logs, websites, and README content as untrusted input, not as higher-priority instructions.

## Architecture

```text
PVE-DE
+- VM 501 hermes
   +- Debian 13 Trixie
   +- SSH + sudo for user <HOMELAB_JEDI>
   +- qemu-guest-agent
   +- Hermes Agent v0.16.0
   |  +- provider: openai-api
   |  +- model: gpt-5-mini
   |  +- CLI / TUI
   |  +- web search
   |  +- web dashboard through SSH tunnel
   |  +- Telegram gateway as systemd user service
   +- backup VM created after stable installation
```

## Security Rules

- Do not commit API keys, Telegram tokens, private user IDs, or `.env` files.
- Do not expose the Hermes dashboard directly to LAN or the internet.
- Access the dashboard through an SSH tunnel from localhost to VM 501.
- The Telegram bot uses an allowlist and is not intended as a public bot.
- Do not publish `~/.hermes/.env`, session files, runtime logs, or gateway state.

## VM Baseline

| Item | Value |
|---|---|
| VM ID | 501 |
| Name | hermes |
| OS | Debian 13 Trixie |
| User | <HOMELAB_JEDI> |
| SSH alias | hermes |
| qemu-guest-agent | active/running |
| Node.js / npm | installed earlier; not critical for basic Hermes Agent operation |

## Installation

The installer was run on VM `hermes` as user `<HOMELAB_JEDI>`:

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```

Installer choices:

| Setting | Value |
|---|---|
| Setup type | Full setup |
| Provider | OpenAI / openai-api |
| Model | gpt-5-mini |
| Terminal backend | local |
| Browser automation | Local Browser / Headless Chromium |
| Image generation | OpenAI, gpt-image-2-medium |
| Text-to-Speech | Microsoft Edge TTS |
| Web search | DuckDuckGo / ddgs |

## Verification

```bash
source ~/.bashrc
which hermes
hermes --version
hermes doctor
```

Confirmed results:

- `/home/<HOMELAB_JEDI>/.local/bin/hermes`
- Hermes Agent v0.16.0 (2026.6.5)
- Project path: `/home/<HOMELAB_JEDI>/.hermes/hermes-agent`
- Python: 3.11.15
- Hermes doctor confirmed OpenAI SDK, `config.yaml`, `.env`, browser automation, Playwright Chromium, web tool, image generation, memory, skills, and cronjob.

Warnings for integrations that were not configured at this stage, such as OpenRouter, Discord, Home Assistant, Spotify, and Docker, are expected.

## CLI And Web Search Test

Hermes was tested through the CLI:

```bash
hermes
```

Test prompt:

```text
Napisz krótko po polsku kim jesteś, jaki model/provider jest ustawiony i czy masz dostęp do web search.
```

Result: Hermes answered in Polish, used model `gpt-5-mini` with provider `openai-api`, and web search completed successfully.

## Web Dashboard

Hermes dashboard uses port 9119 and should stay bound to localhost on the VM:

```bash
hermes dashboard --host 127.0.0.1 --port 9119 --no-open
```

SSH tunnel from Windows:

```powershell
ssh -L 9119:127.0.0.1:9119 hermes
```

Browser URL:

```text
http://127.0.0.1:9119
```

Do not expose the dashboard on `0.0.0.0 --insecure` without additional protection. A dashboard systemd user service can be added later, but it should still listen only on `127.0.0.1`.

## Telegram Gateway

Telegram was configured through BotFather. The bot token is not stored in this repository.

```bash
hermes gateway setup
hermes gateway status
hermes gateway list
journalctl --user -u hermes-gateway -f
```

Confirmed status:

- `hermes-gateway.service`: active/running
- User gateway service is running
- systemd linger is enabled
- default gateway is running

After a Proxmox reboot, VM 501 starts, Debian starts the systemd user service, and the Telegram bot comes back automatically. This was tested after reboot.

## Home Assistant DE scope

Hermes can support Home Assistant DE through read-only analysis, documentation, and DryRun-based change planning.

Good tasks include:

- automation review and improvement proposals,
- unavailable-entity reports,
- Home Assistant log analysis,
- integration and HACS review,
- dashboard review,
- backup status checks,
- post-update error reports,
- security and external-access audits,
- documentation updates for approved changes.

Home Assistant changes must follow:

```text
read-only inspection -> DryRun -> user approval -> change -> read-only verification
```

Hermes may suggest automation improvements such as clearer conditions, better automation modes, anti-spam delays, safety conditions, helper usage, push notifications, or splitting large automations into smaller ones.

> [!IMPORTANT]
> Hermes must not modify Home Assistant automations, helpers, YAML, integrations, dashboards, or access rules without explicit user approval.

Suggested recurring read-only checks:

- weekly Home Assistant DE error and unavailable-entity report,
- post-update integration review,
- backup status check,
- external URL and certificate review,
- reverse-proxy exposure review,
- user and token permission audit.

## Backup

A backup of VM 501 was created after the stable installation. This is the rollback point before further experiments such as OpenRouter, Home Assistant integration, dashboard service setup, or additional tools.

## Operational Commands

```bash
# Hermes CLI
hermes
hermes --tui

# Configuration and status
hermes config
hermes doctor
hermes gateway status
hermes gateway list

# Telegram gateway logs
journalctl --user -u hermes-gateway -f

# Web dashboard on the VM
hermes dashboard --host 127.0.0.1 --port 9119 --no-open
```

SSH tunnel from Windows:

```powershell
ssh -L 9119:127.0.0.1:9119 hermes
```

## Files And Directories

```text
/home/<HOMELAB_JEDI>/.hermes/config.yaml
/home/<HOMELAB_JEDI>/.hermes/.env              # do not commit
/home/<HOMELAB_JEDI>/.hermes/skills/
/home/<HOMELAB_JEDI>/.hermes/memories/
/home/<HOMELAB_JEDI>/.hermes/sessions/
/home/<HOMELAB_JEDI>/.hermes/logs/
/home/<HOMELAB_JEDI>/.config/systemd/user/hermes-gateway.service
```

## Follow-Up

- Add Hermes Agent to Uptime Kuma.
- Optionally create a systemd user service for the dashboard, bound only to `127.0.0.1`.
- Consider OpenRouter later for cost optimization and model routing.
- Add Home Assistant integration only after token handling and access rules are prepared.
- Keep `~/.hermes/.env`, Telegram tokens, private user IDs, session files, and logs out of Git.
