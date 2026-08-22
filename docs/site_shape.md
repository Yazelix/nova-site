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
- The Blog lists source-backed Nova articles

## Routes

### `/`

The homepage stays compact: product identity, the maintained workspace image,
the Stable install path, two three-chapter motion stages, and the HJKL
movement grid. It does not repeat the primary nav as recap cards, and it does
not carry terminal variants, exhaustive settings, or recovery/update details.

### `/features/`

Features is a job-grouped visual tour, not a media-type gallery. Clip captions
stay experiential; they do not badge each demo as native, config, or
Yazelix-only. The page can point at `/docs/nova-and-zellij/` so Zellij users
can see what the multiplexer owns versus Yazelix packaging and the fork.

The tour uses:

1. One full workspace still
2. Project tabs and stacked panes as looping clips
3. Popup tools as looping clips: Yazi, git, agent, Ratconfig, and Anima
4. A short Zellij ownership note
5. A named-sessions pointer into Start

Do not CSS-zoom the workspace still. Add a clip when motion explains a stable
public contract better than a still. Home stages popup tools, then panes plus
sidebar, live Zellij theme, and Anima. Features repeats those clips inside their
groups plus project tabs. The HJKL grid on Home is copy, not a recording.

### `/docs/`

The docs index remains a continuous task/reference stream. Individual docs
pages stay available for direct links and search. A docs section can reuse the
accepted workspace media only when it clarifies the exact task. `Nova and
Zellij` owns the multiplexer split: Zellij primitives, Yazelix layout and
plugins, and the Nova Zellij fork delta.

### `/blog/`

The Blog stays in primary navigation and lists source-backed published
articles. The Blog does not own runtime behavior.

## Media Contract

The accepted launch source is:

- canonical repository revision: `e2ddb4d4901ed99c75c615e039428ea9c7e1e46f`
- source: `assets/screenshots/nova_workspace.png`
- site asset: `public/images/nova_workspace.png`

Every public image or clip must record current Nova provenance. Stale Classic
captures, planned placeholders, and media kept only to fill a gallery do not
ship.

Static images are the default. Motion is justified only when a still cannot
communicate the behavior honestly. Motion media must:

- use one short muted video with a poster
- load eagerly only at the top of an article
- keep a stable aspect ratio
- replace animation with the still when reduced motion is requested
- link to the exact docs contract

The small media registry owns titles, captions, focus, and docs links. The
component owns rendering. Neither layer reconstructs product behavior.

## Layout Rules

The homepage uses two motion stages with chapter buttons, then the HJKL table.
The features page uses one large row per clip or still so the terminal content
stays readable. Both surfaces collapse to one column on narrow screens. Custom
pages share the same footer.

## Future Capture Gate

There is no standing capture backlog. Add one accepted media item when all of
these are true:

- the user-facing behavior is current and documented
- a still or clip can be captured from an accepted Nova revision
- the media explains the behavior better than text alone
- its download, motion, and maintenance cost is justified

Do not launch a GUI capture session or restore the Classic catalog merely to
make the tour larger.
