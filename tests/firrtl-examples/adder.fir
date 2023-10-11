circuit Adder :
  module Adder :
    input clock : Clock
    input reset : UInt<1>
    input in : UInt<8>
    input in2 : UInt<8>
    output out : UInt<9>
    output out2 : UInt<9>

    when lt(in, in2):
      node out_T_2 = sub(in2, in)
      out2 <= out_T_2
    else :
      node out_T_3 = sub(in, in2)
      out2 <= out_T_3

    node _out_T = add(in, in2) @[main.scala 11:13]
    out <= _out_T @[main.scala 11:7]
    
