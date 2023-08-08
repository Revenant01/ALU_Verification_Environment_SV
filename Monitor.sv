//import my_pkg::*;
// `include "Transaction.sv"

// `include "interface.sv"  

class monitor;
  virtual intf vif;
  mailbox mon2scb;


  function new(virtual intf vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;

  endfunction

  task main();
    #3
      repeat (1) begin
        Transaction trans;
        trans = new();
        trans.transaction_A = vif.A;
        trans.transaction_B = vif.B;
        trans.transaction_ALUSel = vif.ALU_sel;
        trans.transaction_ALUOut = vif.ALU_out;
        trans.transaction_CarryOut = vif.Carry_out;
        mon2scb.put(trans);
      end
    // trans.display("[ Monitor ]");

  endtask
endclass
