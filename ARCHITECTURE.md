# Architecture

This repository builds and publishes the static Yazelix Nova website at
`https://nova.yazelix.com`. It owns Nova presentation. The canonical
[Yazelix repository](https://github.com/Yazelix/nova) owns product
commands, configuration, packages, keybindings, and release truth.
[README.md](README.md) records the exact revision used for site claims and media.

Yazelix is the family brand. Yazelix Nova and Yazelix Eon are parallel product
lines with independent architecture, documentation, release evidence, and
site owners. The apex domain and Eon site remain outside this repository;
`nova.yazelix.com` is the permanent Nova origin.

## System flow

```text
canonical Yazelix evidence
  -> Markdown, media data, Astro pages, and components
  -> Astro + Starlight static build
  -> HTML, assets, Pagefind index, sitemap, robots, and 404
  -> Vercel production deployment
  -> Hostinger DNS + Vercel TLS
  -> browser
```

Most behavior ends at build time. The combined Docs rail and Starlight theme
provider contain the browser JavaScript. The site has no server runtime,
database, API, authentication, analytics, or CMS.

## Route and content ownership

| Public surface | Owner |
| --- | --- |
| `/` | `src/pages/index.astro`; compact product identity, Stable install path, and three media previews |
| `/features/` | `src/pages/features.astro`; the complete visual tour assembled from the media registry |
| `/docs/` | `src/pages/docs/index.astro`; the canonical Start chapter and one ordered stream rendered from the shared Docs collection, plus prefixed anchors and the active-section rail |
| `/start/` | Compatibility redirect to `/docs/#start`, owned by `astro.config.mjs` |
| `/blog/` | `src/pages/blog/index.astro`; published Nova articles |
| Task and reference Docs | Markdown under `src/content/docs/`; `src/content.config.ts` loads it for `/docs/` and, except for Start, standalone Starlight pages |
| Standalone Docs shell and search | `astro.config.mjs` configures Starlight; the production build generates Pagefind |
| Canonical and social metadata on custom pages | `src/components/SiteHead.astro`, using the permanent origin from `astro.config.mjs` |
| Sitemap and 404 | The Astro/Starlight build generates both surfaces |
| Robots policy | `public/robots.txt` |

`docs/site_shape.md` owns the information-architecture and media policy. The
route files own composition, while Markdown owns task and reference prose. The
combined Docs page consumes the same collection as the standalone pages rather
than maintaining another copy of the content. Start is the first combined Docs
chapter; its draft flag suppresses a duplicate Starlight route while Astro keeps
`/start/` as a compatibility redirect.

Blog infrastructure follows published content. The Nova v1 article is a static
Astro route with Markdown sourced from `drafts/yazelix-nova-v1.md`.

## Components and styles

| Owner | Responsibility |
| --- | --- |
| `src/components/SiteHead.astro` | Shared document head, canonical URL, Open Graph, Twitter card, favicon, and social image for custom pages |
| `src/components/SiteNav.astro` | Shared custom-page navigation, active state, brand link, and skip link |
| `src/components/SiteFooter.astro` | Shared custom-page footer with Start, sponsor, and GitHub |
| `src/components/GitHubLink.astro` | The external canonical repository action and its separate-tab affordance |
| `src/components/PrefixedDocsContent.astro` | Build-time heading and fragment identity for the combined Docs stream |
| `src/data/home_watch.ts` | Home stage clips and Features pane/popup loop registry |
| `src/data/feature_media.ts` | Workspace still identity, caption, and Docs destination |
| `src/components/FeatureMediaFrame.astro` | Static media rendering, intrinsic dimensions, lazy loading, captions, and Docs link |
| `src/components/starlight/ThemeProvider.astro` | First-load Starlight theme selection and picker synchronization |
| `src/styles/home.css` | Custom-page visual system, shared shell, product tour, Blog panels, and responsive navigation |
| `src/styles/docs.css` | Combined Docs layout, rail, Markdown presentation, and responsive fallback; imports `home.css` |
| `src/styles/starlight.css` | Starlight color/type tokens and narrow standalone-Docs overrides |

Custom pages use `SiteHead`, `SiteNav`, and the custom CSS owners. Standalone
Docs use Starlight's shell and metadata. A change should extend the owner for
its route class instead of recreating that policy in a page.

## Build and verification

`flake.nix` and `flake.lock` pin developer CLI and browser versions. The
development shell supplies Bun, Node.js, the exact Chromium closure used by
Playwright, source and workflow linters, FFmpeg, and recording tools. It also
prevents Playwright from downloading or selecting a separate browser.
`package.json` owns developer commands, while `bun.lock` independently pins the
JavaScript dependency graph. Production installation uses
`bun install --frozen-lockfile`.
`astro.config.mjs` owns the permanent site origin, Starlight integration,
sidebar, and theme override. Astro emits static output because the repository
configures no adapter or server output. Generated output lives in `dist/`.

The verification layers prove different contracts:

| Check | Proves |
| --- | --- |
| `bun run check:typos` | Repository prose and source match the typo policy |
| `bun run check` | Astro, content, and TypeScript diagnostics |
| `bun run build` | Static routes, Pagefind, sitemap, assets, and build-time content composition |
| `bun run test:e2e` | Built static output, Pagefind, assets, 404 behavior, representative routes, metadata, navigation, content invariants, links, Docs rail behavior, overflow, and Blog absence contracts |
| Production inspection | The deployed revision, DNS, TLS, cache behavior, Pagefind, canonical URLs, routes, assets, and rollback surface delivered to visitors |

Local source-tree checks do not prove Vercel publication, DNS, TLS, or the
browser experience at the public origin. Provider and rollback evidence live
in Beads; the accepted launch record is
`yazelix-site-launch-accurate-nova-site-pfz.9`.

## Deployment ownership

The Vercel Git integration watches `main` as the production source branch.
It remains independent of the developer shell: `vercel.json` is the only
deployment configuration, and Vercel installs the frozen Bun graph, runs
diagnostics and the static build, and publishes `dist/`.
Vercel owns the deployed artifact, edge delivery, managed TLS, and deployment
rollback.

Hostinger remains authoritative for DNS and owns only the narrow
`nova.yazelix.com` record that points at Vercel. It does not build or serve the
site. The apex and `eon.yazelix.com` remain independent, so their future
deployment choices do not move or recanonicalize Nova.

## Change rules

- Reconcile public claims to canonical Yazelix source before editing them, and
  update the exact revision in `README.md` when the public contract changes.
- Keep media provenance in `docs/site_shape.md`; keep media copy and crop data
  in the registry and rendering behavior in the component.
- Add a custom route to the shared custom-page head/navigation contracts, or
  add a Docs route through the Starlight collection. Do not create a third
  shell.
- Keep the Blog content-driven: article machinery exists only when an approved
  article consumes it.
- Keep Vercel as the sole publication owner and Hostinger as the DNS owner
  unless an explicit provider decision replaces that contract.
- Record planning decisions and external proof in Beads. Keep implementation
  truth in repository source and current operational evidence with the owner
  that produces it.

Update this document when a route class, content owner, shared component,
build boundary, verification layer, deployment provider, DNS owner, or product
boundary changes. Ordinary copy and styling edits do not require an
architecture update.
