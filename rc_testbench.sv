`include "rc_wrapper.sv"

module rc_testbench;
  reg clk;
  reg rst;

  localparam period = 1;
  localparam delay = 128 * period;

  `MAKE_REAL(result, 16.0);
  rc_wrapper #(
    `PASS_REAL(result, result)
  ) wrapper(.clk(clk), .rst(rst), .result(result));

  always begin
    #period
    clk = 0;
    #period
    clk = 1;
  end

  real v_out;
  always @* begin
    v_out = `TO_REAL(result);
  end

  initial begin
    $dumpfile(`DUMP_FILE_PATH);
    $dumpvars(0, rc_testbench);
    rst = 1;
    clk = 1;
    #period
    rst = 0;
    #delay
    $display("done");
    $finish;
  end
endmodule
