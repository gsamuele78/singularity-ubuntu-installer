#!/usr/bin/env bash
set -euo pipefail

SING_VER="v4.3.3"
GO_VER="1.22.5"

apt update -y
apt install -y build-essential uuid-dev libgpgme-dev libseccomp-dev pkg-config git wget squashfs-tools cryptsetup

cd /usr/local/src
wget https://go.dev/dl/go${GO_VER}.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

if [ ! -d singularity ]; then
    git clone https://github.com/sylabs/singularity.git
fi
cd singularity
git fetch --all --tags
git checkout ${SING_VER}

./mconfig
make -C builddir
make -C builddir install

singularity --version