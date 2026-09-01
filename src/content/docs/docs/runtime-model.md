---
title: Nova Runtime Model
description: The yzx entrypoints, package variants, config boundary, and component owners.
---

Yazelix Nova is a Nix-packaged terminal workspace with one front door: `yzx`.

```text
yzx launch -> Nova Rio -> managed Zellij workspace
yzx enter  -> current terminal -> managed Zellij workspace
yzx run    -> prepared Nova environment -> requested program
```

Bare `yzx` prints help. `launch` is the only Nova Rio route. `enter` needs an
interactive terminal and works without a display server.

## Packages

The full package includes:

- Nova Rio for graphical launch
- the Yazelix Zellij fork and managed layout
- managed Yazi, Helix, and Nushell
- popup, config, screen, tutor, Git, prompt, and completion tools

Package names follow `yazelix[-no-helix][-no-yazi]`. Each suffix
removes that managed package while retaining the remaining integration.
Helix-free and Yazi-free packages use the selected host tools.

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

## Sessions, tabs, and panes

A useful mental model is a browser window:

- the session is the window: one live Nova environment that can hold several projects
- each tab is a project workspace with one canonical root
- panes are the editor, Yazi sidebar, shells, and tools working in that tab
- processes run inside those panes

Zellij owns the session, tabs, panes, their processes, and live attachment.
Nova gives that structure project semantics: the pane orchestrator tracks one
workspace root per tab and routes the managed sidebar, editor, popups, and tools
around it.

`--session NAME` names the outer live session, not a project tab. It gives that
session a stable reattachment target:

```bash
yzx enter --session daily
yzx enter attach daily
```

The first command creates a fresh session. The second attaches while that
session is still running. One named session can contain several project tabs.
This is live reattachment, not structural restore after the session has ended.

## Workspace identity

Nova targets managed panes by identity:

- the file tree is a managed Yazi sidebar
- each tab has one canonical workspace root
- managed opens reuse the tab's editor
- `yzx reveal` opens the persistent Yazi popup at a target
- Git and agent tools use workspace-scoped popups
- `Alt z` retargets the tab workspace and editor together

## Ownership

Nova Rio owns graphical launch. Zellij owns multiplexing. Ratconfig owns the
config UI toolkit, and focused first-party packages own popups, pane
orchestration, the top bar, screens, and Yazi themes. Nova pins and composes
their package outputs. [Nova and Zellij](/docs/nova-and-zellij/) lists the
packaged layout, plugins, and the Nova Zellij fork delta.

See the canonical [architecture](https://github.com/Yazelix/nova/blob/stable/ARCHITECTURE.md)
for component contracts and verification gaps.
