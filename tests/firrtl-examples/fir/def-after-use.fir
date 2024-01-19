FIRRTL version 3.0.0

circuit Foo:
    module Foo:
        input clk: Clock
        input a: UInt<42>
        input b: UInt<42>
        output x: UInt<42>

        ; Creates a register after the instance, and hooks the instance's input
        ; up to the register. This becomes a forward use in HW.
        reg tmp0: UInt<42>, clk
        x <= tmp0

        ; Creates a wire after the register, and hooks the register's input up
        ; to the wire. This becomes another forward use in HW.
        wire tmp1: UInt<42>
        tmp0 <= tmp1

        ; Assign an expression to the wire. This will create a comb.xor op after
        ; the wire. The wire is inlined and the register directly uses the
        ; result of this op.
        tmp1 <= xor(a,b)

