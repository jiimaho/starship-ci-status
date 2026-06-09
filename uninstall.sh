#!/bin/bash
set -e

rm -f "${HOME}/.local/bin/ci-status" "${HOME}/.local/bin/ci-status-fetch"
rm -rf "${HOME}/.cache/ci-status"
echo "Removed ci-status scripts and cache."
echo ""
echo "Manually remove from ~/.config/starship.toml:"
echo "  1. \${custom.ci_status} from your format string"
echo "  2. The [custom.ci_status] block"
