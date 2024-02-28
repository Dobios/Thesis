module {
  hw.module @NOI(in %clock : !seq.clock, in %reset : i1, in %a : i1, in %b : i1, out res : i1) {
    %true = hw.constant true
    %0 = seq.from_clock %clock
    %false = hw.constant false
    %true_0 = hw.constant true
    %1 = comb.or %reset, %hbr : i1
    %hbr = seq.compreg sym @hbr  %1, %clock powerOn %false : i1  
    %2 = comb.xor %reset, %true_0 : i1
    %3 = comb.and %hbr, %2 : i1
    %4 = comb.xor bin %3, %true {sv.namehint = "disable"} : i1
    %false_1 = hw.constant false
    %true_2 = hw.constant true
    %5 = comb.add %delay_, %true_2 : i1
    %true_3 = hw.constant true
    %6 = comb.icmp bin eq %delay_, %true_3 : i1
    %7 = comb.mux %6, %true_3, %5 : i1
    %delay_ = seq.compreg sym @delay_  %7, %clock reset %reset, %false_1 powerOn %false_1 : i1  
    %false_4 = hw.constant false
    %_0 = seq.compreg sym @_0  %true, %clock reset %reset, %false_4 powerOn %false_4 : i1  
    %8 = comb.icmp bin ult %delay_, %true_3 : i1
    %true_5 = hw.constant true
    %9 = comb.xor %_0, %true_5 : i1
    %10 = comb.or %9, %b : i1
    %11 = comb.or %8, %10 : i1
    %12 = comb.or %11, %reset : i1
    %13 = comb.or %4, %12 : i1
    sv.always posedge %0 {
      sv.assert %13, immediate
    }
    hw.output %13 : i1
  }
}
