#!/bin/bash

# Run setup just in case
./setup_bin.sh

# Check that at least one argument was give
if [[ $# -lt 1 ]]; then
    echo "Usage: ./cmp_arc_btor.sh <filename>.fir" >&2
    exit 2
fi

# Print out initial firrtl
echo " "
echo "===================="
echo "Initial FIRRTL:"
echo "===================="
echo " "
cat $1

# Assume it's a .fir and that circt-opt firtool and arcilator are in the path
# Step 1: Convert .fir to firrtl mlir dialect
firtool --ir-fir $1 >> tmp_fir.mlir

# Step 2: Convert mlir fir to hw
circt-opt --lower-firrtl-to-hw tmp_fir.mlir >> tmp_hw.mlir

# Step 3: Convert hw to arc
echo " "
echo "===================="
echo "Output from arcilator:"
echo "===================="
echo " "
arcilator tmp_hw.mlir

# Clean-up tmp files
rm tmp_fir.mlir tmp_hw.mlir

# Part 2: Run firrtl
firrtl -E btor2 -i $1 -o tmp.btor2

# Print out result
echo " "
echo "===================="
echo "Output from firrtl formal:"
echo "===================="
echo " "
cat tmp.btor2

# Cleanup tmp files
rm tmp.btor2

