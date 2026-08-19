#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly WORK_DIR="$SCRIPT_DIR/.work"
readonly SOURCE_DIR="$WORK_DIR/sources"
readonly OUTPUT_DIR="$REPO_ROOT/drafts/media"
readonly PUBLIC_DIR="$REPO_ROOT/public/blog/yazelix-nova-v1/media"
readonly WALLPAPER="$SCRIPT_DIR/partenoxenese-blue-faro.jpg"
readonly NOVA_REV="5a673c059c454042085b191d5e8ec15c01b3d121"
readonly WIDTH=1784
readonly HEIGHT=996
readonly VARIANT="${1:-original}"
case "$VARIANT" in
original)
	readonly CLIP_STEM="nova-day-to-day"
	readonly POSTER_OFFSET=9
	readonly CAPTURE_RATCONFIG=1
	;;
session)
	readonly CLIP_STEM="nova-day-to-day-session"
	readonly POSTER_OFFSET=8
	readonly CAPTURE_RATCONFIG=0
	;;
sixty)
	readonly CLIP_STEM="nova-in-60-seconds"
	readonly POSTER_OFFSET=18
	readonly CAPTURE_RATCONFIG=0
	;;
*)
	printf 'usage: record.sh [original|session|sixty]\n' >&2
	exit 2
	;;
esac
TOOLCHAIN=""
NOVA=""
MARS=""
RUN_DIR=""
DISPLAY=""
xvfb_pid=""
picom_pid=""
nova_pid=""
capture_pid=""

cleanup() {
	for pid in "$capture_pid" "$nova_pid" "$picom_pid" "$xvfb_pid"; do
		[[ -z "$pid" ]] || kill "$pid" 2>/dev/null || true
	done
}
trap cleanup EXIT

clone_at() {
	local name="$1" url="$2" revision="$3" branch="$4"
	local destination="$SOURCE_DIR/$name"
	if [[ ! -d "$destination/.git" ]]; then
		"$TOOLCHAIN/bin/git" clone --filter=blob:none --no-checkout "$url" "$destination"
	fi
	"$TOOLCHAIN/bin/git" -C "$destination" fetch --depth 1 origin "$revision"
	"$TOOLCHAIN/bin/git" -C "$destination" checkout --force -B "$branch" FETCH_HEAD
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

play_sixty() {
	sleep 0.9
	key alt+2 0.85
	key alt+1 1
	key alt+shift+l 1.2
	type_readably "what's special about yazelix nova, for someone who never used it before? under 2048 chars, no tools"
	key Return 0.9
	key alt+3 0.8
	key alt+r 1
	key j 0.25
	key Return 1.4
	key ctrl+alt+h 0.75
	key ctrl+alt+h 0.75
	key ctrl+alt+l 0.75
	key ctrl+alt+l 0.8
	key alt+shift+h 0.7
	key alt+m 1
	type_text 'yzx --version'
	key Return 1.1
	key alt+m 1
	type_text 'ls src'
	key Return 1.1
	key alt+m 1
	type_text 'git log -1 --oneline'
	key Return 1.1
	key alt+k 0.45
	key alt+k 0.45
	key alt+j 0.45
	key alt+j 0.45
	key ctrl+alt+j 1
	key alt+m 1
	type_text 'git switch '
	key Tab 1.8
	key Escape 0.35
	key ctrl+c 0.25
	key ctrl+r 1.8
	key Escape 0.5
	key alt+shift+h 0.8
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
	key alt+3 0.6
	key alt+shift+b 3.2
	key Return 0.7
	key alt+1 4.5
}

[[ -f "$WALLPAPER" ]] || {
	printf 'Missing recording input: %s\n' "$WALLPAPER" >&2
	exit 1
}

readonly TOOLCHAIN="$(nix build --no-link --print-out-paths --impure --expr "(import $SCRIPT_DIR/toolchain.nix {})")"
readonly NOVA="$(nix build --no-link --print-out-paths "github:Yazelix/nova/$NOVA_REV")"
readonly MARS="$(nix-store -qR "$NOVA" | sed -n '/-mars$/p' | head -n1)"
mkdir -p "$WORK_DIR"
readonly RUN_DIR="$(mktemp -d "$WORK_DIR/run.XXXXXX")"

mkdir -p "$SOURCE_DIR" "$RUN_DIR/state" "$RUN_DIR/zoxide" "$OUTPUT_DIR" "$PUBLIC_DIR"
clone_at ratconfig https://github.com/Yazelix/ratconfig.git 675a21f17900df47585b2a8290c5436204d120e4 main
clone_at starcompass https://github.com/Yazelix/starcompass.git 621bc6fcec916521c116e89d1ae8b146973145d5 edge
clone_at anima https://github.com/Yazelix/anima.git ea6cbedd3e5e9292b5d730003a5a9020389451f2 main
"$TOOLCHAIN/bin/git" -C "$SOURCE_DIR/anima" branch -f edge
"$TOOLCHAIN/bin/git" -C "$SOURCE_DIR/anima" branch -f stable
cp -R "$SCRIPT_DIR/config" "$RUN_DIR/config"
mkdir -p "$RUN_DIR/atuin"
cat >"$RUN_DIR/atuin/config.toml" <<EOF
db_path = "$RUN_DIR/atuin/history.db"
auto_sync = false
update_check = false
EOF
export ATUIN_CONFIG_DIR="$RUN_DIR/atuin"
readonly NOVA_PRODUCT_REPO="$(cd "$REPO_ROOT/../nova" && pwd)"
sed -i \
	-e "s|__NOVA_SITE_REPO_ROOT__|$REPO_ROOT|" \
	-e "s|__NOVA_PRODUCT_REPO__|$NOVA_PRODUCT_REPO|" \
	"$RUN_DIR/config/config.toml"
ln -s "$SOURCE_DIR" "$RUN_DIR/sources"

for path in "$REPO_ROOT" "$SOURCE_DIR/ratconfig" "$SOURCE_DIR/starcompass" "$SOURCE_DIR/anima"; do
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
if [[ "$VARIANT" == sixty ]]; then
	export NOVA_SITE_START_DIR="$NOVA_PRODUCT_REPO"
fi
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
"$TOOLCHAIN/bin/xdotool" windowmove "$window" 0 0 windowsize "$window" "$WIDTH" "$HEIGHT" windowfocus --sync "$window"
sleep 12

# Prepare tabs before recording. Sixty starts on tab 3 and walks to tab 1 on camera.
key alt+m 0.8
if [[ "$VARIANT" == sixty ]]; then
	type_text 'hx AGENTS.md'
	key Return 4
	key ctrl+t
	key r
	type_text nova
	key Return 1
else
	type_text 'hx src/render.rs'
	key Return 4
	key ctrl+t
	key r
	type_text ratconfig
	key Return 1
fi
key ctrl+t
key n 2.2
key ctrl+y 0.6
key alt+z 1.5
type_text starcompass
key Return 4.5
type_text src/starcompass.rs
key Return 3.5
if [[ "$VARIANT" == sixty ]]; then
	key ctrl+t
	key n 2.2
	key ctrl+y 0.6
	key alt+z 1.5
	type_text anima
	key Return 4.5
	type_text src/boids.rs
	key Return 3.5
else
	key alt+1 1.2
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

if [[ "$CAPTURE_RATCONFIG" == 1 ]]; then
	mkdir -p "$RUN_DIR/ratconfig"
	env -u WAYLAND_DISPLAY -u XDG_SESSION_TYPE -u XDG_CURRENT_DESKTOP -u NO_COLOR \
		DISPLAY="$DISPLAY" WINIT_UNIX_BACKEND=x11 \
		MARS_APP_ID=nova-ratconfig MARS_CONFIG_HOME="$SCRIPT_DIR/config/mars" \
		MARS_BASE_CONFIG_HOME="$MARS/share/mars" YAZELIX_CURSOR_CONFIG="$SCRIPT_DIR/config/cursors.toml" \
		YAZELIX_CONFIG_HOME="$RUN_DIR/ratconfig" PATH="$NOVA/bin:$PATH" \
		"$MARS/bin/mars" --title-placeholder nova-ratconfig -e "$NOVA/bin/yzx" config \
		>"$RUN_DIR/ratconfig.log" 2>&1 &
	nova_pid=$!
	window=""
	for _ in $(seq 1 100); do
		window="$("$TOOLCHAIN/bin/xdotool" search --class nova-ratconfig 2>/dev/null | head -n1 || true)"
		[[ -z "$window" ]] || break
		sleep 0.1
	done
	[[ -n "$window" ]]
	"$TOOLCHAIN/bin/xdotool" windowmove "$window" 0 0 windowsize "$window" "$WIDTH" "$HEIGHT"
	sleep 3
	"$TOOLCHAIN/bin/ffmpeg" -hide_banner -loglevel error \
		-f x11grab -draw_mouse 0 -framerate 30 -video_size "${WIDTH}x${HEIGHT}" -i "$DISPLAY" \
		-frames:v 1 -y "$RUN_DIR/ratconfig-nova-v1.png"
	kill "$nova_pid" 2>/dev/null || true
	wait "$nova_pid" 2>/dev/null || true
	nova_pid=""
	cp "$RUN_DIR/ratconfig-nova-v1.png" "$OUTPUT_DIR/ratconfig-nova-v1.png"
	cp "$RUN_DIR/ratconfig-nova-v1.png" "$PUBLIC_DIR/ratconfig-nova-v1.png"
fi

"$TOOLCHAIN/bin/ffmpeg" -hide_banner -loglevel error -ss "$POSTER_OFFSET" -i "$RUN_DIR/${CLIP_STEM}.mp4" \
	-frames:v 1 -y "$RUN_DIR/${CLIP_STEM}-poster.png"
cp "$RUN_DIR/${CLIP_STEM}.mp4" "$OUTPUT_DIR/${CLIP_STEM}.mp4"
cp "$RUN_DIR/${CLIP_STEM}-poster.png" "$OUTPUT_DIR/${CLIP_STEM}-poster.png"
cp "$RUN_DIR/${CLIP_STEM}.mp4" "$PUBLIC_DIR/${CLIP_STEM}.mp4"
cp "$RUN_DIR/${CLIP_STEM}-poster.png" "$PUBLIC_DIR/${CLIP_STEM}-poster.png"

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
if [[ "$CAPTURE_RATCONFIG" == 1 ]]; then
	readonly RATCONFIG_SHA256="$(sha256sum "$OUTPUT_DIR/ratconfig-nova-v1.png" | cut -d ' ' -f 1)"
	sed -i -E \
		-e "s/^[0-9a-f]{64}  ratconfig-nova-v1\\.png$/$RATCONFIG_SHA256  ratconfig-nova-v1.png/" \
		"$OUTPUT_DIR/README.md"
fi

"$TOOLCHAIN/bin/ffprobe" -v error \
	-show_entries format=duration:stream=codec_name,width,height,pix_fmt,r_frame_rate,avg_frame_rate,nb_frames \
	-of default=noprint_wrappers=1 "$OUTPUT_DIR/${CLIP_STEM}.mp4"
sha256sum "$OUTPUT_DIR/${CLIP_STEM}.mp4" "$OUTPUT_DIR/${CLIP_STEM}-poster.png"
"$TOOLCHAIN/bin/rm" -rf -- "$RUN_DIR"
