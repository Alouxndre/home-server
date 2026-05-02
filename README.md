# home-server

Infrastructure and configuration files for the Home Assistant host.

This repository is prepared to track declarative config while excluding live secrets, certificates, logs, and application state.

## Included

- Docker Compose stack in `homeassistant-compose.yml`
- Home Assistant YAML configuration under `config/`
- Blueprint files under `config/blueprints/`
- Sanitized examples for secret-backed services

## Excluded

- Home Assistant secrets and `.storage` runtime state
- Certbot OVH credentials, certificate material, and logs
- Zigbee2MQTT network key, MQTT password, coordinator backup, and logs
- Music Assistant data, Mosquitto runtime data, and generated backups/logs

## Bootstrap after clone

1. Copy `config/secrets.example.yaml` to `config/secrets.yaml` and set real values.
2. Copy `zigbee2mqtt/configuration.example.yaml` to `zigbee2mqtt/configuration.yaml` and set MQTT and Zigbee network credentials.
3. Copy `certbot/conf/ovh.example.ini` to `certbot/conf/ovh.ini` and set OVH API credentials.

## Home Assistant MCP (ha-mcp)

This stack uses `homeassistant-ai/ha-mcp` as an MCP bridge for Copilot.

1. Create a long-lived access token in Home Assistant: Profile -> Security -> Long-lived access tokens.
2. Create local env file:
	- `cp .env.example .env`
	- set `HOMEASSISTANT_TOKEN` in `.env`
3. Start the MCP service:
	- `docker compose -f homeassistant-compose.yml up -d mcp_hass`
4. Verify endpoint from the host:
	- `curl -i http://127.0.0.1:8086/mcp`
	- expected result: `405 Method Not Allowed` from `uvicorn` on `GET /mcp`, which confirms the MCP HTTP endpoint is reachable

This repository configures `MCP_SECRET_PATH=/mcp`, so the workspace MCP client URL is `http://127.0.0.1:8086/mcp`.

Workspace MCP client config is in `.vscode/mcp.json` and uses HTTP transport.

The custom Copilot agent is defined in `.github/agents/home_assistant.agent.md` and is scoped to `homeassistant_mcp_server/*` tools.

Notes:
- Keep tokens out of git history.
- If your Home Assistant URL is not `http://127.0.0.1:8123`, change `HOMEASSISTANT_URL` in `.env`.

## First push

```bash
git add .
git commit -m "Initial import"
git push -u origin main
```