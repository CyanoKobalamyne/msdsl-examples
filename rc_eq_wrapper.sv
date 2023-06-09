`include "rc_model.sv"

module rc_eq_wrapper #(
    `DECL_REAL(v_in)
) (
    `INPUT_REAL(v_in),
    input wire logic clk,
    input wire logic rst
);
  `MAKE_REAL(v_out_1, 16.0);
  `MAKE_REAL(v_out_2, 16.0);

  rc_model #(
      `PASS_REAL(v_in, v_in),
      `PASS_REAL(v_out, v_out_1),
  ) model_1(.v_in(v_in), .v_out(v_out_1), .clk(clk), .rst(rst));
  rc_model #(
      `PASS_REAL(v_in, v_in),
      `PASS_REAL(v_out, v_out_2),
  ) model_2(.v_in(v_in), .v_out(v_out_2), .clk(clk), .rst(rst));

  `EQ_REAL(v_out_1, v_out_2, prop);
  always @* begin
    assert (prop);
  end

endmodule
