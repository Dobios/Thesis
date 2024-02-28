module Counter(input clock,	reset	);
  reg [31:0] count;	
  reg        hasBeenResetReg;	
  initial	
    hasBeenResetReg = 1'bx;	
  assert property (@(posedge clock)
                   disable iff (~(hasBeenResetReg === 1'h1 & reset === 1'h0))
                   count != 32'hA);	
  always @(posedge clock) begin	
    if (reset) begin	
      hasBeenResetReg <= 1'h1;	
      count <= 32'h0;	
    end
    else if (count == 32'h16)	
      count <= 32'h0;	
    else	
      count <= count + 32'h1;	
  end // always @(posedge)
endmodule
