# Yazelix Site Shape

This document records the information architecture for `nova.yazelix.com`, the
permanent Yazelix Nova site. Exact commands and product behavior remain owned
by the canonical Yazelix repository.

## Product Boundary

Yazelix is the master brand. Yazelix Nova and Yazelix Eon are parallel product
lines with separate architecture, documentation, and release evidence. This
site covers Nova. The root domain and the Eon site have separate owners.

## Principle

The site should make Nova understandable without turning the homepage into a
manual or the docs into a media archive.

- The homepage previews the product
- The features page owns the focused visual tour
- The docs own exact usage, reference, recovery, and settings behavior
- The blog owns narrative, release writing, and design notes when approved

## Routes

### `/`

The homepage stays compact: product identity, the maintained workspace image,
the install path, primary links, and three focused previews from the same
accepted image. It does not carry terminal variants, exhaustive settings,
keybinding tables, or recovery/update details.

### `/features/`

The launch tour uses one current Nova workspace image and four views:

1. The complete workspace composition
2. Yazi beside the managed editor
3. Runtime and Nova identity in the top bar
4. The visible keyboard map in the bottom bar

The focused views are CSS crops of the same source image. They add no duplicate
download and make no behavior claim beyond what the image shows. Add a separate
capture only when motion or a second state materially explains a stable public
contract.

### `/docs/`

The docs index remains a continuous task/reference stream. Individual docs
pages stay available for direct links and search. A docs section can reuse the
accepted workspace media only when it clarifies the exact task.

### `/blog/`

Blog posts carry approved release essays, product reasoning, architecture
writing, and lessons. The blog is not a source of truth for runtime behavior.

## Media Contract

The accepted launch source is:

- canonical repository revision: `37f36efcabf16c41d03e182917926e7b8e56139c`
- source: `assets/screenshots/nova_workspace.png`
- site asset: `public/images/nova_workspace.png`

Every public image or clip must record current Nova provenance. Stale Classic
captures, planned placeholders, and media kept only to fill a gallery do not
ship.

Static images are the default. Motion is justified only when a still cannot
communicate the behavior honestly. Any future motion media must:

- use a short muted video with a poster rather than an animated GIF
- lazy-load outside the first viewport
- keep a stable aspect ratio
- remain understandable without motion
- avoid autoplay when reduced motion is requested
- link to the exact docs contract

The small media registry owns titles, captions, focus, and docs links. The
component owns rendering. Neither layer reconstructs product behavior.

## Layout Rules

The homepage uses three compact preview cards. The features page uses one large
row per view so the terminal content stays readable. Both surfaces collapse to
one column on narrow screens.

## Future Capture Gate

There is no standing capture backlog. Add one accepted media item when all of
these are true:

- the user-facing behavior is current and documented
- a still or clip can be captured from an accepted Nova revision
- the media explains the behavior better than text alone
- its download, motion, and maintenance cost is justified

Do not launch a GUI capture session or restore the Classic catalog merely to
make the tour larger.
