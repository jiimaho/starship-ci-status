#!/bin/bash
set -e

CACHE_VERSION="3"
BIN_DIR="${HOME}/.local/bin"
STARSHIP_CONFIG="${HOME}/.config/starship.toml"
REPO="jiimaho/starship-ci-status"
RAW="https://raw.githubusercontent.com/${REPO}/main"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing starship-ci-status..."

mkdir -p "$BIN_DIR"

# Install scripts — from local repo if available, otherwise download
if [ -f "$SCRIPT_DIR/bin/ci-status" ]; then
  cp "$SCRIPT_DIR/bin/ci-status" "$BIN_DIR/ci-status"
  cp "$SCRIPT_DIR/bin/ci-status-fetch" "$BIN_DIR/ci-status-fetch"
else
  curl -fsSL "$RAW/bin/ci-status" -o "$BIN_DIR/ci-status"
  curl -fsSL "$RAW/bin/ci-status-fetch" -o "$BIN_DIR/ci-status-fetch"
fi
chmod +x "$BIN_DIR/ci-status" "$BIN_DIR/ci-status-fetch"
echo "  ✓ Scripts installed to $BIN_DIR"

# Clear caches from old versions
for dir in "$HOME/.cache/ci-status"/v*/; do
  ver=$(basename "$dir" 2>/dev/null)
  if [ "$ver" != "v${CACHE_VERSION}" ] && [ -d "$dir" ]; then
    rm -rf "$dir"
    echo "  ✓ Removed old cache: $dir"
  fi
done

# Patch starship.toml — append [custom.ci_status] block if missing
if [ ! -f "$STARSHIP_CONFIG" ]; then
  echo ""
  echo "  ! No starship.toml found at $STARSHIP_CONFIG"
  echo "    Create one and add the config block from the README."
elif grep -q '\[custom\.ci_status\]' "$STARSHIP_CONFIG"; then
  echo "  ✓ [custom.ci_status] already present in starship.toml"
else
  cat >> "$STARSHIP_CONFIG" << 'EOF'

[custom.ci_status]
command = "ci-status"
when = "git rev-parse --is-inside-work-tree 2>/dev/null"
format = "[ $output ]($style)"
style = ""
EOF
  echo "  ✓ Added [custom.ci_status] to starship.toml"
fi

echo ""
echo "Done. Add \${custom.ci_status} to your format string in starship.toml if not already present."
echo "  Example: \$git_branch\$git_status\${custom.ci_status}"
