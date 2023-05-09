`include "rc_model.sv"

module rc_wrapper #(
    `DECL_REAL(result)
) (
    input wire logic clk,
    input wire logic rst,
    `OUTPUT_REAL(result)
);
  `MAKE_CONST_REAL(1.0, in);

  rc_model #(
      `PASS_REAL(v_in, in),
      `PASS_REAL(v_out, result)
  ) model(.v_in(in), .v_out(result), .clk(clk), .rst(rst));

  `MAKE_CONST_REAL(2.0, val);
  `LT_REAL(result, val, prop);
  always @* begin
    assert (prop);
  end

endmodule
