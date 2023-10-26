circuit Counter :
  module Counter :
    input clock : Clock
    input reset : UInt<1>
    input en : UInt<1>

    reg count : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[counter.scala 7:24]
    node _T = eq(count, UInt<5>("h16")) @[counter.scala 8:22]
    node _T_1 = and(en, _T) @[counter.scala 8:13]
    when _T_1 : @[counter.scala 8:32]
      count <= UInt<1>("h0") @[counter.scala 8:40]
    node _T_2 = neq(count, UInt<5>("h16")) @[counter.scala 9:22]
    node _T_3 = and(en, _T_2) @[counter.scala 9:13]
    when _T_3 : @[counter.scala 9:32]
      node _count_T = add(count, UInt<1>("h1")) @[counter.scala 9:49]
      node _count_T_1 = tail(_count_T, 1) @[counter.scala 9:49]
      count <= _count_T_1 @[counter.scala 9:40]
    node _T_4 = neq(count, UInt<4>("ha")) @[counter.scala 10:18]
    node _T_5 = bits(reset, 0, 0) @[counter.scala 10:11]
    node _T_6 = eq(_T_5, UInt<1>("h0")) @[counter.scala 10:11]
    when _T_6 : @[counter.scala 10:11]
      node _T_7 = eq(_T_4, UInt<1>("h0")) @[counter.scala 10:11]
      when _T_7 : @[counter.scala 10:11]
        printf(clock, UInt<1>("h1"), "Assertion failed\n    at counter.scala:10 assert(count =/= 10.U)\n") : printf @[counter.scala 10:11]
      assert(clock, _T_4, UInt<1>("h1"), "") : assert @[counter.scala 10:11]


