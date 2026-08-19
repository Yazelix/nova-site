---
title: Yazelix Nova Keybindings
description: The packaged workspace key grid and its supported customization surface.
---

Nova extends the Helix and Vim `h/j/k/l` model across the workspace.

## Movement grid

| Layer | `h` | `j` | `k` | `l` |
| --- | --- | --- | --- | --- |
| `Alt` | Focus left or previous tab | Focus down | Focus up | Focus right or next tab |
| `Ctrl Alt` | Move tab left | Move pane down | Move pane up | Move tab right |
| `Alt Shift` | Yazi sidebar | Git popup | Config popup | Agent popup |

## Workspace keys

| Key | Action |
| --- | --- |
| `Alt Shift M` | Toggle the command menu |
| `Alt Shift S` | Show a random full-screen visual |
| `Alt Shift Y` | Toggle the full managed Yazi popup |
| `Ctrl y` | Toggle focus between the editor and Yazi sidebar |
| `Alt Shift F` | Toggle the focused pane fullscreen |
| `Alt 1-9` | Go to tab 1-9 |
| `Alt m` | Open a new pane |
| `Ctrl q` | Quit the Nova session |
| `Ctrl Alt o` | Open Zellij session mode; press `w` for the [session manager](/start/#named-sessions) |
| `Alt r` | Reveal from the editor or return from Yazi |
| `Alt z` | Retarget the tab workspace from Yazi with zoxide |

Press a popup key again to hide or close that surface and return to the tiled
workspace.

## Customize keys

Open `yzx config` to edit the managed config, agent, Git, menu, screen, sidebar,
and sidebar-focus chords. The corresponding `keybindings.*` fields live in
`~/.config/yazelix/config.toml` and accept a key chord or `false`. Changes apply
to new sessions.

The fixed `Alt Shift Y`, application-local `Alt r`, and Yazi `Alt z` bindings
remain in their native packaged owners. Nova rejects collisions among managed
semantic keys.

Ratconfig's Keys tab is the complete packaged reference. The runtime sources
are `defaults/zellij/config.kdl`, the managed Helix config, and the managed Yazi
keymap.
