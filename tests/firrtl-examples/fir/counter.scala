import chisel3._
import chisel3.stage.ChiselStage

class Counter extends Module {
    val en = IO(Input(Bool()))
    val count = RegInit(0.U(32.W))
    when(en && count === 22.U) { count := 0.U }
    when(en && count =/= 22.U) { count := count + 1.U }
    assert(count =/= 10.U)
}

val pretty = Array(
  "--emission-options", "disableMemRandomization,disableRegisterRandomization"
)
println((new ChiselStage).emitChirrtl(new Counter(), pretty))