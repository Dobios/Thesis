#!/bin/bash

# Run setup just in case
./setup_bin.sh

# Check that at least one argument was give
if [[ $# -lt 1 ]]; then
    echo "Usage: ./cmp_arc_btor.sh <filename>.fir [optional: <outname>]" >&2
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
firtool --format=fir --ir-fir  $1 >> tmp_fir.mlir

# Print out firrtl ir
echo " "
echo "===================="
echo " FIRRTL MLIR:"
echo "===================="
echo " "
cat tmp_fir.mlir

# Step 2: Convert mlir fir to hw
#circt-opt --lower-firrtl-to-hw --arc-inline-modules tmp_fir.mlir >> tmp_hw.mlir
if [[ $# -gt 1 ]]; then
    circt-opt --lower-firrtl-to-hw tmp_fir.mlir >> $2

    echo " "
    echo "===================="
    echo "Output from hw:"       
    echo "===================="
    echo " "

    cat $2
    rm tmp_fir.mlir
else 
    circt-opt --lower-firrtl-to-hw tmp_fir.mlir >> tmp_hw.mlir

    echo " "
    echo "===================="
    echo "Output from hw:"       
    echo "===================="
    echo " "

    cat tmp_hw.mlir
    rm tmp_fir.mlir tmp_hw.mlir
fi







