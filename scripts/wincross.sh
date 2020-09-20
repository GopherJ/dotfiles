#!/bin/bash

# https://www.cnblogs.com/silentdoer/p/13024037.html
sudo apt install mingw-w64

rustup target add x86_64-pc-windows-gnu --toolchain=stable

if [ ! -f .cargo ]; then
    mkdir .cargo
fi

cat > .cargo/config <<EOF
[target.x86_64-pc-windows-gnu]
linker = "x86_64-w64-mingw32-gcc"
ar = "x86_64-w64-mingw32-gcc-ar"
EOF

cargo build --release --target=x86_64-pc-windows-gnu
