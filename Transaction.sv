//import my_pkg::*;
class Transaction;

  rand bit [7:0] transaction_A;
  rand bit [7:0] transaction_B;
  bit [3:0] transaction_ALUSel;
  bit [7:0] transaction_ALUOut;
  bit transaction_CarryOut;

  constraint lower {
    transaction_A >= 1;
    transaction_A <= 63;
    transaction_B >= 1;
    transaction_B <= 63;
  }

  constraint lower_middle {
    transaction_A >= 64;
    transaction_A <= 127;
    transaction_B >= 64;
    transaction_B <= 127;
  }

  constraint upper_middle {
    transaction_A >= 128;
    transaction_A <= 191;
    transaction_B >= 128;
    transaction_B <= 191;
  }

  constraint upper {
    transaction_A >= 192;
    transaction_A <= 255;
    transaction_B >= 192;
    transaction_B <= 255;
  }

  function Transaction copy(Transaction temp);
    temp = new();
    temp.transaction_A = this.transaction_A;
    temp.transaction_B = this.transaction_B;
    temp.transaction_ALUSel = this.transaction_ALUSel;
    temp.transaction_CarryOut = this.transaction_CarryOut;
    temp.transaction_ALUOut = this.transaction_ALUOut;
  endfunction
  covergroup cg;

    sel: coverpoint transaction_ALUSel;

  endgroup
  function new();
    cg = new();
  endfunction

  function void display();
    $display("[TRAN] At Time:%0t A:%0d ,B:%0d ,Sel:%0d ,Output:%0d ,Carry:%0d", $time,
             transaction_A, transaction_B, transaction_ALUSel, transaction_ALUOut,
             transaction_CarryOut);
  endfunction
endclass
