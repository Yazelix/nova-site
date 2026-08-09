---
title: Start with Yazelix Nova
description: Try or install Stable, then choose the Mars or current-terminal entrypoint.
---

Yazelix Nova is a Nix-packaged terminal workspace. You need Nix with flakes
enabled.

## Install

```bash
nix profile add --refresh github:luccahuguet/yazelix/stable
```

Open the desktop workspace through Mars:

```bash
yzx launch
```

Start the same managed workspace in the current terminal or over SSH:

```bash
yzx enter
```

## Try without installing

```bash
nix run github:luccahuguet/yazelix/stable -- launch
nix run github:luccahuguet/yazelix/stable#yazelix-no-mars -- enter
```

Run the owned preflight without opening Mars or Zellij:

```bash
nix run github:luccahuguet/yazelix/stable -- doctor
```

## Choose a channel

| Channel | Install reference | Use |
| --- | --- | --- |
| Stable | `github:luccahuguet/yazelix/stable` | Checked and dogfooded release |
| Main | `github:luccahuguet/yazelix/main#yazelix-main` | Frequent accepted updates |
| Edge | `github:luccahuguet/yazelix/edge#yazelix-edge` | Experimental dogfooding |

Immutable `nova-v*` tags select exact releases. A Nix lock file keeps its
selected revision until you update it.

## Choose a package

Package names follow `yazelix[-no-mars][-no-helix][-no-yazi]`. The suffixes
remove Mars, managed Helix, or managed Yazi while retaining the remaining Nova
integration.

```bash
nix profile add --refresh github:luccahuguet/yazelix/stable#yazelix-no-mars
```

Use `yzx enter` with a Mars-free package. Helix-free packages need an installed
editor selected through `editor.command`. Yazi-free packages need matching
host `yazi` and `ya` commands.

See the canonical [installation and package guide](https://github.com/luccahuguet/yazelix/blob/stable/docs/installation.md)
for the full matrix, platform evidence, Home Manager, and installed sizes.

## First five minutes

Start the packaged tutor after entering Nova:

```bash
yzx tutor begin
```

- `yzx launch` opens Mars, then the managed workspace
- `yzx enter` opens the managed workspace in the current terminal
- `yzx config` opens the Nova configuration UI
- `~/.config/yazelix/config.toml` stores optional sparse semantic overrides
- `~/.local/share/yazelix` stores generated runtime state by default
- `yzx doctor` checks the owned runtime setup
