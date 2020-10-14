#!/bin/bash

# https://github.com/angelcam/arrow-client/wiki/Compilation-for-OpenWrt
rustup target add mips-unknown-linux-musl

mkdir -p libs
cd libs
wget https://downloads.openwrt.org/releases/18.06.2/targets/ar71xx/generic/openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64.tar.xz
tar xJf openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64.tar.xz

cd openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64

scripts/feeds update
scripts/feeds install libopenssl
scripts/feeds install libpcap

make

cd ...

if [ ! -d .cargo ]; then
    mkdir .cargo
fi

cat > .cargo/config <<EOF
[target.mips-unknown-linux-musl]
ar = "mips-openwrt-linux-musl-ar"
linker = "mips-openwrt-linux-musl-gcc"
EOF

WORK_DIR=`pwd`/libs

# This variable is required by the OpenWrt SDK tools
export STAGING_DIR=$WORK_DIR/openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64/staging_dir

TOOLCHAIN_DIR=$STAGING_DIR/toolchain-mips_24kc_gcc-7.3.0_musl
TARGET_DIR=$STAGING_DIR/target-mips_24kc_musl

# These two variables are required by the Rust OpenSSL wrapper
export OPENSSL_LIB_DIR=$TARGET_DIR/usr/lib
export OPENSSL_INCLUDE_DIR=$TARGET_DIR/usr/include

# Make sure the toolchain is in PATH
export PATH=$TOOLCHAIN_DIR/bin:$PATH

# Tell Rust build scripts which C compiler should be used for building their C dependencies. Modify this variable to match your target.
export CC_mips_unknown_linux_musl=mips-unknown-linux-musl

cargo build --target=mips-unknown-linux-musl --release

./libs/openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64/staging_dir/toolchain-mips_24kc_gcc-7.3.0_musl/bin/mips-openwrt-linux-strip
