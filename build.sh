#!/bin/bash

cd "$(dirname "$0")/zmk"

# Build left half
echo "Building left half..."
west build -s app -S studio-rpc-usb-uart -b nice_nano_v2 -d build/left -- -DCONFIG_ZMK_STUDIO=y -DZMK_CONFIG=/Users/lukas/projects/zmk-config/config -DSHIELD="ergotyper_left"

# Build right half
echo "Building right half..."
west build -s app -b nice_nano_v2 -d build/right -- -DZMK_CONFIG=/Users/lukas/projects/zmk-config/config -DSHIELD="ergotyper_right"

cd ..

# Copy firmware to firmware directory
echo "Copying firmware..."
mkdir -p firmware
cp zmk/build/left/zephyr/zmk.uf2 firmware/ergotyper_left.uf2
cp zmk/build/right/zephyr/zmk.uf2 firmware/ergotyper_right.uf2

echo "Build complete! Firmware in ./firmware/"
