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
- Homepage loops in `watch/`: muted native 1784 by 996 cuts. Project tabs,
  stacked panes, and the agent popup come from `nova-in-60-seconds.mp4`. Yazi
  and git come from `nova-popups.mp4`. Live config comes from
  `nova-appearance.mp4` (Ratconfig `appearance.mode` dark/light). Rebuild with
  `bash drafts/recordings/cut-home-loops.sh`.
- Popup loops in `watch/`: Yazi and git cuts from `nova-popups.mp4`. That take
  stays in `drafts/media/` and is not copied into the blog public path. Recapture
  with `bash drafts/recordings/record.sh popups`, then rebuild the cuts.
- Appearance take in `drafts/media/`: `nova-appearance.mp4` opens Ratconfig,
  searches `appearance.mode`, and switches dark to light and back. Recapture
  with `bash drafts/recordings/record.sh appearance`. Do not copy that take into
  the blog public path.
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
ef63dabb6979e5f7c9faaff74b04bbe2b7a4a578961753007de716d076157d9a  nova-in-60-seconds.mp4
b3ae13d0a8b98037a7dc65bcfbcab2cd75afe9f7f970efa3e0838f82f5f47ce1  nova-in-60-seconds-poster.png
2f5faf216c5eb7850a0a5fed9a9e950632aaf8926cec6cb5d5a7f47c605ab18a  watch/project-tabs.mp4
ce1346f7f821540ab5dd84bfcc1a874fdbebb52dc83ee707c31c8d63944bf2f4  watch/project-tabs-poster.png
9672980f74bd1ca3b25488d08e1f92d7f43bc41ffda4bf538f3196f1464cbea9  watch/stacked-panes.mp4
ccbd41866d572225d711162b99cff873cceeb29b94ea7e7143de420bafb41c8d  watch/stacked-panes-poster.png
99baecc1f42c46a1aa639f2196e72c67759c1c0a4e97b2dc5884c2a031885cf1  watch/ratconfig-popup.mp4
645ee5e388560f8ada69af0387693fdd358e9c45480f690511507bcbd3bdce32  watch/ratconfig-popup-poster.png
942e7cf32a8b23e0f3aa1ce35c1752bb9b8d5a472bb4d6582e844bd951b993dd  watch/agent-popup.mp4
664af2655db57a8d311583129b92aa16563cc0b2cc12e049e11207218ad3a32c  watch/agent-popup-poster.png
8f1e14817068de5e51586e439a5b5c20e65146df6d5f89aed062ae1bc1fce1a3  watch/yazi-popup.mp4
02e426edaa0bcbbe54e6cde3439d16aa48e2b480f4eef3022dc93d3a700b1b90  watch/yazi-popup-poster.png
7524345152cf2c83c310bd4d0c394c11b537eabe89b468786595a9156ff55a98  watch/git-popup.mp4
2936b5698794b7c1ed112edeadeb819fed08c6e1126331c5c62a2e2f88bf8ec2  watch/git-popup-poster.png
6f5dcaee244972c2022b802579f650b5c594bcd41260e232a633a63771ef3d40  nova-popups.mp4
407623ef62bb4916d76a95028be4d56030aa485b1c673a66beadf9a88aa9227a  nova-popups-poster.png
c737818384c48cf39748672de157e6d0c29d3a4974c62d9a87476d82ea040c3c  nova-appearance.mp4
faa89f9348e99958b22b58082451286a13ca18d4cb2be732ad3066c87132c54f  nova-appearance-poster.png
623cc1382ad767970da1ca0324242183b795165d01b256ae8170cc268d56e5bd  partenoxenese-blue-faro.jpg (source)
dd68bae922ba53a2b47aa96dd84dc70b850ef4fb612693805959da68a7ceb979  ratconfig-nova-v1.png
```
