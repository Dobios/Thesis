circuit Counter :
  module Counter :
    input clock : Clock
    input reset : UInt<1>
    input en : UInt<1>

    reg count : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0"))

    when and(eq(count, UInt<32>(22)), en) :
      count <= UInt<1>("h0")

    when and(neq(count, UInt<32>(22)), en) :
      count <= tail(add(count, UInt<1>("h1")), 1)

    assert(clock, neq(count, UInt<4>("ha")), en, "Counter reached 10!")

