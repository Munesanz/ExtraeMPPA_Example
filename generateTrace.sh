#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: No program name provided."
  exit 1
fi

PROGRAM_NAME="$1"
EXTRAE_PROGRAM_NAME="$PROGRAM_NAME" EXTRAE_FINAL_DIR=. kvx-mppa -- /work1/amurena/extraeMPPA/ins2/bin/mpi2prv -f "$PROGRAM_NAME.mpits" -o "$PROGRAM_NAME.prv"
rm "$PROGRAM_NAME.sym"
