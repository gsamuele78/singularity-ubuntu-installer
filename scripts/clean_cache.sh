#!/usr/bin/env bash
CACHE_DIR="/root/.singularity/cache"
[ -d "$CACHE_DIR" ] && rm -rf "${CACHE_DIR:?}"/*
echo "Singularity cache cleaned."
echo "You may want to run 'sudo systemctl restart singularity-cache-cleaner.service'"
echo "to ensure the cache cleaner service is running properly."
systemctl restart singularity-cache-cleaner.service || echo "Failed to restart singularity-cache-cleaner.service, please check manually."
echo "Cache cleanup complete."
