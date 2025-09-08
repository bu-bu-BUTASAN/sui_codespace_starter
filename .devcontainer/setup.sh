#!/usr/bin/env bash
set -eux

# Ensure required tools for install scripts
SUDO=""
if [ "$(id -u)" -ne 0 ] && command -v sudo >/dev/null 2>&1; then
  SUDO="sudo"
fi
export DEBIAN_FRONTEND=noninteractive
$SUDO apt-get update -y
$SUDO apt-get install -y --no-install-recommends curl ca-certificates
$SUDO update-ca-certificates || true

# Bin dir and PATH
BIN_DIR="${HOME}/.local/bin"
mkdir -p "${BIN_DIR}"
export PATH="${BIN_DIR}:${PATH}"

# Install suiup if not present (idempotent)
if ! command -v suiup >/dev/null 2>&1; then
  curl -sSfL https://raw.githubusercontent.com/Mystenlabs/suiup/main/install.sh | sh
fi

# Install Sui CLI (testnet) if not present (idempotent)
if ! command -v sui >/dev/null 2>&1; then
  suiup install sui@testnet -y
fi

# Show versions
which sui || true
sui --version

echo "[setup] Sui CLI is ready via suiup (testnet)."
