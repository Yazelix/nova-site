---
title: Recover a Nova Launch
description: Use the supported preflight, status, config, and package-owner checks.
---

Start with doctor:

```bash
yzx doctor
```

`yzx doctor` validates Nova's owned config, helpers, selected editor, Yazi pair,
Zellij package, layout, and plugins. A failed preflight prints the failing
check without opening Rio or Zellij.

## Inspect runtime ownership

```bash
yzx status
yzx status --json
yzx --version
```

Status reports the selected package, config home, state directory, shell,
editor, popup keys, layout, Yazi source, and session context.

## Check the root config

The root config is optional:

```text
~/.config/yazelix/config.toml
```

Open `yzx config` to inspect known invalid fields and exact native-file actions.
Back up `config.toml` before manual recovery. Removing an optional override
restores its packaged default on the next applicable launch.

## Clean up old manual installs

If an old clone, wrapper, or shell function shadows the current package:

```bash
type yzx
command -v yzx
```

The command should resolve to the Nix profile or Home Manager package that owns
the install. Remove a stale wrapper only after you identify its owner.

## Stale flake cache

For a profile install:

```bash
nix profile upgrade --refresh yazelix
```

Home Manager users update the declared input and run their normal switch.

## Treat Classic residue as a warning

Doctor reports recognized Classic state and migration backups in the active
roots. Nova does not load, archive, or remove those paths. External scripts may
still reference them.

## Start a fresh session

```bash
yzx enter
```

Use a new session when the updated package or a next-session setting needs to
take effect. Zellij owns existing session lifetime and attachment.

Do not repair Nova by editing generated files under `~/.local/share/yazelix`.
Fix the owned config input or package owner instead.
