FIRRTL version 3.1.0
circuit LTLSpec_Anon :
  intmodule LTLDisableIntrinsic :
    input in : UInt<1>
    input condition : UInt<1>
    output out : UInt<1>
    intrinsic = circt_ltl_disable

  intmodule VerifAssertIntrinsic :
    input property : UInt<1>
    intrinsic = circt_verif_assert

  module LTLSpec_Anon :
    input a : UInt<1>
    input rst : UInt<1> 

    wire n_rst : UInt<1> 
    node _n_rst_T = eq(rst, UInt<1>(0h0)) 
    connect n_rst, _n_rst_T
    node x2 = bits(n_rst, 0, 0) 
    inst ltl_disable of LTLDisableIntrinsic 
    connect ltl_disable.in, a 
    connect ltl_disable.condition, x2 
    inst verif of VerifAssertIntrinsic 
    connect verif.property, ltl_disable.out 

