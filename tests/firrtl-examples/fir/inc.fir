circuit inc:
  module inc:
    input a : UInt<32>
    input clk : Clock
    output pred: UInt<1>

    wire b : UInt<32>
    wire en: UInt<1>
    b <= add(a, UInt<1>("h1"))
    en <= UInt<1>("h1")
    pred <= lt(b, a)
    assert(clk, pred, en, "a + 1 should be greater than a")


