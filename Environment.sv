`timescale 1ns / 1ps
 `include "Transaction.sv"
  `include "Generator.sv"
  `include "driver.sv"
  `include "Monitor.sv"
  `include "scoreboard.sv"

 // `include "interface.sv"  


class Environment;

Generator gen;
driver drv;
monitor mon;
ScoreBoard scb;
virtual intf inf;

mailbox gendrv;
mailbox monscb;
  

function new(virtual intf inf);

    this.inf = inf;
    gendrv = new();
    monscb = new();
    gen = new(gendrv);
    drv = new(inf, gendrv);
    mon = new(inf, monscb);
    scb = new(monscb);

endfunction

task test;
  repeat(1920)
    begin
    fork
     begin
    gen.main();
       drv.main();
       mon.main();
       scb.main();
     end
    join
  end
 // -> gen.done;
endtask

  task run();

    test();
    $display("Coverage = %f percent",gen.trans.cg.get_coverage());

endtask

endclass