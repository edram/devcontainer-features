#!/bin/bash

set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required to install Codex." >&2
  exit 1
fi

npm install -g "@openai/codex@${VERSION:-latest}"
