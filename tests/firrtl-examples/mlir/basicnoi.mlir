module {
  hw.module @NOI(in %clock : !seq.clock, in %reset : i1, in %a : i1, in %b : i1) {
    %true = hw.constant true
    %0 = seq.from_clock %clock
    %1 = ltl.delay %true, 1, 0 : i1
    %2 = ltl.concat %a, %1 : i1, !ltl.sequence
    %3 = ltl.implication %2, %b : !ltl.sequence, i1
    %4 = verif.has_been_reset %0, sync %reset
    %5 = comb.xor bin %4, %true {sv.namehint = "disable"} : i1
    %6 = ltl.disable %3 if %5 : !ltl.property
    %7 = ltl.clock %6, posedge %0 : !ltl.property
    verif.assert %7 : !ltl.property
    hw.output
  }
}
