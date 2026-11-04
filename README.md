# we-hypr

> Intelligent Wallpaper Engine manager for **Hyprland** with zero-overhead power saving, native Wayland layer-shell rendering, and automatic window & battery auto-pause.

---

## Features

- **Native Wayland Layer-Shell**: Powered by `linux-wallpaperengine` for rendering Steam Workshop wallpapers smoothly beneath your windows.
- **Auto-Pause on Windows**: Pauses and freezes animation (0% CPU / 0% GPU) whenever any window is open or focused. Seamlessly resumes animation when switching to an empty workspace.
- **Auto-Pause on Battery**: Uses UPower D-Bus events to immediately pause wallpaper animation when unplugged from AC power, saving laptop battery life. Resumes instantly when plugged in.
- **Interactive GUI Picker**: Select wallpapers using a fast launcher picker (compatible with `dms dmenu`, `rofi`, or interactive terminal).
- **Systemd Managed**: Automatically starts on login and restores your last selected wallpaper cleanly.
- **GPU Accelerated & Capped**: Defaults to 30 FPS and hardware video decoding (`--hwdec auto`) to keep temperatures low and 144Hz compositor animations buttery smooth.

---

## Prerequisites

1. **Steam & Wallpaper Engine**: Subscribed and downloaded wallpapers from the Steam Workshop.
2. **linux-wallpaperengine**:
   - Arch / CachyOS: `yay -S linux-wallpaperengine-git`
3. **Python 3 & Dependencies**:
   - `python-dbus`
   - `python-gobject` (for GLib event loop)
   - `upower`

---

## Installation

```bash
git clone https://github.com/<your-username>/we-hypr.git
cd we-hypr
./install.sh
```

---

## Usage

### Interactive Picker
Press <kbd>Super</kbd> + <kbd>Space</kbd> and search for **Wallpaper Engine Picker**, or run:
```bash
we-hypr
```

### Command Line
```bash
# List all downloaded Steam wallpapers
we-hypr list

# Apply a wallpaper by name or Workshop ID
we-hypr set "Cozy Room"
we-hypr set 3125699220

# Check status, power source, and active auto-pause reason
we-hypr status

# Freeze animation manually (0% CPU/GPU, keeps static image)
we-hypr pause
we-hypr resume
we-hypr toggle-pause

# Change target framerate or audio
we-hypr set "Spider-Man" --fps 30 --volume 20
```

---

## How Power Saving Works

| Condition | Wallpaper State | CPU / GPU Usage |
|---|---|---|
| **Empty Desktop (on AC)** | Live Animated | ~1–2% CPU |
| **Window Open / Focused** | **Frozen (Static Frame)** | **0.0% CPU / 0% GPU** |
| **Fullscreen App / Game** | **Frozen / Paused** | **0.0% CPU / 0% GPU** |
| **On Battery (Unplugged)** | **Frozen / Paused** | **0.0% CPU / 0% GPU** |

When paused, Linux kernel sends `SIGSTOP` to suspend thread execution completely, preserving the last frame on screen without re-rendering.

---

## Uninstallation

```bash
./uninstall.sh
```

---

## License

MIT License.
