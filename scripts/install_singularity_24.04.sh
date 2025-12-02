#!/usr/bin/env bash
set -euo pipefail

SING_VER="v4.3.4"
GO_VER="1.25.3"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

#Ubuntu does not permit applications to create unprivileged user namespaces by default
#install SingularityCE from source you must configure apparmor. 
#Create an apparmor profile file at /etc/apparmor.d/singularity-ce

tee /etc/apparmor.d/singularity-ce << 'EOF'
# Permit unprivileged user namespace creation for SingularityCE starter
abi <abi/4.0>,
include <tunables/global>

profile singularity-ce /usr/local/libexec/singularity/bin/starter{,-suid} flags=(unconfined) {
  userns,

  # Site-specific additions and overrides. See local/README for details.
  include if exists <local/singularity-ce>
}
EOF

#SingularityCE will now be able to create unprivileged user namespaces on your system
systemctl reload apparmor

#cd "$SCRIPT_DIR"

# Install singularity-cache-cleaner systemd service
install -m 755 "${SCRIPT_DIR}/scripts/clean_cache.sh" /usr/local/bin/singularity-cache-cleaner
install -m 644 "${SCRIPT_DIR}/systemd/singularity-cache-cleaner.service" /etc/systemd/system/
systemctl daemon-reload
systemctl enable singularity-cache-cleaner.service

singularity --version