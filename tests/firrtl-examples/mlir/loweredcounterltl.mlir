module {
  hw.module @Counter(in %clock : !seq.clock, in %reset : i1) {
    %0 = seq.from_clock %clock
    %c0_i28 = hw.constant 0 : i28
    %false = hw.constant false
    %c0_i27 = hw.constant 0 : i27
    %c0_i32 = hw.constant 0 : i32
    %c-10_i5 = hw.constant -10 : i5
    %true = hw.constant true
    %c-6_i4 = hw.constant -6 : i4
    %count = seq.firreg %7 clock %clock reset sync %reset, %c0_i32 {firrtl.random_init_start = 0 : ui64} : i32
    %c22_i32 = hw.constant 22 : i32
    %1 = comb.icmp bin eq %count, %c22_i32 : i32
    %2 = comb.mux bin %1, %c0_i32, %count : i32
    %3 = comb.concat %false, %count : i1, i32
    %c1_i33 = hw.constant 1 : i33
    %4 = comb.add bin %3, %c1_i33 {sv.namehint = "_count_T"} : i33
    %5 = comb.extract %4 from 0 {sv.namehint = "_count_T_1"} : (i33) -> i32
    %c22_i32_0 = hw.constant 22 : i32
    %6 = comb.icmp bin eq %count, %c22_i32_0 : i32
    %7 = comb.mux bin %6, %2, %5 : i32
    %c10_i32 = hw.constant 10 : i32
    %8 = comb.icmp bin ne %count, %c10_i32 : i32
    %false_1 = hw.constant false
    %9 = comb.or %reset, %hbr : i1
    %hbr = seq.compreg sym @hbr  %9, %clock powerOn %false_1 : i1  
    %10 = comb.xor bin %hbr, %true {sv.namehint = "disable"} : i1
    %11 = hw.wire %8  : i1
    %12 = hw.wire %10  : i1
    %13 = comb.or %12, %11 : i1
    sv.always posedge %0 {
      sv.assert %13, immediate
    }
    hw.output
  }
}

