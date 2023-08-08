//import my_pkg::*;
//`include "Transaction.sv"
class Generator;
  Transaction trans;
  mailbox mbx;
  int Generator_Counter = 0;

  function new(mailbox mbx);
    this.mbx = mbx;
    trans = new();
  endfunction

  task main();

    if (Generator_Counter >= 0 * (1920 / 16) && Generator_Counter < 1 * (1920 / 16)) begin
      trans.transaction_ALUSel = 16'h00;
      Constraint_checker(0);
    end else if (Generator_Counter >= 1 * (1920 / 16) && Generator_Counter < 2 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h1;
      Constraint_checker(1);
    end else if (Generator_Counter >= 2 * (1920 / 16) && Generator_Counter < 3 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h2;
      Constraint_checker(2);
    end else if (Generator_Counter >= 3 * (1920 / 16) && Generator_Counter < 4 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h3;
      Constraint_checker(3);
    end else if (Generator_Counter >= 4 * (1920 / 16) && Generator_Counter < 5 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h4;
      Constraint_checker(4);
    end else if (Generator_Counter >= 5 * (1920 / 16) && Generator_Counter < 6 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h5;
      Constraint_checker(5);
    end else if (Generator_Counter >= 6 * (1920 / 16) && Generator_Counter < 7 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h6;
      Constraint_checker(6);
    end else if (Generator_Counter >= 7 * (1920 / 16) && Generator_Counter < 8 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h7;
      Constraint_checker(7);
    end else if (Generator_Counter >= 8 * (1920 / 16) && Generator_Counter < 9 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h8;
      Constraint_checker(8);
    end else if (Generator_Counter >= 9 * (1920 / 16) && Generator_Counter < 10 * (1920 / 16)) begin
      trans.transaction_ALUSel = 4'h9;
      Constraint_checker(9);
    end
    else if (Generator_Counter>= 10*(1920/16) && Generator_Counter < 11*(1920/16)) begin
      trans.transaction_ALUSel = 4'ha;
      Constraint_checker(10);
    end
    else if (Generator_Counter>= 11*(1920/16) && Generator_Counter < 12*(1920/16)) begin
      trans.transaction_ALUSel = 4'hb;
      Constraint_checker(11);
    end
    else if (Generator_Counter>= 12*(1920/16) && Generator_Counter < 13*(1920/16)) begin
      trans.transaction_ALUSel = 4'hc;
      Constraint_checker(12);
    end
    else if (Generator_Counter>= 13*(1920/16) && Generator_Counter < 14*(1920/16)) begin
      trans.transaction_ALUSel = 4'hd;
      Constraint_checker(13);
    end
    else if (Generator_Counter>= 14*(1920/16) && Generator_Counter < 15*(1920/16)) begin
      trans.transaction_ALUSel = 4'he;
      Constraint_checker(14);
    end
    else if (Generator_Counter>= 15*(1920/16) && Generator_Counter < 16*(1920/16)) begin
      trans.transaction_ALUSel = 4'hf;
      Constraint_checker(15);
    end
    trans.randomize();
    mbx.put(trans);
    Generator_Counter++;
  endtask


  task Constraint_checker(input Counter);
    if (Generator_Counter >= 0 + 120 * (Counter) && Generator_Counter < 30 + 120 * (Counter)) begin
      trans.upper.constraint_mode(0);
      trans.lower_middle.constraint_mode(0);
      trans.upper_middle.constraint_mode(0);
    end
    if (Generator_Counter >= 30 + 120 * (Counter) && Generator_Counter < 60 + 120 * (Counter)) begin
      trans.lower.constraint_mode(0);
      trans.upper.constraint_mode(0);
      trans.upper_middle.constraint_mode(0);
    end
    if (Generator_Counter >= 60 + 120 * (Counter) && Generator_Counter < 90 + 120 * (Counter)) begin
      trans.upper.constraint_mode(0);
      trans.lower_middle.constraint_mode(0);
      trans.lower.constraint_mode(0);
    end
    if (Generator_Counter>=90+120*(Counter) && Generator_Counter < 120+120*(Counter)) begin
      trans.lower.constraint_mode(0);
      trans.lower_middle.constraint_mode(0);
      trans.upper_middle.constraint_mode(0);
    end

  endtask
endclass
