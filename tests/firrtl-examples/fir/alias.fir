FIRRTL version 3.1.0
circuit Alias :
  module Alias :
    input clock : Clock
    input reset : UInt<1>
    input in : UInt<1> @[src/test/scala/ltl/LTLSpec.scala 42:18]
    output out : UInt<32> @[src/test/scala/ltl/LTLSpec.scala 46:19]

    regreset count : UInt<32>, clock, reset, UInt<32>(0h0) @[src/test/scala/ltl/LTLSpec.scala 43:26]
    wire b : UInt<33> @[src/test/scala/ltl/LTLSpec.scala 44:19]
    wire c : UInt<33> @[src/test/scala/ltl/LTLSpec.scala 45:19]
    node _b_T = add(count, UInt<1>(0h1)) @[src/test/scala/ltl/LTLSpec.scala 47:18]
    node _b_T_1 = tail(_b_T, 1) @[src/test/scala/ltl/LTLSpec.scala 47:18]
    connect b, _b_T_1 @[src/test/scala/ltl/LTLSpec.scala 47:9]
    node _c_T = and(b, UInt<1>(0h1)) @[src/test/scala/ltl/LTLSpec.scala 48:14]
    connect c, _c_T @[src/test/scala/ltl/LTLSpec.scala 48:9]
    when in : @[src/test/scala/ltl/LTLSpec.scala 49:16]
      connect count, b @[src/test/scala/ltl/LTLSpec.scala 49:23]
    else :
      connect count, c @[src/test/scala/ltl/LTLSpec.scala 49:46]
    connect out, count @[src/test/scala/ltl/LTLSpec.scala 50:11]
    