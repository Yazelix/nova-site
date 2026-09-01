#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly WORK_DIR="$SCRIPT_DIR/.work"
readonly SOURCE_CACHE_DIR="$WORK_DIR/sources"
readonly OUTPUT_DIR="$REPO_ROOT/drafts/media"
readonly WORKSPACE_STILL="$REPO_ROOT/public/images/nova_workspace.png"
readonly WALLPAPER="$SCRIPT_DIR/partenoxenese-blue-faro.jpg"
readonly NOVA_REV="16810b21ef76e98057707c3bb18068a04ba4a350"
readonly WIDTH=1784
readonly HEIGHT=996
readonly VARIANT="${1:-original}"
case "$VARIANT" in
original)
	readonly CLIP_STEM="nova-day-to-day"
	readonly POSTER_OFFSET=9
	;;
session)
	readonly CLIP_STEM="nova-day-to-day-session"
	readonly POSTER_OFFSET=8
	;;
popups)
	readonly CLIP_STEM="nova-popups"
	readonly POSTER_OFFSET=2
	;;
appearance)
	readonly CLIP_STEM="nova-appearance"
	readonly POSTER_OFFSET=4
	;;
yazi)
	readonly CLIP_STEM="nova-yazi"
	readonly POSTER_OFFSET=3
	;;
live)
	readonly CLIP_STEM="nova-live"
	readonly POSTER_OFFSET=6
	;;
anima)
	readonly CLIP_STEM="nova-anima"
	readonly POSTER_OFFSET=9
	;;
*)
	printf 'usage: record.sh [original|session|popups|appearance|yazi|live|anima]\n' >&2
	exit 2
	;;
esac
TOOLCHAIN=""
NOVA=""
ZELLIJ=""
RUN_DIR=""
DISPLAY=""
NOVA_SITE_SESSION=""
xvfb_pid=""
picom_pid=""
nova_pid=""
capture_pid=""

recording_zellij() {
	if [[ -n "$ZELLIJ" && -x "$ZELLIJ" ]]; then
		printf '%s\n' "$ZELLIJ"
	fi
}

zellij_runtime_dir() {
	printf '%s/zellij\n' "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
}

recording_session_is_live() {
	local session="$1" socket
	for socket in "$(zellij_runtime_dir)"/*/"$session"; do
		[[ -S "$socket" ]] && return 0
	done
	return 1
}

# Zellij's server detaches from yzx, so killing nova_pid leaves Helix/Codex resident.
kill_recording_sessions() {
	local zellij_bin session socket
	zellij_bin="$(recording_zellij)"
	[[ -n "$zellij_bin" ]] || return 0
	if [[ -n "${1:-}" ]]; then
		for _ in $(seq 1 20); do
			"$zellij_bin" kill-session "$1" >/dev/null 2>&1 || true
			recording_session_is_live "$1" || return 0
			sleep 0.25
		done
		printf 'recording session %s did not stop\n' "$1" >&2
		return 1
	fi
	for socket in "$(zellij_runtime_dir)"/*/nova-site-recording-*; do
		[[ -S "$socket" ]] || continue
		session="${socket##*/}"
		kill_recording_sessions "$session"
	done
}

cleanup() {
	local session_stopped=1
	for pid in "$capture_pid" "$nova_pid" "$picom_pid" "$xvfb_pid"; do
		[[ -z "$pid" ]] || kill "$pid" 2>/dev/null || true
	done
	if [[ -n "$NOVA_SITE_SESSION" ]] && ! kill_recording_sessions "$NOVA_SITE_SESSION"; then
		session_stopped=0
	fi
	if [[ -n "$RUN_DIR" && -d "$RUN_DIR" && "$session_stopped" == 1 ]]; then
		case "$RUN_DIR" in
		"${TMPDIR:-/tmp}"/nova-site-recording.??????)
			"${TOOLCHAIN:+$TOOLCHAIN/bin/}rm" -rf -- "$RUN_DIR"
			;;
		*)
			printf 'refusing to remove unexpected recording directory: %s\n' "$RUN_DIR" >&2
			;;
		esac
	fi
}
trap cleanup EXIT

clone_at() {
	local name="$1" url="$2" revision="$3" branch="$4"
	local destination="$SOURCE_CACHE_DIR/$name"
	if [[ ! -d "$destination/.git" ]]; then
		"$TOOLCHAIN/bin/git" clone --filter=blob:none --no-checkout "$url" "$destination"
	fi
	if [[ "$("$TOOLCHAIN/bin/git" -C "$destination" remote get-url origin)" != "$url" ]]; then
		printf 'source %s has an unexpected origin\n' "$name" >&2
		exit 1
	fi
	if "$TOOLCHAIN/bin/git" -C "$destination" cat-file -e "$revision^{commit}" 2>/dev/null; then
		printf 'source %s: reuse %s\n' "$name" "$revision"
	else
		printf 'source %s: fetch %s\n' "$name" "$revision"
		"$TOOLCHAIN/bin/git" -C "$destination" fetch --depth 1 origin "$revision"
	fi
	"$TOOLCHAIN/bin/git" -C "$destination" checkout --force -B "$branch" "$revision"
	if [[ -n "$("$TOOLCHAIN/bin/git" -C "$destination" status --porcelain)" ]]; then
		printf 'source %s is not a clean pinned checkout\n' "$name" >&2
		exit 1
	fi
}

prepare_demo_clone() {
	local name="$1" revision="$2" branch="$3"
	local source="$SOURCE_CACHE_DIR/$name"
	local destination="$DEMO_SOURCE_DIR/$name"
	printf 'demo source %s: copy pinned working tree\n' "$name"
	cp -a "$source" "$destination"
	"$TOOLCHAIN/bin/git" -C "$destination" checkout --quiet --force -B "$branch" "$revision"
}

key() {
	"$TOOLCHAIN/bin/xdotool" key --clearmodifiers "$1"
	sleep "${2:-0.35}"
}

type_text() {
	"$TOOLCHAIN/bin/xdotool" type --delay 45 -- "$1"
}

type_readably() {
	"$TOOLCHAIN/bin/xdotool" type --delay 80 -- "$1"
}

play_original() {
	sleep 0.8
	key alt+shift+l 3
	type_readably "Summarize public Nova behavior without using tools."
	key alt+2 1.2
	key ctrl+t
	key n 1.2
	key ctrl+y 0.4
	key alt+z 0.8
	type_text anima
	key Return 2
	type_text src/boids.rs
	key Return 1.8
	key alt+r 1.2
	key j 0.25
	key Return 1.8
	key ctrl+alt+h 0.8
	key alt+shift+h 1
	key alt+h 1
	key alt+l 1
	key alt+shift+h 0.8
	key alt+m 1.4
	key ctrl+alt+k 0.8
	key alt+shift+k 2
	key 5 0.8
	key a 0.8
	key slash 0.2
	type_text rounded
	key Return 0.8
	key space 0.4
	key Return 1.4
	key space 0.4
	key Return 1.4
	key Escape 0.2
	key Escape 1
	key alt+1 2.5
	key alt+shift+l 0.8
	key alt+2 0.8
	key alt+shift+b 3.2
	key Return 0.7
	key alt+1 1.2
}

play_session() {
	sleep 6
	key alt+shift+l 5
	type_readably "Summarize public Nova behavior without using tools."
	key alt+2 3
	key ctrl+t
	key n 2.5
	key ctrl+y 1
	key alt+z 2
	type_text anima
	key Return 3.5
	type_text src/boids.rs
	key Return 3.5
	key alt+r 2.5
	key j 0.8
	key Return 3
	key ctrl+alt+h 1.5
	key alt+shift+h 2.5
	key alt+h 2.5
	key alt+l 2.5
	key alt+shift+h 2
	key alt+m 2.5
	key ctrl+alt+k 1.5
	key alt+shift+k 3.5
	key 5 2
	key a 2
	key slash 0.4
	type_text rounded
	key Return 1.5
	key space 0.6
	key Return 2.5
	key space 0.6
	key Return 2.5
	sleep 2
	key q 2
	key alt+1 3
	key alt+shift+l 6
	key alt+2 2
	key alt+shift+b 5
	key Return 1
	sleep 4
	key alt+1 3
}

play_popups() {
	sleep 0.9
	key alt+shift+y 1.1
	key j 0.3
	key j 0.3
	key k 0.3
	sleep 2
	key alt+shift+y 0.7
	key alt+shift+j 4.4
	key alt+shift+j 0.8
}

play_yazi() {
	sleep 1.8
	key alt+r 1.6
	key k 0.45
	sleep 1.8
	key Return 2.2
}

play_live() {
	sleep 1.8
	key alt+shift+h 1.4
	sleep 1.0
	key alt+shift+h 1.4
	sleep 0.8
	key alt+m 1.0
	type_text 'yzx --version'
	key Return 1.1
	key alt+m 1.0
	type_text 'ls src'
	key Return 1.1
	key alt+m 1.0
	type_text 'git log -1 --oneline'
	key Return 1.1
	key alt+k 0.5
	key alt+k 0.5
	key alt+j 0.5
	key alt+j 0.5
	key ctrl+alt+j 1.5
	sleep 1.4
	key alt+shift+b 5.0
}

play_anima() {
	sleep 1.8
	key alt+shift+b 3.8
	key alt+shift+b 0.9
	sleep 0.5
	key alt+shift+n 4.8
}

play_appearance() {
	sleep 1.8
	key alt+shift+k 1.8
	key 5 1.0
	sleep 0.5
	key space 0.55
	local i
	for ((i = 0; i < 13; i++)); do
		key j 0.12
	done
	key space 0.4
	key Return 2.8
	key space 0.55
	for ((i = 0; i < 13; i++)); do
		key k 0.12
	done
	key space 0.4
	key Return 2.8
	key Escape 0.8
}

[[ -f "$WALLPAPER" ]] || {
	printf 'Missing recording input: %s\n' "$WALLPAPER" >&2
	exit 1
}

readonly TOOLCHAIN="$(nix build --no-link --print-out-paths --impure --expr "(import $SCRIPT_DIR/toolchain.nix {})")"
readonly NOVA="$(nix build --no-link --print-out-paths "github:Yazelix/nova/$NOVA_REV")"
mapfile -t zellij_bins < <(
	nix-store -qR "$NOVA" | while IFS= read -r store_path; do
		[[ -x "$store_path/bin/zellij" ]] && printf '%s/bin/zellij\n' "$store_path"
	done
)
if [[ "${#zellij_bins[@]}" -ne 1 ]]; then
	printf 'expected one Zellij binary in the pinned Nova closure, found %s\n' "${#zellij_bins[@]}" >&2
	exit 1
fi
ZELLIJ="${zellij_bins[0]}"
kill_recording_sessions
mkdir -p "$WORK_DIR"
readonly RUN_DIR="$(mktemp -d "${TMPDIR:-/tmp}/nova-site-recording.XXXXXX")"
readonly DEMO_SOURCE_DIR="$RUN_DIR/github.com/Yazelix"

mkdir -p "$SOURCE_CACHE_DIR" "$DEMO_SOURCE_DIR" "$RUN_DIR/state" "$RUN_DIR/zoxide" "$OUTPUT_DIR"
clone_at nova https://github.com/Yazelix/nova.git "$NOVA_REV" stable
clone_at ratconfig https://github.com/Yazelix/ratconfig.git 675a21f17900df47585b2a8290c5436204d120e4 main
clone_at starcompass https://github.com/Yazelix/starcompass.git 621bc6fcec916521c116e89d1ae8b146973145d5 edge
clone_at anima https://github.com/Yazelix/anima.git ea6cbedd3e5e9292b5d730003a5a9020389451f2 main
prepare_demo_clone nova "$NOVA_REV" stable
prepare_demo_clone ratconfig 675a21f17900df47585b2a8290c5436204d120e4 main
prepare_demo_clone starcompass 621bc6fcec916521c116e89d1ae8b146973145d5 edge
prepare_demo_clone anima ea6cbedd3e5e9292b5d730003a5a9020389451f2 main
if [[ -e "$DEMO_SOURCE_DIR/nova/.codex" ]]; then
	printf 'refusing to trust a Nova checkout with project-local Codex configuration\n' >&2
	exit 1
fi
"$TOOLCHAIN/bin/git" -C "$DEMO_SOURCE_DIR/anima" branch -f edge
"$TOOLCHAIN/bin/git" -C "$DEMO_SOURCE_DIR/anima" branch -f stable
cp -R "$SCRIPT_DIR/config" "$RUN_DIR/config"
mkdir -p "$RUN_DIR/config/rio"
cp -R "$NOVA/share/yazelix/rio/." "$RUN_DIR/config/rio/"
chmod -R u+w "$RUN_DIR/config/rio"
sed -i \
	-e '/-noto-fonts-[^c]/s|/share/noto|/share/fonts/noto|' \
	-e 's/Noto Sans Symbols2/Noto Sans Symbols 2/' \
	"$RUN_DIR/config/rio/config.toml"
grep -Fq 'font-family = "Noto Sans Symbols 2"' "$RUN_DIR/config/rio/config.toml"
grep -Eq -- '-noto-fonts-[^c][^/]*/share/fonts/noto' "$RUN_DIR/config/rio/config.toml"
mkdir -p "$RUN_DIR/atuin"
cat >"$RUN_DIR/atuin/config.toml" <<EOF
db_path = "$RUN_DIR/atuin/history.db"
auto_sync = false
update_check = false
EOF
export ATUIN_CONFIG_DIR="$RUN_DIR/atuin"
readonly NOVA_PRODUCT_REPO="$DEMO_SOURCE_DIR/nova"
readonly CODEX_MCP_OVERRIDES="$(codex mcp list --json | "$TOOLCHAIN/bin/jq" -er '
	if all(.[].name; test("^[A-Za-z0-9_-]+$")) then
		"mcp_servers={" + (map(.name + "={enabled=false}") | join(",")) + "}"
	else
		error("MCP server name cannot be represented as a safe TOML bare key")
	end
')"
sed -i \
	-e "s|__NOVA_PRODUCT_REPO__|$NOVA_PRODUCT_REPO|g" \
	-e "s|__CODEX_MCP_OVERRIDES__|$CODEX_MCP_OVERRIDES|" \
	"$RUN_DIR/config/config.toml"
ln -s "$DEMO_SOURCE_DIR" "$RUN_DIR/sources"

for path in "$DEMO_SOURCE_DIR/ratconfig" "$DEMO_SOURCE_DIR/starcompass" "$DEMO_SOURCE_DIR/anima"; do
	_ZO_DATA_DIR="$RUN_DIR/zoxide" "$TOOLCHAIN/bin/zoxide" add --score 8 "$path"
done
_ZO_DATA_DIR="$RUN_DIR/zoxide" "$TOOLCHAIN/bin/zoxide" add --score 20 "$NOVA_PRODUCT_REPO"

for number in $(seq 90 109); do
	[[ -e "/tmp/.X11-unix/X$number" ]] || {
		DISPLAY=":$number"
		break
	}
done
[[ -n "$DISPLAY" ]] || {
	printf 'No free X display in :90..:109\n' >&2
	exit 1
}
export DISPLAY

"$TOOLCHAIN/bin/Xvfb" "$DISPLAY" -screen 0 "${WIDTH}x${HEIGHT}x24" -nolisten tcp +extension Composite \
	>"$RUN_DIR/xvfb.log" 2>&1 &
xvfb_pid=$!
for _ in $(seq 1 50); do
	"$TOOLCHAIN/bin/xdotool" getdisplaygeometry >/dev/null 2>&1 && break
	sleep 0.1
done
"$TOOLCHAIN/bin/xwallpaper" --zoom "$WALLPAPER"
"$TOOLCHAIN/bin/picom" --backend xrender --vsync --config /dev/null >"$RUN_DIR/picom.log" 2>&1 &
picom_pid=$!
sleep 1

export NOVA_SITE_NOVA="$NOVA"
export NOVA_SITE_RECORDING_ROOT="$RUN_DIR"
export NOVA_SITE_SESSION="nova-site-recording-$$"
env -u WAYLAND_DISPLAY -u XDG_SESSION_TYPE -u XDG_CURRENT_DESKTOP -u NO_COLOR \
	WINIT_UNIX_BACKEND=x11 PATH="$SCRIPT_DIR:$TOOLCHAIN/bin:$PATH" \
	"$SCRIPT_DIR/run-nova.sh" >"$RUN_DIR/nova.log" 2>&1 &
nova_pid=$!

window=""
for _ in $(seq 1 200); do
	window="$("$TOOLCHAIN/bin/xdotool" search --class yzx 2>/dev/null | head -n1 || true)"
	[[ -z "$window" ]] || break
	kill -0 "$nova_pid" 2>/dev/null || break
	sleep 0.1
done
[[ -n "$window" ]] || {
	cat "$RUN_DIR/nova.log" >&2
	exit 1
}
"$TOOLCHAIN/bin/xdotool" windowmap --sync "$window" \
	windowmove "$window" 0 0 \
	windowsize "$window" "$WIDTH" "$HEIGHT" \
	windowraise "$window" \
	windowfocus --sync "$window"
sleep 12

# Prepare deterministic project tabs before recording.
key alt+m 0.8
type_text 'hx src/render.rs'
key Return 4
key ctrl+t
key r
type_text ratconfig
key Return 1
key ctrl+t
key n 2.2
key ctrl+y 0.6
key alt+z 1.5
type_text starcompass
key Return 4.5
type_text src/starcompass.rs
key Return 3.5
key alt+1 1.2

if [[ "$VARIANT" == original ]]; then
	"$TOOLCHAIN/bin/ffmpeg" -hide_banner -loglevel error \
		-f x11grab -draw_mouse 0 -video_size "${WIDTH}x${HEIGHT}" -i "$DISPLAY" \
		-frames:v 1 -y "$RUN_DIR/nova_workspace.png"
	cp "$RUN_DIR/nova_workspace.png" "$WORKSPACE_STILL"
fi

"$TOOLCHAIN/bin/ffmpeg" -hide_banner -loglevel error \
	-f x11grab -draw_mouse 0 -framerate 30 -video_size "${WIDTH}x${HEIGHT}" -i "$DISPLAY" \
	-an -c:v libx264 -crf 18 -preset veryfast -pix_fmt yuv420p -movflags +faststart \
	-y "$RUN_DIR/${CLIP_STEM}.mp4" &
capture_pid=$!
"play_$VARIANT"

kill -INT "$capture_pid" 2>/dev/null || true
wait "$capture_pid" || true
capture_pid=""
kill "$nova_pid" 2>/dev/null || true
wait "$nova_pid" 2>/dev/null || true
nova_pid=""
kill_recording_sessions "$NOVA_SITE_SESSION"
NOVA_SITE_SESSION=""

"$TOOLCHAIN/bin/ffmpeg" -hide_banner -loglevel error -ss "$POSTER_OFFSET" -i "$RUN_DIR/${CLIP_STEM}.mp4" \
	-frames:v 1 -y "$RUN_DIR/${CLIP_STEM}-poster.png"
cp "$RUN_DIR/${CLIP_STEM}.mp4" "$OUTPUT_DIR/${CLIP_STEM}.mp4"
cp "$RUN_DIR/${CLIP_STEM}-poster.png" "$OUTPUT_DIR/${CLIP_STEM}-poster.png"

readonly MP4_SHA256="$(sha256sum "$OUTPUT_DIR/${CLIP_STEM}.mp4" | cut -d ' ' -f 1)"
readonly POSTER_SHA256="$(sha256sum "$OUTPUT_DIR/${CLIP_STEM}-poster.png" | cut -d ' ' -f 1)"
if grep -Eq "^[0-9a-f]{64}  ${CLIP_STEM}\\.mp4$" "$OUTPUT_DIR/README.md"; then
	sed -i -E \
		-e "s/^[0-9a-f]{64}  ${CLIP_STEM}\\.mp4$/$MP4_SHA256  ${CLIP_STEM}.mp4/" \
		-e "s/^[0-9a-f]{64}  ${CLIP_STEM}-poster\\.png$/$POSTER_SHA256  ${CLIP_STEM}-poster.png/" \
		"$OUTPUT_DIR/README.md"
else
	printf '%s  %s.mp4\n%s  %s-poster.png\n' "$MP4_SHA256" "$CLIP_STEM" "$POSTER_SHA256" "$CLIP_STEM" \
		>>"$OUTPUT_DIR/README.md"
fi
"$TOOLCHAIN/bin/ffprobe" -v error \
	-show_entries format=duration:stream=codec_name,width,height,pix_fmt,r_frame_rate,avg_frame_rate,nb_frames \
	-of default=noprint_wrappers=1 "$OUTPUT_DIR/${CLIP_STEM}.mp4"
sha256sum "$OUTPUT_DIR/${CLIP_STEM}.mp4" "$OUTPUT_DIR/${CLIP_STEM}-poster.png"
