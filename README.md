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

## First push

```bash
git add .
git commit -m "Initial import"
git push -u origin main
```