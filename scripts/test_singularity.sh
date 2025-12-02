#!/usr/bin/env bash
set -euo pipefail

singularity --version
singularity exec docker://alpine echo "Singularity works!"