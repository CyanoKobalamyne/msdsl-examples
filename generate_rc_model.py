from math import exp
import sys

from msdsl import MixedSignalModel, VerilogGenerator

name = "rc_model"
r, c = 1e3, 1e-9

if "--slow" in sys.argv[1:]:
    dt = 0.2e-6  # μs
    name += "_slow"
else:
    dt = 0.1e-6  # μs

m = MixedSignalModel(name)
x = m.add_analog_input("v_in")
y = m.add_analog_output("v_out")
clk = m.add_digital_input("clk")
rst = m.add_digital_input("rst")
a = exp(-dt / (r * c))
m.set_next_cycle(y, a * y + (1 - a) * x, clk=clk, rst=rst)

if __name__ == "__main__":
    m.compile_and_print(VerilogGenerator())
