# Yazelix Nova Site

Source repository for `https://nova.yazelix.com`, the permanent Yazelix Nova
website.

Yazelix is the master brand. Yazelix Nova and Yazelix Eon are parallel product
lines with separate architecture, documentation, and release evidence. This
repository covers Nova only.

## Stack

- Astro
- Starlight
- MDX and Markdown content
- Pagefind search through Starlight
- Playwright smoke tests

[ARCHITECTURE.md](ARCHITECTURE.md) maps product, route, component, build,
verification, deployment, and DNS ownership.

## Commands

```sh
bun install
bun run dev
bun run check
bun run build
bun run test:e2e
```

The reproducible Nova demo workflow lives in
[`drafts/recordings/`](drafts/recordings/). Run
`nix run .#record-demo` to rebuild its MP4 and poster from pinned
product, demo-repository, capture-tool, and rendering inputs.
[Kinestra](https://github.com/Yazelix/kinestra), pinned in `flake.lock`, owns the
isolated X11 display, window lifecycle, recording and poster helpers. Nova's
product pins, appearance and keyboard sequences live in
`drafts/recordings/record.rs`, compiled against the pinned Rust library.
`nix run .#record-demo -- anima` records Mandelbrot followed by predator boids.
Recording is an x86_64 Linux development tool; it is separate from Nova's
installed runtime.

## Product Source

The canonical [Yazelix repository](https://github.com/Yazelix/nova)
owns Nova behavior. Site copy and media were checked against revision
`e733f1996c4d3997ab091415a39607a2154d2378`, including:

- `README.md` for the public product and command surface
- `docs/installation.md` for channels, packages, updates, and Home Manager
- `docs/configuration.md` for settings and native files
- `ARCHITECTURE.md` for runtime and ownership boundaries

Update the recorded revision when the public contract changes. Keep uncertain
or unsupported behavior off the site.

## Site Shape

The information architecture is documented in
[docs/site_shape.md](docs/site_shape.md). The short version is:

- `/` stays a compact homepage with product identity, install path, and a few strongest demos
- `/features/` owns the focused Nova product tour
- `/docs/` starts with the Start guide and continues through the task and reference docs
- `/blog/` lists published Nova articles
