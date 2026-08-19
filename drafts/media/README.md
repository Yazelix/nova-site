# Nova v1 draft media

These source files stay under `drafts/`. Approved copies live under the
article's public media path.

The day-to-day capture pins Nova 1.1 Edge commit
`5a673c059c454042085b191d5e8ec15c01b3d121`, with isolated temporary config and
state directories.

## Recording workflow

The day-to-day demo is generated from pinned Nova, Mars, Nixpkgs, Ratconfig,
Starcompass, and Anima revisions, plus an authenticated local Codex CLI:

```sh
nix run .#record-demo
nix run .#record-demo -- sixty
```

The command checks out the three demo repositories under the ignored
`drafts/recordings/.work/` directory, seeds Nova's directory picker, launches
the pinned Mars build in an isolated X display, replays the workflow, and
replaces both the draft and public MP4/poster copies. The workflow requires Nix
with flakes and network access; `nix run` supplies Xvfb, Picom, FFmpeg, Git,
Xdotool, Xwallpaper, and every remaining capture command.

- `nova-day-to-day.mp4` and `nova-day-to-day-poster.png`: Mars is captured at
  1784 by 996 pixels and 30 frames per second from `yzx launch`. Nova runs
  Nushell with its pinned Starship prompt and Nerd Font file icons. The capture
  explicitly unsets `NO_COLOR` so managed Yazi renders its full theme. The clip
  keeps Rust from Ratconfig, Starcompass, and Anima open in Helix. In Yazi,
  `Alt z` retargets the third tab
  to Anima. From Helix, `Alt r` reveals `boids.rs` in the full Yazi popup; the
  next file opens back in the managed editor. The clip also toggles the sidebar,
  traverses horizontally to the next tab while the hidden sidebar is skipped,
  restores the sidebar, reorders the tab, and opens and moves a Nu pane. The
  Ratconfig popup jumps directly to Zellij with `5`, expands all settings with
  `a`, and switches Zellij's pane corners off and back on live. A three-second
  Anima Mandelbrot popup follows through `yzx anima`. The clip starts a fresh
  `gpt-5.6-sol` session at xhigh reasoning in Nova's managed agent popup, asks a
  short question, leaves it running in the Ratconfig tab during the workspace
  tour, and returns to the completed answer. At Lucca's request, Codex selected
  `partenoxenese-blue-faro.jpg` from his active COSMIC wallpaper carousel. Mars
  renders its 0.88 opacity over that wallpaper through Picom. JetBrains Mono at
  16 pixels and 1.12 line height match Nova and the Home Manager configuration;
  the fixed Reef cursor preserves Mars's animated cursor trail reproducibly.
  The complete Nova Bar remains visible beside three tabs. FFmpeg encodes the
  native 30 FPS H.264 stream with no audio. Reduced-motion visitors see the
  matching poster.
- `nova-in-60-seconds.mp4` and `nova-in-60-seconds-poster.png`: the
  "Nova in under 60 seconds" take. Take A's pacing with a MoveTab sweep (3 → 2 → 1 → 2 → 3), four stacked panes running
  commands, pane traversal, one pane moved through the stack, and a fast Codex
  session on the Nova repository asked about ownership.
- `nova-day-to-day-session.mp4` and `nova-day-to-day-session-poster.png`: the
  same pinned inputs and feature inventory, replayed with longer dwell after
  each mode change so agent, tabs, Yazi, sidebar, Ratconfig, and Anima can be
  compared against the current take without replacing it.
- `ratconfig-nova-v1.png`: the same pinned Mars run opens `yzx config` against
  an absent user configuration and captures Ratconfig at 1784 by 996 pixels.

SHA-256:

```text
21ba29fe104b58c943ea8a8e62f0ebab64e1fed0f5ec03bd93cf614732773ad4  nova-day-to-day.mp4
9baf062bbe2b184cd025e2f0f95f1b28b7598b41c851802e3a14a92c8f2ca2c4  nova-day-to-day-poster.png
a44fa6893458b70a46eadf254631a6a63ea7c52a443dcbeb4c971874ab5b09ba  nova-day-to-day-session.mp4
8978af55d5b4fad8e511c2ffbd7a4da607c879ec5dbb67ba68d25da8e170186e  nova-day-to-day-session-poster.png
9d5b511b9bcdb86c22b0ae6fbf5149fb2a8362e23f96c40530ef6e0c38e98eb7  nova-in-60-seconds.mp4
8fec5c9792f3d90f612b7e4867728970714714d0b0f326648b80ebba7a7b889e  nova-in-60-seconds-poster.png
623cc1382ad767970da1ca0324242183b795165d01b256ae8170cc268d56e5bd  partenoxenese-blue-faro.jpg (source)
dd68bae922ba53a2b47aa96dd84dc70b850ef4fb612693805959da68a7ceb979  ratconfig-nova-v1.png
```
