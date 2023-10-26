import chisel3._
import chisel3.stage.ChiselStage

class Inc extends Module {
    val a = IO(Input(UInt(32.W)))
    val en = IO(Input(Bool()))

    val b = a + 1.U

    assert(b > a, "a + 1 should always be bigger than a")
}

object IncDriver extends App {
  val pretty = Array(
    "--emission-options", "disableMemRandomization,disableRegisterRandomization"
  )
  val firrtl: String = (new ChiselStage).emitChirrtl(new Inc(), pretty)
}
