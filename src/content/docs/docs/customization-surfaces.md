---
title: Nova Customization Surfaces
description: Choose the semantic root config, an owner-native file, or Home Manager.
---

Start with `yzx config`. It displays packaged defaults and writes sparse
overrides to `~/.config/yazelix/config.toml`.

## Main settings

Use it for:

- appearance mode
- shell and editor commands
- welcome behavior
- managed popup and sidebar keys
- agent command and arguments
- popup margins and top-bar widgets

## Native sidecars

Use sidecars for tool-specific preferences that Yazelix does not render:

| Surface | Path |
| --- | --- |
| Cursor config | `~/.config/yazelix/cursors.toml` |
| Mars overrides | `~/.config/yazelix/mars/config.toml` |
| Zellij scalar sidecar | `~/.config/yazelix/zellij/config.kdl` |
| Extra Zellij plugins | `~/.config/yazelix/zellij/plugins.kdl` |
| Starship overrides | `~/.config/yazelix/starship.toml` |
| Nushell additions | `~/.config/yazelix/nu/` |
| Yazi config and assets | `~/.config/yazelix/yazi/` |
| Helix config, languages, and Steel files | `~/.config/yazelix/helix/` |

## Home Manager

Home Manager exposes `programs.yazelix.enable`, package selection, sparse
settings, and optional native files. Store-backed files remain read-only in
Ratconfig. Change the reported module option and run the normal switch.

## Generated state

Files under `${XDG_DATA_HOME:-$HOME/.local/share}/yazelix` are generated output.
Change the config input or package owner instead of editing runtime state.

See the canonical [configuration guide](https://github.com/Yazelix/nova/blob/stable/docs/configuration.md)
for file layering and validation details.
