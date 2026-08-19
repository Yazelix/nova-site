#!/bin/sh
set -eu

: "${NOVA_SITE_RECORDING_ROOT:?}"
: "${NOVA_SITE_NOVA:?}"

export YAZELIX_CONFIG_HOME="$NOVA_SITE_RECORDING_ROOT/config"
export YAZELIX_STATE_DIR="$NOVA_SITE_RECORDING_ROOT/state"
export _ZO_DATA_DIR="$NOVA_SITE_RECORDING_ROOT/zoxide"
: "${ATUIN_CONFIG_DIR:=$NOVA_SITE_RECORDING_ROOT/atuin}"
export ATUIN_CONFIG_DIR
export TERM=xterm-256color
export PATH="$NOVA_SITE_NOVA/bin:$PATH"
unset NO_COLOR

cd "${NOVA_SITE_START_DIR:-$NOVA_SITE_RECORDING_ROOT/sources/ratconfig}"
exec yzx launch --session "${NOVA_SITE_SESSION:-nova-site-recording-$$}"
