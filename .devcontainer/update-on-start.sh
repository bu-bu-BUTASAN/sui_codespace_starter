#!/usr/bin/env bash
set -eux

# Allow users to skip update on start
if [ "${SKIP_SUI_UPDATE:-0}" = "1" ]; then
  echo "[update] SKIP_SUI_UPDATE=1 set. Skipping Sui update."
  exit 0
fi

# Ensure PATH for suiup/sui
export PATH="${HOME}/.local/bin:${PATH}"

# If suiup is missing, skip gracefully
if ! command -v suiup >/dev/null 2>&1; then
  echo "[update] suiup not found; skipping update."
  exit 0
fi

# Update to latest testnet CLI (do not fail the container start)
suiup update sui@testnet -y || true

# Show version after attempted update
sui --version || true

echo "[update] Sui CLI update-on-start completed."

