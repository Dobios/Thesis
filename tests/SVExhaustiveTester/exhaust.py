import os
import subprocess
from tqdm import tqdm
import random
import sys
from BitVector import BitVector

design_ltl = "designs/noiltl.sv"
design_core = "designs/noicore.sv"

##
# Given a number of cycles and an input bitvector, generate a testbench
# that stimulates NOI with that exact input vector during n cycles
##
def generateTB(n: int, bitvec_a: list[int], bitvec_b : list[int]) -> str:
    # Sanity check: the bitvectors must be larger than n
    assert(len(bitvec_a) >= n and len(bitvec_b) >= n)

    src_start: str = """
        module tb;
        reg clock;
        reg reset;
        reg a;
        reg b;

        NOI dut (.clock(clock),
                    .reset(reset),
                    .a(a),
                    .b(b));

        always #5 clock = ~clock;

        initial begin
            reset <= 1;
            {clock, a, b} <= 0;

            repeat(2) @(posedge clock);
            reset <= 0;
            
            // Bitvector execution
    """
    src_end: str = """
            repeat(2) @(posedge clock);
            #20 $finish;
        end
        endmodule
    """
    
    # The bitvectors each generate a stimuli for a and b
    src_middle = ""
    for i in range(0, n):
        src_middle += """
                a <= %s;
                b <= %s;
                @(posedge clock);
        """ % (bitvec_a[i], bitvec_b[i])

    return src_start + src_middle + src_end

##
# Generates a bitvector encoding a given value in a width n
##
def generateBV(n: int, val: int) -> list[int]:
    bv = BitVector(intVal = val, size = n)
    return [bv[i] for i in range(0, n)]

##
# Runs a given vcs command and parses the output
##
def runVCSAndParseOutput(cmd: str) -> bool:
    # Run vcs
    result = subprocess.run(cmd.split(' '), stdout=subprocess.PIPE)

    # Parse output
    res_str = result.stdout.decode('utf-8')

    # Look for lines containing "Offending"
    for line in res_str.strip('\t').splitlines():
        if "Offending" in line.split(' '):
            return False
        
    return True

##
# Runs the given testbench using the given bitvectors
##
def runTB(testbench: str, bv_a: list[int], bv_b: list[int], i: int, j: int):
    # Write the testbench to a file and run it
    tb_file = "tb/tb_%d_%d.sv" % (i, j)
    vcs_ltl = "vcs -full64 -q -sverilog -Mupdate -debug_access+all +incdir+./vlog -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' %s %s && ./simv +vcs+lic+wait" % (design_ltl, tb_file)
    vcs_core = "vcs -full64 -q -sverilog -Mupdate -debug_access+all +incdir+./vlog -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' %s %s && ./simv +vcs+lic+wait" % (design_core, tb_file)

    if os.path.exists(tb_file):
        os.remove(tb_file)

    with open(tb_file, "x+") as tb:
        tb.write(testbench)

        ## Run vcs on this test bench for both designs
        ## and compare the results
        #res_ltl = True
        #res_core = True
        res_ltl = runVCSAndParseOutput(vcs_ltl)
        res_core = runVCSAndParseOutput(vcs_core)

        assert res_ltl == res_core, "a = %s\nb = %s\n, n = %d\n HAS FAILED: res_ltl = %s, res_core = %s" % \
            (str(bv_a), str(bv_b), n, str(res_ltl), str(res_core))
        
    if os.path.exists(tb_file):
        os.remove(tb_file)

##
# Exhaustively tests a design for a given number of cycles
# @param{int} n: number of cycles during which we want to test our designs
# @param{bool} rand: Whether or not a random walk method is selected
# @param{int} max_gen: If we select a random walk, the number of vectors we want to produce 
##
def exhaustTest(n: int, rand : bool = False, max_gen : int = -1):
    # We iterate over every possible value of width n 
    # and generate a testbench for it
    if not rand:
        for i in tqdm(range(0, 2**n)):
            bv_a = generateBV(n, i)
            for j in range(0, 2**n):
                bv_b = generateBV(n, j)
                testbench = generateTB(n, bv_a, bv_b)

                # Run the testbench
                runTB(testbench, bv_a, bv_b, i, j)
                
                
    # Random walk: allow for a quicker termination if needed
    else:
        # Store visited values
        count = 0
        for i in tqdm(range(0, 2**n)):
            vis_a = []
            vis_b = []
            for j in range(0, 2**n):
                # check for termination
                if max_gen != -1 and count >= max_gen:
                    return
                
                # Generate new values for a and b
                a = random.randint(0, 2**n - 1)
                while a in vis_a:
                    a = random.randint(0, 2**n - 1)

                b = random.randint(0, 2**n - 1)
                while b in vis_b:
                    b = random.randint(0, 2**n - 1)
                
                vis_a.append(a)
                vis_b.append(b)

                # Convert those values to bitvectors
                bv_a = generateBV(n, a)
                bv_b = generateBV(n, b)

                # Generate the testbench
                testbench = generateTB(n, bv_a, bv_b)

                # run it
                runTB(testbench, bv_a, bv_b, i, j)

                count += 1

# Read command line arguments and exhaustively test for the requested amount of cyles
# using the requested method, i.e. random walk or linear walk
if __name__ == "__main__":
    # Read command line arguments
    if len(sys.argv) < 2:
        print("Usage: python exhaust.py <n: int> [optional]<rand: bool> [optional]<max_gen: int>")
        exit(1)

    n = int(sys.argv[1])

    rand = False
    max_gen = -1

    # Read the optional parameters
    if len(sys.argv) > 2:
        rand = bool(sys.argv[2])
    if len(sys.argv) > 3:
        max_gen = int(sys.argv[3])

    # Limit the size of n to avoid any issues
    if max_gen == -1:
        if n > 32:
            print("n must be at most 32 (for practical reasons). If you want to use a higher n, please add a max_gen value of at most 2**32")
            exit(1)
    elif max_gen > 2**32 or not rand:
        print("Please limit the amount of vectors you want to generate!")

    # Run the exhaustive testing
    print("Starting exhaustive testing for %d cycles with rand = %s and max_gen = %s" % (n, str(rand), str(max_gen)))
    exhaustTest(n, rand, max_gen)
    print("Successfully finished test campaign.")

