module {
   hw.module @test(in %clock : !seq.clock, in %reset : i1, in %8 : i1) {
    %0 = seq.from_clock %clock 
    %true = hw.constant true
    %9 = verif.has_been_reset %0, sync %reset
    %10 = comb.xor bin %9, %true : i1
    %11 = hw.wire %8 : i1
    %12 = hw.wire %10 : i1
    %13 = ltl.disable %11 if %12 : i1
    %14 = ltl.clock %13, posedge %0 : !ltl.property
    verif.assert %14 : !ltl.property
    hw.output
  }
}
