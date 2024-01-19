FIRRTL version 3.1.0
circuit LTLSpec_Anon :
  intmodule VerifAssertIntrinsic :
    input property : UInt<1>
    intrinsic = circt_verif_assert

  module LTLSpec_Anon :
    input a : UInt<1> 

    inst verif of VerifAssertIntrinsic 
    connect verif.property, a 

    