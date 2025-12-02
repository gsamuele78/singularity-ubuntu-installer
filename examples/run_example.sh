#!/usr/bin/env bash
singularity build hello.sif hello-world.def
singularity run hello.sif