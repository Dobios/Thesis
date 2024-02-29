module tb;
  reg clock;
  reg reset;
  reg a;
  reg b;

  NOI dut (.clock(clock),
            .reset(reset),
            .a(a),
          .b(b));

  always #10 clk = ~clk;

  integer n;

  initial begin
    reset <= 1;
    {clock, a, b} <= 0;

    repeat(2) @(posedge clock);
    reset <= 0;

    a <= 1;
    wait @(posedge clock);
    b <= 1;
    
  end
endmodule