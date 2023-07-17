#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Error: Insufficient arguments provided."
  echo "Usage: ./script.sh <PROGRAM_NAME> <mpi2prv path>"
  exit 1
fi

PROGRAM_NAME="$1"
MPI2PRV_PATH="$2"
EXTRAE_PROGRAM_NAME="$PROGRAM_NAME" EXTRAE_FINAL_DIR=. kvx-mppa -- "$MPI2PRV_PATH" -f "$PROGRAM_NAME.mpits" -o "$PROGRAM_NAME.prv"
rm "$PROGRAM_NAME.sym"
