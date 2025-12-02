#!/usr/bin/env bash
set -e
echo "Running GitHub CI Singularity smoke test"
singularity exec docker://alpine echo "CI OK"