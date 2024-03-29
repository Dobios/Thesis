import chisel3._
import chisel3.stage.ChiselStage


class Counter extends Module {
    val en = IO(Input(Bool()))
    val count = RegInit(0.U(32.W))
    when(en && count === 22.U) { count := 0.U }
    when(en && count =/= 22.U) { count := count + 1.U }
    AssertProperty(count =/= 10.U)
}

object CounterDriver extends App {
  val pretty = Array(
    "--emission-options", "disableMemRandomization,disableRegisterRandomization"
  )
  val firrtl: String = (new ChiselStage).emitCHIRRTL(new Counter(), pretty)
}
