circuit Counter :
  module Counter :
    input clock : Clock
    input reset : UInt<1>
    input en : UInt<1>
    input a : UInt<32>

    wire b : UInt<32> @[main.scala 8:21]
    node _b_T = add(a, UInt<1>("h1")) @[main.scala 9:16]
    node _b_T_1 = tail(_b_T, 1) @[main.scala 9:16]
    b <= _b_T_1 @[main.scala 9:11]
    reg count : UInt, clock with :
      reset => (reset, b) @[main.scala 10:24]
    node _T = eq(count, UInt<5>("h16")) @[main.scala 11:22]
    node _T_1 = and(en, _T) @[main.scala 11:13]
    when _T_1 : @[main.scala 11:32]
      count <= UInt<1>("h0") @[main.scala 11:40]
    node _T_2 = neq(count, UInt<5>("h16")) @[main.scala 12:22]
    node _T_3 = and(en, _T_2) @[main.scala 12:13]
    when _T_3 : @[main.scala 12:32]
      node _count_T = add(count, UInt<1>("h1")) @[main.scala 12:49]
      node _count_T_1 = tail(_count_T, 1) @[main.scala 12:49]
      count <= _count_T_1 @[main.scala 12:40]
    node _T_4 = neq(count, UInt<4>("ha")) @[main.scala 13:18]
    node _T_5 = bits(reset, 0, 0) @[main.scala 13:11]
    node _T_6 = eq(_T_5, UInt<1>("h0")) @[main.scala 13:11]
    when _T_6 : @[main.scala 13:11]
      assert(clock, _T_4, UInt<1>("h1"), "") : assert @[main.scala 13:11]