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

## Commands

```sh
bun install
bun run dev
bun run check
bun run build
bun run test:e2e
```

## Product Source

The canonical [Yazelix repository](https://github.com/luccahuguet/yazelix)
owns Nova behavior. Site copy and media were checked against revision
`37f36efcabf16c41d03e182917926e7b8e56139c`, including:

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
- `/docs/` is a single-page scroll version of the task and reference docs
- `/blog/` carries approved essays, release writing, and design notes
