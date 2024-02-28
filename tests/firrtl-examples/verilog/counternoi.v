module Counter(input clock, reset);
  reg [4:0] count;	// src/test/scala/ltl/LTLSpec.scala:42:26
  reg       hasBeenResetReg;	// src/main/scala/chisel3/ltl/LTL.scala:357:39
  initial	// src/main/scala/chisel3/ltl/LTL.scala:357:39
    hasBeenResetReg = 1'bx;	// src/main/scala/chisel3/ltl/LTL.scala:357:39
  assert property (@(posedge clock)
                   disable iff (~(hasBeenResetReg === 1'h1 & reset === 1'h0)) |count
                   |=> count < 5'hA);	// src/main/scala/chisel3/ltl/LTL.scala:259:38, :318:32, :329:34, :357:39, :375:59, src/test/scala/ltl/LTLSpec.scala:42:26, :47:{63,76}
  always @(posedge clock) begin
    if (reset) begin
      hasBeenResetReg <= 1'h1;	// src/main/scala/chisel3/ltl/LTL.scala:357:39
      count <= 5'h0;	// src/test/scala/ltl/LTLSpec.scala:42:26
    end
    else if (count == 5'h16)	// src/test/scala/ltl/LTLSpec.scala:42:26, :44:{18,28,35}
      count <= 5'h0;	// src/test/scala/ltl/LTLSpec.scala:42:26
    else	// src/test/scala/ltl/LTLSpec.scala:42:26, :44:{18,28,35}
      count <= count + 5'h1;	// src/test/scala/ltl/LTLSpec.scala:42:26, :44:44
  end // always @(posedge)
endmodule
