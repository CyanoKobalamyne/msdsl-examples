`include "rc_cmp_width_wrapper.sv"

module rc_cmp_width_testbench;
  reg clk;
  reg rst;

  localparam period = 1;
  localparam delay = 128 * period;

  rc_cmp_width_wrapper wrapper(.clk(clk), .rst(rst));

  always begin
    #period
    clk = 0;
    #period
    clk = 1;
  end

  initial begin
    $dumpfile(`DUMP_FILE_PATH);
    $dumpvars(0, rc_cmp_width_testbench);
    rst = 1;
    clk = 1;
    #period
    rst = 0;
    #delay
    $display("done");
    $finish;
  end
endmodule
