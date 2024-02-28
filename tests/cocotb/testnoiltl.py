
import cocotb
from cocotb.triggers import FallingEdge, Timer


async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(10):
        dut.clock.value = 0
        await Timer(1, units="ns")
        dut.clock.value = 1
        await Timer(1, units="ns")


@cocotb.test()
async def test01(dut):
    """Tests the trivial implication case"""

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"$
    await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clock)
    dut.a.value = 0
    await FallingEdge(dut.clock)
    dut.b.value = 1
    await FallingEdge(dut.clock)
    assert dut.res == 1

@cocotb.test()
async def test11(dut):
    """Tests the trivial implication case"""

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"$
    await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clock)
    dut.a.value = 1
    await FallingEdge(dut.clock)
    dut.b.value = 1
    await FallingEdge(dut.clock)

    assert dut.res == 1

@cocotb.test()
async def test10(dut):
    """Tests the trivial implication case"""

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"$
    await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clock)
    dut.a.value = 1
    await FallingEdge(dut.clock)
    dut.b.value = 0
    await FallingEdge(dut.clock)

    assert dut.res == 0


@cocotb.test()
async def testoverlapp(dut):
    """Tests the trivial implication case"""

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"$
    await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clock)
    dut.a.value = 1
    dut.b.value = 1
    await FallingEdge(dut.clock)
    dut.b.value = 0
    await FallingEdge(dut.clock)

    assert dut.res == 0
