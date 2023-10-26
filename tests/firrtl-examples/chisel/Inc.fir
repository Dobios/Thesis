circuit Inc :
  module Inc :
    input clock : Clock
    input reset : UInt<1>
    input a : UInt<32>
    input en : UInt<1>

    node _b_T = add(a, UInt<1>("h1")) @[inc.scala 8:15]
    node b = tail(_b_T, 1) @[inc.scala 8:15]
    node _T = gt(b, a) @[inc.scala 10:14]
    node _T_1 = bits(reset, 0, 0) @[inc.scala 10:11]
    node _T_2 = eq(_T_1, UInt<1>("h0")) @[inc.scala 10:11]
    when _T_2 : @[inc.scala 10:11]
      node _T_3 = eq(_T, UInt<1>("h0")) @[inc.scala 10:11]
      when _T_3 : @[inc.scala 10:11]
        printf(clock, UInt<1>("h1"), "Assertion failed: b shoudl always be bigger than a\n    at inc.scala:10 assert(b > a, \"b shoudl always be bigger than a\")\n") : printf @[inc.scala 10:11]
      assert(clock, _T, UInt<1>("h1"), "") : assert @[inc.scala 10:11]


