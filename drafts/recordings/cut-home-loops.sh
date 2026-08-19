#!/usr/bin/env bash
set -euo pipefail

# Cut the homepage loops from the published sixty-second take.
# Re-run after recapturing nova-in-60-seconds.mp4.

readonly REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
readonly SRC="$REPO_ROOT/public/blog/yazelix-nova-v1/media/nova-in-60-seconds.mp4"
readonly DRAFT_DIR="$REPO_ROOT/drafts/media/watch"
readonly PUBLIC_DIR="$REPO_ROOT/public/media/watch"

if ! command -v ffmpeg >/dev/null; then
	printf 'ffmpeg is required\n' >&2
	exit 1
fi
[[ -f "$SRC" ]] || {
	printf 'Missing source clip: %s\n' "$SRC" >&2
	exit 1
}

mkdir -p "$DRAFT_DIR" "$PUBLIC_DIR"

cut_loop() {
	local name="$1" start="$2" duration="$3" poster_offset="$4"
	local out="$PUBLIC_DIR/${name}.mp4"
	local poster="$PUBLIC_DIR/${name}-poster.png"

	ffmpeg -hide_banner -loglevel error -y \
		-ss "$start" -i "$SRC" -t "$duration" \
		-an -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p \
		-movflags +faststart \
		"$out"

	ffmpeg -hide_banner -loglevel error -y \
		-ss "$poster_offset" -i "$out" -frames:v 1 \
		"$poster"

	cp "$out" "$DRAFT_DIR/${name}.mp4"
	cp "$poster" "$DRAFT_DIR/${name}-poster.png"
}

# Timestamps match the article timeline on nova-in-60-seconds.mp4.
cut_loop project-tabs 13.2 3.8 1.6
cut_loop stacked-panes 20.2 4.0 1.6
cut_loop ratconfig-popup 37.6 4.2 3.6

sha256sum \
	"$DRAFT_DIR"/project-tabs.mp4 \
	"$DRAFT_DIR"/project-tabs-poster.png \
	"$DRAFT_DIR"/stacked-panes.mp4 \
	"$DRAFT_DIR"/stacked-panes-poster.png \
	"$DRAFT_DIR"/ratconfig-popup.mp4 \
	"$DRAFT_DIR"/ratconfig-popup-poster.png
