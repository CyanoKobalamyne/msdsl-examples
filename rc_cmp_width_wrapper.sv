`include "rc_model.sv"

module rc_cmp_width_wrapper(
    input wire logic clk,
    input wire logic rst
);
  `MAKE_CONST_REAL(1.0, v_in);
  `MAKE_REAL(v_out_1, 16.0);
  `MAKE_SHORT_REAL(v_out_2, 16.0);

  rc_model #(
      `PASS_REAL(v_in, v_in),
      `PASS_REAL(v_out, v_out_1)
  ) model_1(.v_in(v_in), .v_out(v_out_1), .clk(clk), .rst(rst));
  rc_model #(
      `PASS_REAL(v_in, v_in),
      `PASS_REAL(v_out, v_out_2)
  ) model_2(.v_in(v_in), .v_out(v_out_2), .clk(clk), .rst(rst));

  `EQ_REAL(v_out_1, v_out_2, prop);
  always @* begin
    assert (prop);
  end
endmodule
