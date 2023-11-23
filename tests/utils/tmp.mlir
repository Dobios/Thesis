module {
  hw.module @inc(in %a : i32, in %clk : !seq.clock, out pred : i1) {
    %0 = seq.from_clock %clk
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %true = hw.constant true
    %.pred.output = hw.wire %4  : i1
    %b = hw.wire %3  : i32
    %1 = comb.concat %false, %a : i1, i32
    %c1_i33 = hw.constant 1 : i33
    %2 = comb.add bin %1, %c1_i33 : i33
    %3 = comb.extract %2 from 0 : (i33) -> i32
    %4 = comb.icmp bin ugt %b, %a : i32
    sv.always posedge %0 {
      sv.if %true {
        sv.assert %.pred.output, immediate message "a + 1 should be greater than a"
      }
    }
    hw.output %.pred.output : i1
  }
}

