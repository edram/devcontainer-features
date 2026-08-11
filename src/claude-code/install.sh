#!/bin/bash

set -euo pipefail

INSTALLER_URL="https://claude.ai/install.sh"
INSTALL_HOME="/usr/local/share/claude-code"
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
  echo "curl or wget is required to install Claude Code." >&2
  exit 1
fi

mkdir -p "$INSTALL_HOME"
HOME="$INSTALL_HOME" bash "$installer" "${VERSION:-stable}"

ln -sf "$INSTALL_HOME/.local/bin/claude" /usr/local/bin/claude

remote_user="${_REMOTE_USER:-${_CONTAINER_USER:-root}}"
if [ "$remote_user" != "root" ]; then
  chown -R "$remote_user" "$INSTALL_HOME"
fi
