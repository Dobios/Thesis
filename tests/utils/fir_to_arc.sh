#!/bin/bash

# Check that at least one argument was give
if [[ $# -lt 1 ]]; then
    echo "Usage: ./fir_to_arc.sh <filename>.fir" >&2
    exit 2
fi

# Assume it's a .fir and that circt-opt firtool and arcilator are in the path
# Step 1: Convert .fir to firrtl mlir dialect
firtool --ir-fir $1 >> tmp_fir.mlir

# Step 2: Convert mlir fir to hw
circt-opt --lower-firrtl-to-hw tmp_fir.mlir >> tmp_hw.mlir

# Step 3: Convert hw to arc
arcilator tmp_hw.mlir

# Clean-up tmp files
rm tmp_fir.mlir tmp_hw.mlir
