#!/usr/bin/env bash
set -euo pipefail

rm -f /usr/local/bin/singularity
rm -f /usr/local/bin/singularity-cache-cleaner
rm -rf /usr/local/libexec/singularity
rm -rf /usr/local/etc/singularity
rm -rf /usr/local/var/singularity
rm -rf /usr/local/src/singularity
rm -rf /usr/local/go

apt remove -y \
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
	squashfs-tools \
	squashfs-tools-ng \
	uidmap \
	uuid-dev \
	git \
	wget \
	zlib1g-dev
apt autoremove -y

systemctl disable --now singularity-cache-cleaner.service || true
rm -f /etc/systemd/system/singularity-cache-cleaner.service
systemctl daemon-reload

echo "Singularity completely removed."
echo "Please check for any remaining files in /usr/local/libexec/singularity and /usr/local/etc/singularity."
echo "You may also want to remove the singularity user and group if they were created."
echo "Run 'sudo userdel singularity' and 'sudo groupdel singularity' if necessary."
echo "Cleanup complete."