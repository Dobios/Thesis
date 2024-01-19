module {
  hw.module @LTLSpec_Anon(in %a : i1, in %rst : i1) {
	%true = hw.constant true
	%x2 = hw.wire %0  : i1
	%0 = comb.xor bin %rst, %true {sv.namehint = "_n_rst_T"} : i1
	%1 = hw.wire %x2  : i1
	%2 = ltl.disable %a if %1 : i1
	verif.assert %2 : !ltl.property
	hw.output
  }
}
