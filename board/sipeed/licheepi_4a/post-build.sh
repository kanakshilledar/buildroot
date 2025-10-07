#!/bin/bash

# Post-build script to copy firmware files to U-Boot directory
# Called after all packages are built but before creating final images

BINARIES_DIR="$1"
TARGET_DIR="$2"
BUILD_DIR="$3"

echo "=== TH1520 Post-build: Copying firmware files to U-Boot ==="

# Find U-Boot build directory
UBOOT_DIR=$(find "$BUILD_DIR" -maxdepth 1 -name "uboot-*" -type d | head -1)

if [ -z "$UBOOT_DIR" ] || [ ! -d "$UBOOT_DIR" ]; then
    echo "Warning: U-Boot build directory not found"
    echo "Searched in: $BUILD_DIR"
    exit 0
fi

echo "Found U-Boot directory: $UBOOT_DIR"

# Copy DDR firmware
if [ -f "$BINARIES_DIR/th1520-ddr-firmware.bin" ]; then
    cp "$BINARIES_DIR/th1520-ddr-firmware.bin" "$UBOOT_DIR/"
    echo "✓ Copied th1520-ddr-firmware.bin to U-Boot directory"
else
    echo "✗ Warning: th1520-ddr-firmware.bin not found in $BINARIES_DIR"
fi

# Check if OpenSBI firmware exists
if [ -f "$BINARIES_DIR/fw_dynamic.bin" ]; then
    echo "✓ fw_dynamic.bin found in $BINARIES_DIR (U-Boot will use it automatically)"
else
    echo "✗ Warning: fw_dynamic.bin not found in $BINARIES_DIR"
fi

echo "=== Post-build firmware copy completed ==="
