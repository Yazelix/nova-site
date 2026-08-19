---
title: Nova and Zellij
description: What Zellij owns, what Yazelix packages around it, and what the Nova Zellij fork changes.
---

Nova uses Zellij as the multiplexer. Tabs, stacked panes, floating panes, layouts, and the plugin API are Zellij. Yazelix ships a default layout, keys, plugins, and `yzx` around that. The Nova Zellij fork keeps the pinned upstream Zellij base and adds the runtime seams listed here.

## Zellij

Upstream Zellij owns multiplexing: tabs, tiled and stacked panes, floating panes, sessions, layouts, and plugins. Rounded pane corners, pane frames, and swap layouts are Zellij settings. Nova's default workspace uses those surfaces.

## Yazelix around Zellij

The product shape around the multiplexer lives in packages, layout, and plugins:

| Piece | Owns |
| --- | --- |
| Packaged layout and keys | Yazi sidebar plus stacked work panes, Alt-grid movement, popup chords |
| [Zellij Pane Orchestrator](https://github.com/Yazelix/zellij-pane-orchestrator) | Tab-local workspace roots, focus, sidebar, editor, and popup routing |
| [Zellij Popup](https://github.com/Yazelix/zellij-popup) | Git, agent, Ratconfig, Yazi, and other floating TUIs |
| [Nova Bar](https://github.com/Yazelix/nova-bar) | Top bar: tabs, modes, status, activity |
| `yzx` and [Ratconfig](https://github.com/Yazelix/ratconfig) | Launch, enter, doctor, and live config |

Ratconfig can change a Zellij setting while a session runs. The popup is Yazelix. The value it writes, such as rounded corners, is still Zellij.

## Nova Zellij fork

[Nova Zellij](https://github.com/Yazelix/nova-zellij) starts from upstream Zellij with native Kitty graphics. Upstream stores, places, renders, and tears down images. It does not implement Yazi's Unicode placeholder stream, so the fork translates the current Yazi `U=1` placeholders into one upstream placement and blanks the placeholder glyphs.

The rest of the Yazelix delta:

| Delta | Role |
| --- | --- |
| Startup theme mode | `--theme-mode dark` or `light` selects appearance before the first render and keeps it across reloads |
| Theme replay to late plugins | A plugin that subscribes after startup still receives the current mode |
| Three-island status hints | The native status bar groups mode actions by their real modifiers, so `Ctrl-Alt` stays distinct from `Ctrl` and `Alt` |
| Isolated plugin permission cache | `yzx` can pre-grant the packaged bar, popup, and orchestrator without touching standalone Zellij's global cache |
| Stable stacked-pane identity | Stack order survives focus, close, and the sidebar swap layout |
| Replacement-client plugin cleanup | A replacement client gets a fresh ID; plugins from a disconnected client do not handle later pipes. The fork carries this from upstream pull request 5272 |

Three-island hints change Zellij's native status bar. Nova Bar is a separate plugin for the top bar. Unicode-placeholder coverage, removal conditions, and the pinned upstream base live in the [Nova Zellij fork notes](https://github.com/Yazelix/nova-zellij/blob/yazelix_native_kitty_v1/YAZELIX.md).
