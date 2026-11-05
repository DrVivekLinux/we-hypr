#!/usr/bin/env bash
set -e

echo "==> Uninstalling we-hypr..."

# Stop and disable systemd service
systemctl --user stop wallpaper-engine.service 2>/dev/null || true
systemctl --user disable wallpaper-engine.service 2>/dev/null || true

# Remove installed files
rm -f "$HOME/.local/bin/we-hypr"
rm -f "$HOME/.local/bin/hypr-we"
rm -f "$HOME/.config/systemd/user/wallpaper-engine.service"
rm -f "$HOME/.local/share/applications/we-picker.desktop"

systemctl --user daemon-reload
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

echo "==> Uninstallation complete."
