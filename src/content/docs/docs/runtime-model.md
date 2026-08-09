---
title: Nova Runtime Model
description: The yzx entrypoints, package variants, config boundary, and component owners.
---

Yazelix Nova is a Nix-packaged terminal workspace with one front door: `yzx`.

```text
yzx launch -> Mars -> managed Zellij workspace
yzx enter  -> current terminal -> managed Zellij workspace
yzx run    -> prepared Nova environment -> requested program
```

Bare `yzx` prints help. `launch` is the only Mars route. `enter` needs an
interactive terminal and works without a display server.

## Packages

The full package includes:

- Mars for graphical launch
- the Yazelix Zellij fork and managed layout
- managed Yazi, Helix, and Nushell
- popup, config, screen, tutor, Git, prompt, and completion tools

Package names follow `yazelix[-no-mars][-no-helix][-no-yazi]`. Each suffix
removes that managed package while retaining the remaining integration.
Mars-free packages use `yzx enter`; Helix-free and Yazi-free packages use the
selected host tools.

## Generated runtime state

Nova renders runtime state under:

```text
~/.local/share/yazelix
```

This directory is output. Edit the config inputs instead.

## User config

The optional sparse semantic config is:

```text
~/.config/yazelix/config.toml
```

Component-native files live under the same `~/.config/yazelix/` root. Normal
host config at `~/.config/{helix,yazi,starship}` is not loaded by default.

## Workspace identity

Nova targets managed panes by identity:

- the file tree is a managed Yazi sidebar
- each tab has one canonical workspace root
- managed opens reuse the tab's editor
- `yzx reveal` opens the persistent Yazi popup at a target
- Git and agent tools use workspace-scoped popups
- `Alt z` retargets the tab workspace and editor together

## Ownership

Mars owns the terminal. Yazelix Zellij owns multiplexing, Ratconfig owns the
config UI toolkit, and focused first-party packages own popups, pane
orchestration, the top bar, screens, cursors, and Yazi themes. Nova pins and
composes their package outputs.

See the canonical [architecture](https://github.com/luccahuguet/yazelix/blob/stable/ARCHITECTURE.md)
for component contracts and verification gaps.
