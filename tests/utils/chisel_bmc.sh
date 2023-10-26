#!/bin/bash

# Run setup just in case
./setup_bin.sh

# Check that at least one argument was give
if [[ $# -lt 2 ]]; then
    echo "Usage: ./chisel_bmc <path_to_chisel_root> <module_name> [optional: <outname>]" >&2
    exit 2
fi

# We assume that this script is run from the utils folder
sourcedir=$(pwd)

# Start by running the scala firrtl compiler to generate a .fir
echo " "
echo "Compiling Chisel file..."
echo " "
cd $1
driverName=$2
driverName+="Driver"
sbt "runMain $driverName"

# Print out initial firrtl
echo " "
echo "===================="
echo "Initial FIRRTL:"
echo "===================="
echo " "
cat $2".fir"

# Assume it's a .fir and that circt-opt firtool and arcilator are in the path
# Step 1: Convert .fir to firrtl mlir dialect
firtool --ir-fir $2".fir" >> tmp_fir.mlir

# Step 2: Convert mlir fir to hw
circt-opt --lower-firrtl-to-hw tmp_fir.mlir >> tmp_hw.mlir
echo " "
echo "===================="
echo "Output from hw:"       
echo "===================="
echo " "

cat tmp_hw.mlir

# Step 3: Run btor lowering pass
echo " "
echo "===================="
echo "Output from LowerHWtoBTOR2:"       
echo "===================="
echo " "
circt-opt --hw-lower-to-botr2 tmp_hw.mlir >> tmp_btor.txt

# Clean-up tmp files
rm tmp_fir.mlir tmp_hw.mlir tmp_btor.txt

# copy the tmp_btor.txt over to where the cleanup script is located
cp btor_tmp.btor2 $sourcedir

# now return to the utils directory to finish the job
cd $sourcedir

# Cleanup the output from the circt lowering pass
#python3 cleanupBtor.py tmp_btor.txt $outputname

#cat btor_tmp.btor2

# Step 4: Run in btorMC
btormc --v btor_tmp.btor2

# Cleanup remaining temp
rm btor_tmp.btor2





