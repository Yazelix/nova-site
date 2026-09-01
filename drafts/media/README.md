# Nova recording media

This directory keeps the source captures used by the current Nova site. Public
Home and Features loops are cut from these files into `public/media/watch/`.
The separate Nova v1 article and its media remain frozen history.

## Current Stable captures

The accepted captures use Nova 1.1 Stable at
`16810b21ef76e98057707c3bb18068a04ba4a350`. The recorder also pins the public
repositories shown in the workspace:

| Source | Revision | Branch label in the demo |
| --- | --- | --- |
| `Yazelix/nova` | `16810b21ef76e98057707c3bb18068a04ba4a350` | `stable` |
| `Yazelix/ratconfig` | `675a21f17900df47585b2a8290c5436204d120e4` | `main` |
| `Yazelix/starcompass` | `621bc6fcec916521c116e89d1ae8b146973145d5` | `edge` |
| `Yazelix/anima` | `ea6cbedd3e5e9292b5d730003a5a9020389451f2` | `main` |
| Nixpkgs recording toolchain | `e9a7635a57597d9754eccebdfc7045e6c8600e6b` | n/a |

Run one capture with:

```sh
nix run .#record-demo -- original
```

Other supported variants are `session`, `popups`, `appearance`, `yazi`,
`live`, and `anima`. Rebuild the public loops after recapturing their sources:

```sh
bash drafts/recordings/cut-home-loops.sh
```

`record.sh` verifies the cached clones, copies them to a fresh
`/tmp/nova-site-recording.*` tree, and gives the demo only those public paths.
Nova starts with `yzx launch` under Xvfb and its packaged Rio terminal. Config,
state, Atuin history, and zoxide data are isolated. The script resolves the
same Zellij binary from the pinned Nova Nix closure for startup cleanup and
teardown, then refuses to accept a capture while its recording socket remains.

The Stable Rio template at this revision points Noto Fonts at `share/noto` and
names `Noto Sans Symbols2`. The installed font uses `share/fonts/noto` and the
family name `Noto Sans Symbols 2`. For legible recordings, the script corrects
those two values only in its temporary copy of Rio's config. It does not change
the pinned Nova checkout or claim that Stable already contains the fix.

The agent popup is a real local Codex CLI. The accepted capture used Codex
0.151.0 with `gpt-5.6-sol` at medium reasoning. The recorder gives the verified
public Nova clone a process-local trust entry, disables every configured MCP
server plus apps and plugins for that process, types a harmless prompt, and
never submits it. No agent turn or tool call is part of the recording.

All current MP4 files are muted H.264 at 1784 by 996 pixels and 30 frames per
second. Their matching PNG files are reduced-motion posters.

- `nova-day-to-day.*`: project tabs, the unsubmitted agent composition, Yazi,
  sidebar navigation, tab movement, stacked panes, Ratconfig, and Anima. The
  workspace still at `public/images/nova_workspace.png` is captured from the
  same setup.
- `nova-day-to-day-session.*`: the same workflow with longer dwell times for
  review.
- `nova-popups.*`: Yazi followed by Lazygit.
- `nova-appearance.*`: Ratconfig changes a live Zellij setting and restores it.
- `nova-yazi.*`: Helix reveals a file in Yazi and opens another file back in
  the managed editor.
- `nova-live.*`: sidebar, stacked shells, pane movement, and Anima.
- `nova-anima.*`: Mandelbrot followed by `boids_predator`.
- `watch/*`: current Home and Features loops cut only from the captures above.
  `project-tabs` and `agent-popup` use `nova-day-to-day.mp4`; no current loop
  reads the frozen v1 video.

## Frozen Nova v1 media

`nova-in-60-seconds.*` and `ratconfig-nova-v1.png` document the original
Mars-based Nova v1 article. The public copies under
`public/blog/yazelix-nova-v1/media/` are immutable. They are not inputs to the
current Stable site or its loop cutter.

## SHA-256

Current source captures:

```text
b21472f0aa894f573c1ba01279bc0c4cea04732c3f311e478554f3e264a5ec00  nova-day-to-day.mp4
efe8304fbc0dced5be05bd38c5e55afe8d03bcad9071a815cb2e19d66746d580  nova-day-to-day-poster.png
21e5add653e62dbc4fd34859836bf4b199f901a5d098130f4f66d528d193349c  nova-day-to-day-session.mp4
b8c38dff630349d2411acd133ce3da2d7f8d871486c572091b23f8d429147402  nova-day-to-day-session-poster.png
a4331bfcf2b1ae7d020f9e3d1b16ddd5d5b61a018ca84ab836bc46f3286d4f69  nova-popups.mp4
48a0c49b7fe04e274cd941603b6325e0528ad1c360b0dbfdafdad68be73eba24  nova-popups-poster.png
b809ad70d7e0793d60fb21f78d39130331660ed049e53bd07f36086e0973b221  nova-appearance.mp4
7d628d9adeecd5c7094e67898444589b5157fbfb05381afaf0d3688cf1f4a6ac  nova-appearance-poster.png
ea5b5080061d97e321e4d2c89695fffb406d5e0486d0807d6ca153895126b8c7  nova-yazi.mp4
e18cd6eed90ce0f3305caafe782ffe3c12768c6a8e2c11aacf8e4b2c42a89087  nova-yazi-poster.png
82bf0806936168814e7671dc770bb1a2a9f8c263ad33c828bbe2a42370f175ea  nova-live.mp4
fbbe943bf0ad9a12b4b66661e9f3cbed68e1158bac88db55045880d0a1960fb1  nova-live-poster.png
c841552f227ea86e0c922d5453b114b75b15dda367d0945612b631b8efc79cf8  nova-anima.mp4
f875966c2ed949bbbede3347b5e904dccec2f2bf110492d0b68222b251142405  nova-anima-poster.png
```

Current loop files (the draft and public copies are byte-identical):

```text
dc5d6b97543334beee76218b90e690eaa42108171c7d4ae3206a068260f9fbfa  watch/project-tabs.mp4
8354324a43b65fc6ffabb7afaf73d349204e49311e4eea6dd127005ea2887c4c  watch/project-tabs-poster.png
e920a43d0999a535c7e7d215f20c7789eb50043d7bdb1a3ee48a0c008c021453  watch/stacked-panes.mp4
00bbde4a51246808021465d8f330a3fbc9940a260bd910fd931e00ce02421810  watch/stacked-panes-poster.png
06ba2ac089b54d2ce5e85a4d2073c57c4042a324df09c32c4538dce0e9241de1  watch/ratconfig-popup.mp4
af29cf2817352ac1286ec7553f1e8a64c2c91c766d684530261300ece75add1d  watch/ratconfig-popup-poster.png
33ec7f25d32fda28a32101b1c015f0f72b1f4731099713b7c0cd0f91b5ee7355  watch/agent-popup.mp4
e7a9e8f6d61fcf27bc01482bd664481cb20c556cd6a28f3b9d914cd337a36ef1  watch/agent-popup-poster.png
37faba0679b64e9d588f0dbf1c5e9cc93d992d45664678303099e3ef779a1c9c  watch/yazi-popup.mp4
49de09ae8fe5077aad40df7932a91ea36a377590fa4b44e69d16b729dc0ad9e0  watch/yazi-popup-poster.png
d53122ca3b4d4ebc0a71299099f5daac912f0649987f2c41411869c3a83a2892  watch/git-popup.mp4
fb8dd74d48d98418d7b8e2043e2a6dad5f718a9c1f474a6a08feac0d273e17ba  watch/git-popup-poster.png
90a2bc7959394fefe6388f9469cc494ff33e9a9c2050b7528087ebb379a030f3  watch/anima-popup.mp4
574d8f7299e29a891db44a3dfdb3ba8a80c100d8894d41fd48d72733cb8d1c27  watch/anima-popup-poster.png
```

Still, wallpaper, and frozen v1 assets:

```text
e2f90d1acfde7ed7ce2cadb47a2a709b8fb13f87b266545f0532a1c56bed1f2f  public/images/nova_workspace.png
623cc1382ad767970da1ca0324242183b795165d01b256ae8170cc268d56e5bd  partenoxenese-blue-faro.jpg
0c69eb0b80a88ef1b5b7b44bda90a5891e20fc58a014a8b189541a14fa6cf31b  nova-in-60-seconds.mp4
fb2ffd30b68bb08ddcc959155b99222eee47f1b4af10ca795cf4b2ec6322c4e7  nova-in-60-seconds-poster.png
dd68bae922ba53a2b47aa96dd84dc70b850ef4fb612693805959da68a7ceb979  ratconfig-nova-v1.png
```
