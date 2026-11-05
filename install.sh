#!/usr/bin/env bash
set -e

echo "==> Installing we-hypr..."

# Determine source directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure directories exist
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/systemd/user"
mkdir -p "$HOME/.local/share/applications"

# Copy binary
install -m 755 "$SCRIPT_DIR/bin/we-hypr" "$HOME/.local/bin/we-hypr"
ln -sf "$HOME/.local/bin/we-hypr" "$HOME/.local/bin/hypr-we"

# Copy unified systemd unit
install -m 644 "$SCRIPT_DIR/systemd/wallpaper-engine.service" "$HOME/.config/systemd/user/wallpaper-engine.service"

# Copy desktop file
install -m 644 "$SCRIPT_DIR/applications/we-picker.desktop" "$HOME/.local/share/applications/we-picker.desktop"

# Reload systemd and enable service
systemctl --user daemon-reload
systemctl --user enable --now wallpaper-engine.service

# Update desktop database
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

echo "==> Installation complete!"
echo "Run 'we-hypr' to pick a wallpaper, or 'we-hypr status' to check state."
