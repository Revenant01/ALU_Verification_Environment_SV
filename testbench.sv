`timescale 1ns / 1ps
`include "test.sv"
`include "interface.sv"
//import my_pkg::*;


module alu_tb ();

  intf iinf ();
  test t1 (iinf);

  alu dut (
      .A(iinf.A),
      .B(iinf.B),
      .ALU_Sel(iinf.ALU_sel),
      .ALU_Out(iinf.ALU_out),
      .CarryOut(iinf.Carry_out)
  );

endmodule
