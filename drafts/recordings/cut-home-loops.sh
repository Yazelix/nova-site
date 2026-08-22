#!/usr/bin/env bash
set -euo pipefail

# Cut Home and Features loops from the published sixty-second take, the
# drafts-only popup take, and the appearance.mode take. Re-run after
# recapturing a source.

readonly REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
readonly SIXTY="$REPO_ROOT/public/blog/yazelix-nova-v1/media/nova-in-60-seconds.mp4"
readonly POPUPS="$REPO_ROOT/drafts/media/nova-popups.mp4"
readonly APPEARANCE="$REPO_ROOT/drafts/media/nova-appearance.mp4"
readonly DRAFT_DIR="$REPO_ROOT/drafts/media/watch"
readonly PUBLIC_DIR="$REPO_ROOT/public/media/watch"

if ! command -v ffmpeg >/dev/null; then
	printf 'ffmpeg is required\n' >&2
	exit 1
fi
[[ -f "$SIXTY" ]] || {
	printf 'Missing source clip: %s\n' "$SIXTY" >&2
	exit 1
}
[[ -f "$POPUPS" ]] || {
	printf 'Missing source clip: %s\n' "$POPUPS" >&2
	exit 1
}
[[ -f "$APPEARANCE" ]] || {
	printf 'Missing source clip: %s\n' "$APPEARANCE" >&2
	exit 1
}

mkdir -p "$DRAFT_DIR" "$PUBLIC_DIR"

cut_loop() {
	local src="$1" name="$2" start="$3" duration="$4" poster_offset="$5"
	local out="$PUBLIC_DIR/${name}.mp4"
	local poster="$PUBLIC_DIR/${name}-poster.png"

	ffmpeg -hide_banner -loglevel error -y \
		-ss "$start" -i "$src" -t "$duration" \
		-an -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p \
		-movflags +faststart \
		"$out"

	ffmpeg -hide_banner -loglevel error -y \
		-ss "$poster_offset" -i "$out" -frames:v 1 \
		"$poster"

	cp "$out" "$DRAFT_DIR/${name}.mp4"
	cp "$poster" "$DRAFT_DIR/${name}-poster.png"
}

# Hold the first frame so the tiled workspace is readable before a popup opens.
cut_popup_loop() {
	local src="$1" name="$2" start="$3" duration="$4" hold="$5" poster_offset="$6"
	local out="$PUBLIC_DIR/${name}.mp4"
	local poster="$PUBLIC_DIR/${name}-poster.png"

	ffmpeg -hide_banner -loglevel error -y \
		-ss "$start" -t "$duration" -i "$src" \
		-an -vf "tpad=start_duration=${hold}:start_mode=clone,fps=30" \
		-c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p \
		-movflags +faststart \
		"$out"

	ffmpeg -hide_banner -loglevel error -y \
		-ss "$poster_offset" -i "$out" -frames:v 1 \
		"$poster"

	cp "$out" "$DRAFT_DIR/${name}.mp4"
	cp "$poster" "$DRAFT_DIR/${name}-poster.png"
}

# Timestamps match the article timeline on nova-in-60-seconds.mp4.
cut_loop "$SIXTY" project-tabs 13.2 3.8 1.6
cut_loop "$SIXTY" stacked-panes 20.2 4.0 1.6

# Popup loops hold the workspace ~2s, then open. Hold is cloned first frame.
cut_popup_loop "$SIXTY" agent-popup 1.4 6.0 1.2 2.8
cut_popup_loop "$POPUPS" yazi-popup 0.0 5.2 1.2 2.6
cut_popup_loop "$POPUPS" git-popup 5.2 5.4 1.2 2.4

# Timestamps match drafts/media/nova-appearance.mp4.
cut_loop "$APPEARANCE" ratconfig-popup 4.6 6.4 1.6

sha256sum \
	"$DRAFT_DIR"/project-tabs.mp4 \
	"$DRAFT_DIR"/project-tabs-poster.png \
	"$DRAFT_DIR"/stacked-panes.mp4 \
	"$DRAFT_DIR"/stacked-panes-poster.png \
	"$DRAFT_DIR"/ratconfig-popup.mp4 \
	"$DRAFT_DIR"/ratconfig-popup-poster.png \
	"$DRAFT_DIR"/agent-popup.mp4 \
	"$DRAFT_DIR"/agent-popup-poster.png \
	"$DRAFT_DIR"/yazi-popup.mp4 \
	"$DRAFT_DIR"/yazi-popup-poster.png \
	"$DRAFT_DIR"/git-popup.mp4 \
	"$DRAFT_DIR"/git-popup-poster.png
