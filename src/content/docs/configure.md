---
title: Configure Yazelix Nova
description: Use Ratconfig, sparse semantic overrides, or owner-native files.
---

Open Nova's Ratconfig interface:

```bash
yzx config
```

Ratconfig shows packaged defaults, saves explicit overrides, and marks
Home Manager-owned files as read-only.

## Main settings

The optional root config is:

```text
~/.config/yazelix/config.toml
```

Nova does not create this file until you save a root setting. Missing keys
inherit packaged defaults. Unsupported or misspelled paths fail validation.

Common fields include:

| Field | Default | Applies to |
| --- | --- | --- |
| `appearance.mode` | `dark` | Managed component appearance |
| `shell.program` | `nu` | New panes |
| `editor.command` | `yzx-hx` | New editor opens |
| `welcome.enabled` | `true` | New launches |
| `agent.command` | `auto` | New agent popups |
| `bar.widgets` | Nova widget list | New launches |

For example:

```toml
[appearance]
mode = "light"

[shell]
program = "fish"

[editor]
command = "nvim"
```

Ratconfig labels each field with its apply timing. Start a new session for
fields marked `next launch` or `next session`.

## Native files

Component-specific configuration lives beside `config.toml`:

| Surface | Path |
| --- | --- |
| Cursor definitions and selection | `~/.config/yazelix/cursors.toml` |
| Mars overrides | `~/.config/yazelix/mars/config.toml` |
| Guarded Zellij scalars | `~/.config/yazelix/zellij/config.kdl` |
| Extra Zellij plugins | `~/.config/yazelix/zellij/plugins.kdl` |
| Starship overrides | `~/.config/yazelix/starship.toml` |
| Nushell additions | `~/.config/yazelix/nu/env.nu`, `nu/config.nu` |
| Helix overrides | `~/.config/yazelix/helix/` |
| Yazi config and assets | `~/.config/yazelix/yazi/` |

Ratconfig exposes exact file actions for these surfaces. Native owners keep
their own validation and schema.

## Home Manager

The Home Manager module owns one enable flag, package selection, sparse
`programs.yazelix.config.settings`, and optional native files. It writes no
runtime config unless you declare one of those options.

Store-backed files appear as read-only in `yzx config`. Edit the named
`programs.yazelix.config.*` option, then run your normal Home Manager switch.

## Generated state

Nova writes generated runtime state to
`${XDG_DATA_HOME:-$HOME/.local/share}/yazelix` unless `YAZELIX_STATE_DIR`
overrides it. Edit the config inputs, not generated output.

See the canonical [configuration guide](https://github.com/luccahuguet/yazelix/blob/stable/docs/configuration.md)
for the complete field and native-file contracts.
