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
  hw.module @Counter(in %clock : !seq.clock, in %reset : i1, in %en : i1) {
    %0 = seq.from_clock %clock
    %c0_i28 = hw.constant 0 : i28
    %false = hw.constant false
    %c22_i32 = hw.constant 22 : i32
    %true = hw.constant true
    %c-6_i4 = hw.constant -6 : i4
    %c0_i32 = hw.constant 0 : i32
    %count = seq.firreg %9 clock %clock reset sync %reset, %c0_i32 {firrtl.random_init_start = 0 : ui64} : i32
    %1 = comb.icmp bin eq %count, %c22_i32 : i32
    %2 = comb.and bin %1, %en : i1
    %3 = comb.mux bin %2, %c0_i32, %count : i32
    %4 = comb.icmp bin ne %count, %c22_i32 : i32
    %5 = comb.and bin %4, %en : i1
    %6 = comb.concat %false, %count : i1, i32
    %c1_i33 = hw.constant 1 : i33
    %7 = comb.add bin %6, %c1_i33 : i33
    %8 = comb.extract %7 from 0 : (i33) -> i32
    %9 = comb.mux bin %5, %8, %3 : i32
    %c10_i32 = hw.constant 10 : i32
    %10 = comb.icmp bin ne %count, %c10_i32 : i32
    sv.always posedge %0 {
      sv.if %en {
        sv.assert %10, immediate message "Counter reached 10!"
      }
    }
    hw.output
  }
}

