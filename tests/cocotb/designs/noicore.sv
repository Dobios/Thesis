// Generated by CIRCT unknown git version
module NOI(	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:2:3
  input  clock,	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:2:21
         reset,	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:2:45
         a,	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:2:61
         b,	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:2:73
  output res	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:2:86
);

  reg  hbr = 1'h0;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:8:12
  always_ff @(posedge clock)	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:8:12
    hbr <= reset | hbr;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:7:10, :8:12
  reg  delay_ = 1'h0;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:18:15
  reg  _0 = 1'h0;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:20:11
  always_ff @(posedge clock) begin	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:20:11
    if (reset) begin	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:20:11
      delay_ <= 1'h0;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:18:15
      _0 <= 1'h0;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:20:11
    end
    else begin	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:20:11
      delay_ <= delay_ | delay_ - 1'h1;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:14:10, :17:10, :18:15
      _0 <= 1'h1;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:20:11
    end
  end // always_ff @(posedge)
  wire _GEN = ~(hbr & ~reset) | ~delay_ | ~_0 | b | reset;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:8:12, :9:10, :10:10, :11:10, :18:15, :20:11, :21:10, :23:10, :24:11, :25:11, :26:11, :27:11
  always @(posedge clock)	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:28:5
    assert(_GEN);	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:24:11, :25:11, :26:11, :27:11, :29:7
  assign res = _GEN;	// ../firrtl-examples/mlir/loweredbasicnoi.mlir:24:11, :25:11, :26:11, :27:11, :31:5
endmodule
