---
title: Start with Yazelix Nova
description: Try or install Stable, then choose the Mars or current-terminal entrypoint.
draft: true
---

Yazelix Nova is a Nix-packaged terminal workspace. You need Nix with flakes
enabled.

## Choose a channel

| Channel | Install reference | Use |
| --- | --- | --- |
| Stable | `github:Yazelix/nova/stable` | Checked and dogfooded release |
| Main | `github:Yazelix/nova/main#yazelix-main` | Frequent accepted updates |
| Edge | `github:Yazelix/nova/edge#yazelix-edge` | Experimental dogfooding |

Immutable `nova-v*` tags select exact releases. A Nix lock file keeps its
selected revision until you update it.

## Install

```bash
nix profile add --refresh github:Yazelix/nova/stable
```

Open the desktop workspace through Mars:

```bash
yzx launch
```

Start the same managed workspace in the current terminal or over SSH:

```bash
yzx enter
```

## Day-to-day use

Set a terminal profile to run `yzx enter`, or open the installed Linux desktop
entry. Most days, you do not type another `yzx` command after Nova opens.
`Alt Shift K` opens Ratconfig; the [keybinding map](/keybindings/) covers the
rest of the workspace.

## Try without installing

```bash
nix run github:Yazelix/nova/stable -- launch
nix run github:Yazelix/nova/stable#yazelix-no-mars -- enter
```

Run the owned preflight without opening Mars or Zellij:

```bash
nix run github:Yazelix/nova/stable -- doctor
```

## Named sessions

Plain `yzx launch` and `yzx enter` start independent sessions. Add
`--session NAME` to create a fresh named session:

```bash
yzx enter --session project
yzx launch --session project
```

Attach to a live session by its full name:

```bash
yzx enter attach project
yzx launch attach project
```

Creation fails for a live name; attachment fails for a missing name.

Inside Nova, press `Ctrl Alt o`, then `w` to open the session manager. Select a
live session to switch, or type a missing name and press `Enter` with the
Yazelix layout selected to create it.

After you switch sessions, popups or `Alt h` / `Alt l` may pause for several
seconds. Press `Alt 1-9` to select a tab, then retry. See
[Workspace keys](/keybindings/#workspace-keys) for the session-manager chord.

## Choose a package

Package names follow `yazelix[-no-mars][-no-helix][-no-yazi]`. The suffixes
remove Mars, managed Helix, or managed Yazi while retaining the remaining Nova
integration.

```bash
nix profile add --refresh github:Yazelix/nova/stable#yazelix-no-mars
```

Use `yzx enter` with a Mars-free package. Helix-free packages need an installed
editor selected through `editor.command`. Yazi-free packages need matching
host `yazi` and `ya` commands.

See the canonical [installation and package guide](https://github.com/Yazelix/nova/blob/stable/docs/installation.md)
for the full matrix, platform evidence, Home Manager, and installed sizes.

## First five minutes

Start the packaged tutor after entering Nova:

```bash
yzx tutor begin
```

- `yzx launch` opens Mars, then the managed workspace
- `yzx enter` opens the managed workspace in the current terminal
- `Alt Shift K` opens Ratconfig inside Nova
- `yzx config` opens Ratconfig from another terminal
- `~/.config/yazelix/config.toml` stores optional sparse semantic overrides
- `~/.local/share/yazelix` stores generated runtime state by default
- `yzx doctor` checks the owned runtime setup
