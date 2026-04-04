#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "$SCRIPT_DIR/product"

rm $SCRIPT_DIR/product.tar.gz
tar -czvf $SCRIPT_DIR/product.tar.gz .
popd

echo "Product package created at $SCRIPT_DIR/product.tar.gz"
