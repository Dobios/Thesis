module {
  hw.module @Counter(in %clock : !seq.clock, in %reset : i1) {
    %c1_i5 = hw.constant 1 : i5
    %c10_i5 = hw.constant 10 : i5
    %true = hw.constant true
    %c-10_i5 = hw.constant -10 : i5
    %c0_i5 = hw.constant 0 : i5
    %0 = seq.from_clock %clock
    %count = seq.firreg %3 clock %clock reset sync %reset, %c0_i5 {firrtl.random_init_start = 0 : ui64} : i5
    %1 = comb.add %count, %c1_i5 {sv.namehint = "_count_T"} : i5
    %2 = comb.icmp bin eq %count, %c-10_i5 : i5
    %3 = comb.mux bin %2, %c0_i5, %1 : i5
    %4 = comb.icmp bin ne %count, %c0_i5 : i5
    %5 = comb.icmp bin ult %count, %c10_i5 : i5
    %6 = ltl.delay %true, 1, 0 : i1
    %7 = ltl.concat %4, %6 : i1, !ltl.sequence
    %8 = ltl.implication %7, %5 : !ltl.sequence, i1
    %9 = verif.has_been_reset %0, sync %reset
    %10 = comb.xor bin %9, %true {sv.namehint = "disable"} : i1
    %11 = ltl.disable %8 if %10 : !ltl.property
    %12 = ltl.clock %11, posedge %0 : !ltl.property
    verif.assert %12 : !ltl.property
    hw.output
  }
}
