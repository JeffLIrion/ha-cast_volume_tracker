#!/bin/bash

# 1. Delete files
cd custom_components/cast_volume_tracker
rm *.py
rm manifest.json
rm services.yaml

# 2. Download files
wget https://raw.githubusercontent.com/JeffLIrion/home-assistant/dev-plus-custom-components/homeassistant/components/cast_volume_tracker/__init__.py
wget https://raw.githubusercontent.com/JeffLIrion/home-assistant/dev-plus-custom-components/homeassistant/components/cast_volume_tracker/manifest.json
wget https://raw.githubusercontent.com/JeffLIrion/home-assistant/dev-plus-custom-components/homeassistant/components/cast_volume_tracker/services.yaml
