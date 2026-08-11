#!/bin/bash

set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required to install Claude Code." >&2
  exit 1
fi

npm install -g "@anthropic-ai/claude-code@${VERSION:-stable}"
