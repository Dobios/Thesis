module Counter(input clock,	reset);
  reg [31:0] count;	
  reg        hbr = 1'h0;	
  always_ff @(posedge clock)	
    hbr <= reset | hbr;	
  always @(posedge clock) begin	
    assert(~hbr | count != 32'hA);	
    if (reset)	
      count <= 32'h0;	
    else if (count == 32'h16)	
      count <= 32'h0;	
    else	
      count <= count + 32'h1;	
  end // always @(posedge)
endmodule
