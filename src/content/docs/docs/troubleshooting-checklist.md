---
title: Nova Troubleshooting Checklist
description: Check the owned runtime, package source, config input, and generated-state boundary.
---

## 1. Run doctor

```bash
yzx doctor
```

## 2. Check command ownership

```bash
type yzx
command -v yzx
```

The command should resolve to your Nix profile or Home Manager owner path, not an old `~/.local/bin/yzx` wrapper or shell function.

## 3. Refresh stale flake evaluation

```bash
nix profile upgrade --refresh yazelix
```

Home Manager users update their declared input and run the normal switch.

## 4. Inspect config

```bash
yzx config
```

The optional root file is `~/.config/yazelix/config.toml`. Back it up before
manual recovery. Ratconfig exposes invalid fields and exact native-file actions.

## 5. Keep generated state generated

Do not manually edit:

```text
~/.local/share/yazelix
```

Relaunch Nova after fixing the owning input. Open sessions keep their existing
package and next-session settings.

## 6. Report precise failures

Useful issue details:

- OS and architecture
- install owner: Nix profile, Home Manager, or one-off `nix run`
- `yzx --version`
- `yzx doctor`
- `yzx status` or `yzx status --json`
- exact command output
- whether the problem reproduces in a fresh `yzx enter` session
