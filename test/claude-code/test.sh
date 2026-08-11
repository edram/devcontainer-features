#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md
source dev-container-features-test-lib

# Feature-specific tests
check "claude is on PATH" which claude
check "claude version" claude --version
check "claude is installed in /usr/local/bin" test "$(command -v claude)" = /usr/local/bin/claude
check "claude launcher target is executable" test -x /usr/local/share/claude-code/.local/bin/claude

# Report result
reportResults
