module {
  sv.verbatim "// Standard header to adapt well known macros to our needs."
  sv.ifdef  "RANDOMIZE" {
  } else {
    sv.ifdef  "RANDOMIZE_REG_INIT" {
      sv.macro.def @RANDOMIZE ""
    }
  }
  sv.verbatim "\0A// RANDOM may be set to an expression that produces a 32-bit random unsigned value."
  sv.ifdef  "RANDOM" {
  } else {
    sv.macro.def @RANDOM "$random"
  }
  sv.verbatim "\0A// Users can define INIT_RANDOM as general code that gets injected into the\0A// initializer block for modules with registers."
  sv.ifdef  "INIT_RANDOM" {
  } else {
    sv.macro.def @INIT_RANDOM ""
  }
  sv.verbatim "\0A// If using random initialization, you can also define RANDOMIZE_DELAY to\0A// customize the delay used, otherwise 0.002 is used."
  sv.ifdef  "RANDOMIZE_DELAY" {
  } else {
    sv.macro.def @RANDOMIZE_DELAY "0.002"
  }
  sv.verbatim "\0A// Define INIT_RANDOM_PROLOG_ for use in our modules below."
  sv.ifdef  "INIT_RANDOM_PROLOG_" {
  } else {
    sv.ifdef  "RANDOMIZE" {
      sv.ifdef  "VERILATOR" {
        sv.macro.def @INIT_RANDOM_PROLOG_ "`INIT_RANDOM"
      } else {
        sv.macro.def @INIT_RANDOM_PROLOG_ "`INIT_RANDOM #`RANDOMIZE_DELAY begin end"
      }
    } else {
      sv.macro.def @INIT_RANDOM_PROLOG_ ""
    }
  }
  sv.verbatim "\0A// Include register initializers in init blocks unless synthesis is set"
  sv.ifdef  "SYNTHESIS" {
  } else {
    sv.ifdef  "ENABLE_INITIAL_REG_" {
    } else {
      sv.macro.def @ENABLE_INITIAL_REG_ ""
    }
  }
  sv.verbatim "\0A// Include rmemory initializers in init blocks unless synthesis is set"
  sv.ifdef  "SYNTHESIS" {
  } else {
    sv.ifdef  "ENABLE_INITIAL_MEM_" {
    } else {
      sv.macro.def @ENABLE_INITIAL_MEM_ ""
    }
  }
  sv.verbatim ""
  sv.macro.decl @ENABLE_INITIAL_MEM_
  sv.macro.decl @ENABLE_INITIAL_REG_
  sv.macro.decl @INIT_RANDOM_PROLOG_
  sv.macro.decl @RANDOMIZE_DELAY
  sv.macro.decl @INIT_RANDOM
  sv.macro.decl @RANDOM
  sv.macro.decl @RANDOMIZE
  hw.module @Foo(in %clk : !seq.clock, in %a : i42, in %b : i42, out x : i42) {
    %tmp0 = seq.firreg %tmp1 clock %clk {firrtl.random_init_start = 0 : ui64} : i42
    %tmp1 = hw.wire %0  : i42
    %0 = comb.xor bin %a, %b : i42
    hw.output %tmp0 : i42
  }
}
