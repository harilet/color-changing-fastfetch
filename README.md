# color-changing-fastfetch

A `fastfetch` configuration template that can be combined with an experimental helper script to pull a GTK theme color.

## What it does

- Provides a `fastfetch` JSON configuration for a themed output layout.
- Includes an experimental script that can:
  - read the current GTK theme from `xfconf-query`
  - extract `theme_selected_bg_color` from the theme's `gtk.css`
  - convert it to an ANSI 24-bit color escape sequence
  - update `~/test.jsonc` with the extracted color
  - launch `fastfetch -c ~/test.jsonc`

## Files

- `get-ternimal-color.sh` - experimental helper script to extract a GTK theme color and run `fastfetch`.
- `fastfetch.jsonc` - `fastfetch` configuration template used by the script or directly by `fastfetch`.

## Requirements

- `bash`
- `xfconf-query` (typically available with XFCE)
- `fastfetch`
- A GTK theme installed under `~/.themes` or `/usr/share/themes`

## Usage

This project is intended to be launched from your shell initialization file, such as `~/.bashrc`.

Option 1: use the experimental helper script

1. Make the script executable:

   ```bash
   chmod +x get-ternimal-color.sh
   ```

2. Add one of the following lines to `~/.bashrc`:

   ```bash
   # Generate theme-based fastfetch config and launch fastfetch
   ~/Documents/color-changing-fastfetch/get-ternimal-color.sh
   ```

Option 2: call `fastfetch` directly with the provided config

1. Add this line to `~/.bashrc`:

   ```bash
   fastfetch -c ~/Documents/color-changing-fastfetch/fastfetch.jsonc
   ```

When using the helper script, it will update `~/test.jsonc` with the extracted theme color and then launch `fastfetch`.

## Notes

- If the theme color cannot be found, the script falls back to white (`#FFFFFF`).
- The script currently expects the GTK CSS file to define `@define-color theme_selected_bg_color`.
- `~/test.jsonc` is overwritten in place.

## Customization

- Modify `fastfetch.jsonc` to change layout, modules, or appearance.
- Adjust the script if your theme path or color variable differs from the current assumptions.
