hw.module @Counter(in %clock : !seq.clock, in %reset : i1, in %en : i1, in %a : i32) {
    %0 = seq.from_clock %clock
    %c0_i28 = hw.constant 0 : i28
    %c0_i27 = hw.constant 0 : i27
    %false = hw.constant false
    %true = hw.constant true
    %c-10_i5 = hw.constant -10 : i5
    %c-6_i4 = hw.constant -6 : i4
    %c0_i32 = hw.constant 0 : i32
    %b = hw.wire %3  : i32
    %1 = comb.concat %false, %a : i1, i32
    %c1_i33 = hw.constant 1 : i33
    %2 = comb.add bin %1, %c1_i33 {sv.namehint = "_b_T"} : i33
    %3 = comb.extract %2 from 0 {sv.namehint = "_b_T_1"} : (i33) -> i32
    %count = seq.firreg %12 clock %clock reset sync %reset, %b {firrtl.random_init_start = 0 : ui64} : i32
    %c22_i32 = hw.constant 22 : i32
    %4 = comb.icmp bin eq %count, %c22_i32 {sv.namehint = "_T"} : i32
    %5 = comb.and bin %en, %4 {sv.namehint = "_T_1"} : i1
    %6 = comb.mux bin %5, %c0_i32, %count : i32
    %c22_i32_0 = hw.constant 22 : i32
    %7 = comb.icmp bin ne %count, %c22_i32_0 {sv.namehint = "_T_2"} : i32
    %8 = comb.and bin %en, %7 {sv.namehint = "_T_3"} : i1
    %9 = comb.concat %false, %count : i1, i32
    %c1_i33_1 = hw.constant 1 : i33
    %10 = comb.add bin %9, %c1_i33_1 {sv.namehint = "_count_T"} : i33
    %11 = comb.extract %10 from 0 {sv.namehint = "_count_T_1"} : (i33) -> i32
    %12 = comb.mux bin %8, %11, %6 : i32
    %c10_i32 = hw.constant 10 : i32
    %13 = comb.icmp bin ne %count, %c10_i32 {sv.namehint = "_T_4"} : i32
    %14 = comb.xor bin %reset, %true {sv.namehint = "_T_6"} : i1
    sv.always posedge %0 {
      sv.if %14 {
        sv.assert %13, immediate label "assert__assert"
      }
    }
    hw.output
  }
