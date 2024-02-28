FIRRTL version 3.1.0
circuit Basic :
  intmodule LTLDelayIntrinsic_3_0 :
    input in : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_delay
    parameter delay = 3
    parameter length = 0

  intmodule LTLConcatIntrinsic :
    input lhs : UInt<1>
    input rhs : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_concat

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

  module Basic :
    input clock : Clock
    input reset : UInt<1>
    input a : UInt<1> @[src/test/scala/ltl/LTLSpec.scala 55:23]
    input b : UInt<1> @[src/test/scala/ltl/LTLSpec.scala 55:23]
    input c : UInt<1> @[src/test/scala/ltl/LTLSpec.scala 55:23]

    inst ltl_delay of LTLDelayIntrinsic_3_0 @[src/main/scala/chisel3/ltl/LTL.scala 113:32]
    connect ltl_delay.in, b @[src/main/scala/chisel3/ltl/LTL.scala 114:18]
    inst ltl_concat of LTLConcatIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 143:35]
    connect ltl_concat.lhs, a @[src/main/scala/chisel3/ltl/LTL.scala 144:22]
    connect ltl_concat.rhs, ltl_delay.out @[src/main/scala/chisel3/ltl/LTL.scala 145:22]
    inst ltl_concat_1 of LTLConcatIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 143:35]
    connect ltl_concat_1.lhs, ltl_concat.out @[src/main/scala/chisel3/ltl/LTL.scala 144:22]
    connect ltl_concat_1.rhs, c @[src/main/scala/chisel3/ltl/LTL.scala 145:22]
    inst HasBeenResetIntrinsic of HasBeenResetIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    connect HasBeenResetIntrinsic.clock, clock @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    connect HasBeenResetIntrinsic.reset, reset @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    node disable = eq(HasBeenResetIntrinsic.out, UInt<1>(0h0)) @[src/main/scala/chisel3/ltl/LTL.scala 357:39]
    inst ltl_disable of LTLDisableIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 329:34]
    connect ltl_disable.in, ltl_concat_1.out @[src/main/scala/chisel3/ltl/LTL.scala 330:20]
    connect ltl_disable.condition, disable @[src/main/scala/chisel3/ltl/LTL.scala 331:27]
    inst ltl_clock of LTLClockIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 318:32]
    connect ltl_clock.in, ltl_disable.out @[src/main/scala/chisel3/ltl/LTL.scala 319:18]
    connect ltl_clock.clock, clock @[src/main/scala/chisel3/ltl/LTL.scala 320:21]
    inst verif of VerifAssertIntrinsic @[src/main/scala/chisel3/ltl/LTL.scala 375:59]
    connect verif.property, ltl_clock.out @[src/main/scala/chisel3/ltl/LTL.scala 363:20]