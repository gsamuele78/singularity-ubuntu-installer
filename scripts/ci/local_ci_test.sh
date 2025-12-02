#!/usr/bin/env bash
set -e
echo "Local CI test"
singularity exec docker://alpine uname -a