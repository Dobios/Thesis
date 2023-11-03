circuit Counter :
  module Adder :
    input clock : Clock
    input reset : Reset
    input a : UInt<32>
    input b : UInt<32>
    output c : UInt<32>

    c <= tail(add(a, b), 1)  

  module Counter :
    input clock : Clock
    input reset : UInt<1>
    input en : UInt<1>

    reg count : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) 
      
    when and(en, eq(count, UInt<5>("h16"))) : 
      count <= UInt<1>("h0") 

    inst add of Adder 
    add.clock <= clock
    add.reset <= reset
    add.a <= count 
    add.b <= UInt<32>("h1")

    when and(en, neq(count, UInt<5>("h16"))) : 
      count <= add.c 

    when eq(bits(reset, 0, 0), UInt<1>("h0")) : 
      assert(clock, neq(count, UInt<4>("ha")), UInt<1>("h1"), "Assertion failed\n    at main.scala:25 assert(count =/= 10.U)\n") 
