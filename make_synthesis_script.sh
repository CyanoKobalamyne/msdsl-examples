cat <<EOF
# Script adapted from
# https://github.com/upscale-project/pono/blob/b243cef/README.md#yosys-quick-start

# Read input file
read_verilog -formal -sv $1.sv

# Conservative elaboration of the top module
# Runs hierarchy, proc, flatten, and some opt and memory steps
prep -flatten -top $1

# Ensure that assumptions hold at every state
# If an assumption is flopped, you might see strange behavior at the last state
# (because the clock hasn't toggled)
chformal -assume -early

# Process memories, nomap means it will keep them as arrays
memory -nomap

# Simulate reset signal
sim -clock clk -reset rst -n 20 -rstlen 20 -w $1

# Turn all undriven signals into inputs
setundef -undriven -expose

# Write out file in BTOR2 format
write_btor $1.btor
EOF
