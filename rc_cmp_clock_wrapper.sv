`include "rc_model.sv"
`include "rc_model_slow.sv"

module rc_cmp_clock_wrapper(
    input wire logic clk,
    input wire logic rst
);
  reg even;
  reg clk_slow;
  always @(posedge clk) begin
    even <= ~even;
  end
  always @(posedge even) begin
    clk_slow <= ~clk_slow;
  end

  `MAKE_CONST_REAL(1.0, v_in);
  `MAKE_REAL(v_out_1, 16.0);
  `MAKE_SHORT_REAL(v_out_2, 16.0);

  rc_model #(
      `PASS_REAL(v_in, v_in),
      `PASS_REAL(v_out, v_out_1)
  ) model_1(.v_in(v_in), .v_out(v_out_1), .clk(clk), .rst(rst));
  rc_model_slow #(
      `PASS_REAL(v_in, v_in),
      `PASS_REAL(v_out, v_out_2)
  ) model_2(.v_in(v_in), .v_out(v_out_2), .clk(clk_slow), .rst(rst));

  `MAKE_CONST_REAL(0.00390625, max_diff);
  `SUB_REAL(v_out_1, v_out_2, diff);
  `ABS_REAL(diff, abs_diff);
  `LE_REAL(abs_diff, max_diff, prop);
  always @(posedge even) begin
    assert (prop);
  end
endmodule
