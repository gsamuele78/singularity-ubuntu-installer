#!/usr/bin/env bash
set -euo pipefail

SING_VER="v4.3.4"
GO_VER="1.25.3"

apt update -y
# Install required build/runtime dependencies (including FUSE3 headers for squashfuse)
apt install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libgpgme-dev \
    libseccomp-dev \
    libsubid-dev \
    libfuse3-dev \
    fuse3 \
    fuse2fs \
    cryptsetup \
    runc \
    uidmap \
    uuid-dev \
    git \
    wget \
    conmon \
    squashfs-tools \
    squashfs-tools-ng \
    zlib1g-dev

cd /usr/local/src
wget https://go.dev/dl/go${GO_VER}.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

if [ ! -d singularity ]; then
    git clone --recurse-submodules https://github.com/sylabs/singularity.git
fi
cd singularity
git fetch --all --tags
git checkout ${SING_VER}
# Ensure submodules (squashfuse, etc.) are initialized for the checked-out tag
git submodule update --init --recursive

# Configure Singularity (seccomp support is enabled by default)
./mconfig
make -C builddir
make -C builddir install

# Install singularity-cache-cleaner systemd service
install -m 755 /home/jfs/00-VScode-Projects/singularity-ubuntu-installer/scripts/clean_cache.sh /usr/local/bin/singularity-cache-cleaner
install -m 644 /home/jfs/00-VScode-Projects/singularity-ubuntu-installer/systemd/singularity-cache-cleaner.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable singularity-cache-cleaner.service

singularity --version