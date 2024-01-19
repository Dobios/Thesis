FIRRTL version 3.1.0
circuit Counter :
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

    regreset count : UInt<32>, clock, reset, UInt<32>(0h0) @[src/test/scala/ltl/LTLSpec.scala 31:28]
    node _T = eq(count, UInt<5>(0h16)) @[src/test/scala/ltl/LTLSpec.scala 32:20]
    when _T : @[src/test/scala/ltl/LTLSpec.scala 32:30]
      connect count, UInt<1>(0h0) @[src/test/scala/ltl/LTLSpec.scala 32:38]
    node _T_1 = neq(count, UInt<5>(0h16)) @[src/test/scala/ltl/LTLSpec.scala 33:20]
    when _T_1 : @[src/test/scala/ltl/LTLSpec.scala 33:30]
      node _count_T = add(count, UInt<1>(0h1)) @[src/test/scala/ltl/LTLSpec.scala 33:47]
      node _count_T_1 = tail(_count_T, 1) @[src/test/scala/ltl/LTLSpec.scala 33:47]
      connect count, _count_T_1 @[src/test/scala/ltl/LTLSpec.scala 33:38]
    node _T_2 = neq(count, UInt<4>(0ha)) @[src/test/scala/ltl/LTLSpec.scala 34:30]
    inst HasBeenResetIntrinsic of HasBeenResetIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    connect HasBeenResetIntrinsic.clock, clock @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    connect HasBeenResetIntrinsic.reset, reset @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    node disable = eq(HasBeenResetIntrinsic.out, UInt<1>(0h0)) @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    inst ltl_disable of LTLDisableIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 329:34]
    connect ltl_disable.in, _T_2 @[src/main/scala/chisel3/ltl/LTL.scala 330:20]
    connect ltl_disable.condition, disable @[src/main/scala/chisel3/ltl/LTL.scala 331:27]
    inst ltl_clock of LTLClockIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 318:32]
    connect ltl_clock.in, ltl_disable.out @[src/main/scala/chisel3/ltl/LTL.scala 319:18]
    connect ltl_clock.clock, clock @[src/main/scala/chisel3/ltl/LTL.scala 320:21]
    inst verif of VerifAssertIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 375:59]
    connect verif.property, ltl_clock.out @[src/main/scala/chisel3/ltl/LTL.scala 363:20]