#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md
source dev-container-features-test-lib

# Feature-specific tests
check "codex is on PATH" which codex
check "codex version" codex --version
check "codex code mode host is executable" test -x /usr/local/share/codex/packages/standalone/current/bin/codex-code-mode-host

# Report result
reportResults
