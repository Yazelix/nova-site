---
title: Update Yazelix Nova
description: Update the Nix profile or declarative input that owns the installed package.
---

Choose one update owner for each Yazelix install.

## Profile installs

Confirm the installed profile entry when needed:

```bash
nix profile list
```

Upgrade the profile-owned package:

```bash
nix profile upgrade --refresh yazelix
```

Pass the exact installed package name when your profile uses another entry
name.

## Home Manager installs

Run this from the configuration that declares the Yazelix input:

```bash
nix flake update yazelix
```

Replace `yazelix` with your input name, then run the configuration's normal
Home Manager or nix-darwin switch command. Do not use `nix profile upgrade` for
a package installed by Home Manager.

## Channels

The update follows the input's `stable`, `main`, `edge`, or immutable tag
reference. Stable is the normal release channel. Main receives accepted updates
more often, and Edge carries experimental dogfood changes.

## Live windows

The updated package applies to future launches. Open Nova sessions keep their
current immutable Nix store paths until you close and relaunch them.

See the canonical [update guide](https://github.com/luccahuguet/yazelix/blob/stable/docs/installation.md#updates)
for package-owner details.
