//import my_pkg::*;
//`include "Transaction.sv"

//`include "interface.sv"  

class driver;
  virtual intf vif;
  mailbox gen2driv;


  function new(virtual intf vif, mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction

  task main();


    Transaction trans;
    gen2driv.get(trans);
    vif.A <= trans.transaction_A;
    vif.B <= trans.transaction_B;
    vif.ALU_sel <= trans.transaction_ALUSel;
    //  trans.display("[ Driver ]");
    vif.ALU_out <= trans.transaction_ALUOut;
    vif.Carry_out <= trans.transaction_CarryOut;

  endtask
endclass
