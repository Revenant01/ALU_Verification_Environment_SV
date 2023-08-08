`timescale 1ns / 1ps
//import my_pkg::*;
`include "Environment.sv"

program test (
    intf iinf
);

  Environment env;

  initial begin

    env = new(iinf);
    env.run();

  end

endprogram
