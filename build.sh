#!/usr/bin/env bash
set -euo pipefail

# set CUSTOM_GO_PATH to /opt/go if not set
if [ -z "${CUSTOM_GO_PATH:-}" ]; then
    export CUSTOM_GO_PATH='/opt/go'
fi

# test if CUSTOM_GO_PATH/bin/go exists and is executable
if [ ! -x "$CUSTOM_GO_PATH/bin/go" ]; then
    echo "Error: Go binary not found at $CUSTOM_GO_PATH/bin/go"
    exit 1
fi

export PATH="$CUSTOM_GO_PATH/bin:$PATH"

# use /opt/ohos-sdk/sdk/default/openharmony as default OHOS_SDK path, can be overridden by setting OHOS_SDK environment variable
if [ -z "${OHOS_SDK:-}" ]; then
    export OHOS_SDK='/opt/ohos-sdk/sdk/default/openharmony'
fi

if [ ! -d "$OHOS_SDK" ]; then
    echo "Error: OHOS_SDK directory not found at $OHOS_SDK"
    exit 1
fi

export LLVMCONFIG="$OHOS_SDK/native/llvm/bin/llvm-config"
if [ ! -x "$LLVMCONFIG" ]; then
    echo "Error: llvm-config not found at $LLVMCONFIG"
    exit 1
fi

echo "==> Building for OpenHarmony"
echo "  Go Bin: $(which go)"
echo "  Go Version: $(go version)"
echo "  OHOS SDK: $OHOS_SDK"

export GOARCH=arm64
export GOOS=linux
export CGO_ENABLED=1

export CGO_CFLAGS="-g -O2 $($LLVMCONFIG --cflags) --target=aarch64-linux-ohos --sysroot=$OHOS_SDK/native/sysroot"
export CGO_LDFLAGS="--target=aarch64-linux-ohos -fuse-ld=lld"

export CC="$OHOS_SDK/native/llvm/bin/clang"
export CXX="$OHOS_SDK/native/llvm/bin/clang++"
export AR="$OHOS_SDK/native/llvm/bin/llvm-ar"
export LD="$OHOS_SDK/native/llvm/bin/lld"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENTS_DIR="$SCRIPT_DIR/components"

mkdir -p "$SCRIPT_DIR/product"

build_component() {
    local component_json="$1"
    local component_dir component_name
    component_dir="$(dirname "$component_json")"
    component_name="$(basename "$component_dir")"

    echo "==> Building component: $component_name"

    local target buildmode
    target=$(jq -r '.target' "$component_json")
    buildmode=$(jq -r '.buildmode // "c-archive"' "$component_json")

    local -a sources
    readarray -t sources < <(jq -r '.sources[]' "$component_json")

    pushd "$component_dir" > /dev/null
    #  -ldflags="-s -w" for stripping symbols
    go build -tlsmodegd -trimpath -buildmode "$buildmode" -v -o "$target" "${sources[@]}"
    popd > /dev/null

    cp "$component_dir/$target" "$SCRIPT_DIR/product/$target"
    # extract basename without extension for .h file
    local header="${target%%.*}.h"
    cp "$component_dir/${header}" "$SCRIPT_DIR/product/${header}"
}

for component_json in "$COMPONENTS_DIR"/*/component.json; do
    [ -f "$component_json" ] || continue
    build_component "$component_json"
done
