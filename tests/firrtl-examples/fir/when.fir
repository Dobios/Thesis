circuit inc:
  module inc:
    input a : UInt<32>
    input clk : Clock
    output pred: UInt<1>

    wire assumption : UInt<1>
    wire b : UInt<32>
    wire en: UInt<1>

    en <= UInt<1>("h1")

    assumption <= gt(a, UInt<1>("h0"))
    assume(clk, assumption, en, "a should be greater than 0")

    when lt(a, UInt<32>(23)) :
      b <= add(a, UInt<1>("h1"))
    else :
      b <= add(a, UInt<2>(2))
    pred <= gt(b, a)
    assert(clk, pred, en, "a + 1 should be greater than a")


