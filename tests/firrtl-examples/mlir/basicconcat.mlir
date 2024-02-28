module {
  hw.module @Basic(in %clock : !seq.clock, in %reset : i1, in %a : i1, in %b : i1, in %c : i1) {
    %true = hw.constant true
    %0 = seq.from_clock %clock
    %1 = ltl.delay %b, 3, 0 : i1
    %2 = ltl.concat %a, %1, %c : i1, !ltl.sequence, i1
    %3 = verif.has_been_reset %0, sync %reset
    %4 = comb.xor bin %3, %true {sv.namehint = "disable"} : i1
    %5 = ltl.disable %2 if %4 : !ltl.sequence
    %6 = ltl.clock %5, posedge %0 : !ltl.property
    verif.assert %6 : !ltl.property
    hw.output
  }
}


