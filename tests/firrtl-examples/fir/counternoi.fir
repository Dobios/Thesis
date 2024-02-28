FIRRTL version 3.1.0
circuit Counter :
  intmodule LTLDelayIntrinsic_1_0 :
    input in : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_delay
    parameter delay = 1
    parameter length = 0

  intmodule LTLConcatIntrinsic :
    input lhs : UInt<1>
    input rhs : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_concat

  intmodule LTLImplicationIntrinsic :
    input lhs : UInt<1>
    input rhs : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_implication

  intmodule HasBeenResetIntrinsic :
    input clock : Clock
    input reset : Reset
    output out : UInt<1>
    intrinsic = circt_has_been_reset

  intmodule LTLDisableIntrinsic :
    input in : UInt<1>
    input condition : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_disable

  intmodule LTLClockIntrinsic :
    input in : UInt<1>
    input clock : Clock
    output out : UInt<1>
    intrinsic = circt_ltl_clock

  intmodule VerifAssertIntrinsic :
    input property : UInt<1>
    intrinsic = circt_verif_assert

  module Counter :
    input clock : Clock
    input reset : UInt<1>

    regreset count : UInt<5>, clock, reset, UInt<5>(0h0) @[src/test/scala/ltl/LTLSpec.scala 42:26]
    node _T = neq(count, UInt<5>(0h16)) @[src/test/scala/ltl/LTLSpec.scala 44:18]
    when _T : @[src/test/scala/ltl/LTLSpec.scala 44:28]
      node _count_T = add(count, UInt<1>(0h1)) @[src/test/scala/ltl/LTLSpec.scala 44:44]
      node _count_T_1 = tail(_count_T, 1) @[src/test/scala/ltl/LTLSpec.scala 44:44]
      connect count, _count_T_1 @[src/test/scala/ltl/LTLSpec.scala 44:35]
    node _T_1 = eq(count, UInt<5>(0h16)) @[src/test/scala/ltl/LTLSpec.scala 45:18]
    when _T_1 : @[src/test/scala/ltl/LTLSpec.scala 45:28]
      connect count, UInt<1>(0h0) @[src/test/scala/ltl/LTLSpec.scala 45:35]
    node _T_2 = gt(count, UInt<1>(0h0)) @[src/test/scala/ltl/LTLSpec.scala 47:63]
    node _T_3 = lt(count, UInt<4>(0ha)) @[src/test/scala/ltl/LTLSpec.scala 47:76]
    inst ltl_delay of LTLDelayIntrinsic_1_0 @[src/main/scala/chisel3/ltl/LTL.scala 113:32]
    connect ltl_delay.in, UInt<1>(0h1) @[src/main/scala/chisel3/ltl/LTL.scala 114:18]
    inst ltl_concat of LTLConcatIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 143:35]
    connect ltl_concat.lhs, _T_2 @[src/main/scala/chisel3/ltl/LTL.scala 144:22]
    connect ltl_concat.rhs, ltl_delay.out @[src/main/scala/chisel3/ltl/LTL.scala 145:22]
    inst ltl_implication of LTLImplicationIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 259:38]
    connect ltl_implication.lhs, ltl_concat.out @[src/main/scala/chisel3/ltl/LTL.scala 260:25]
    connect ltl_implication.rhs, _T_3 @[src/main/scala/chisel3/ltl/LTL.scala 261:25]
    inst HasBeenResetIntrinsic of HasBeenResetIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    connect HasBeenResetIntrinsic.clock, clock @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    connect HasBeenResetIntrinsic.reset, reset @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    node disable = eq(HasBeenResetIntrinsic.out, UInt<1>(0h0)) @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    inst ltl_disable of LTLDisableIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 329:34]
    connect ltl_disable.in, ltl_implication.out @[src/main/scala/chisel3/ltl/LTL.scala 330:20]
    connect ltl_disable.condition, disable @[src/main/scala/chisel3/ltl/LTL.scala 331:27]
    inst ltl_clock of LTLClockIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 318:32]
    connect ltl_clock.in, ltl_disable.out @[src/main/scala/chisel3/ltl/LTL.scala 319:18]
    connect ltl_clock.clock, clock @[src/main/scala/chisel3/ltl/LTL.scala 320:21]
    inst verif of VerifAssertIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 375:59]
    connect verif.property, ltl_clock.out @[src/main/scala/chisel3/ltl/LTL.scala 363:20]