`include "vco_model.sv"

module vco_eq_wrapper(
    input wire logic clk,
    input wire logic rst
);
  `MAKE_CONST_REAL(1.0, v_in);
  wire logic signed [24:0] v_out_1;
  wire logic signed [24:0] v_out_2;

  vco_model #(
      `PASS_REAL(v_in, v_in)
  ) model_1(.v_in(v_in), .v_out(v_out_1), .clk(clk), .rst(rst));
  vco_model #(
      `PASS_REAL(v_in, v_in)
  ) model_2(.v_in(v_in), .v_out(v_out_2), .clk(clk), .rst(rst));

  always @* begin
    assert (v_out_1 == v_out_2);
  end

endmodule
