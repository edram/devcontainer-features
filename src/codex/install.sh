#!/bin/sh

set -eu

INSTALLER_URL="https://chatgpt.com/codex/install.sh"

export CODEX_RELEASE="${VERSION:-latest}"
export CODEX_NON_INTERACTIVE="${CODEX_NON_INTERACTIVE:-1}"

: "${CODEX_INSTALL_DIR:?CODEX_INSTALL_DIR must be set by the Feature containerEnv}"
: "${CODEX_HOME:?CODEX_HOME must be set by the Feature containerEnv}"

installer="$(mktemp)"

cleanup() {
  rm -f "$installer"
}
trap cleanup EXIT INT TERM

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$INSTALLER_URL" -o "$installer"
elif command -v wget >/dev/null 2>&1; then
  wget -q -O "$installer" "$INSTALLER_URL"
else
  echo "curl or wget is required to install Codex." >&2
  exit 1
fi

sh "$installer"
