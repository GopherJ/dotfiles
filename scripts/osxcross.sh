#!/bin/bash

sudo apt install \
    clang \
    gcc \
    g++ \
    zlib1g-dev \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev

rustup target add x86_64-apple-darwin

git clone https://github.com/tpoechtrager/osxcross
cd osxcross
wget -nc https://s3.dockerproject.org/darwin/v2/MacOSX10.10.sdk.tar.xz
mv MacOSX10.10.sdk.tar.xz tarballs/
UNATTENDED=yes OSX_VERSION_MIN=10.7 ./build.sh

cd ..

if [ ! -d .cargo ]; then
    mkdir .cargo
fi

cat > .cargo/config <<EOF
[target.x86_64-apple-darwin]
linker = "x86_64-apple-darwin14-clang"
ar = "x86_64-apple-darwin14-ar"
EOF

PATH="$(pwd)/osxcross/target/bin:$PATH" \
CC=o64-clang \
CXX=o64-clang++ \
LIBZ_SYS_STATIC=1 \
PKG_CONFIG_ALLOW_CROSS=1 \
cargo build --release --target x86_64-apple-darwin
