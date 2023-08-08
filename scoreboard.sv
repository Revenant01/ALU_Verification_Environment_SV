//`include "Transaction.sv"

//comments are under their respective line
class ScoreBoard;
  mailbox scb;
  //new handle 

  function new(mailbox scb);
    this.scb = scb;
  endfunction
  //constructor to give value for the mailbox
  parameter add=4'b0000,sub=4'b0001,mul=4'b0010,div=4'b0011,
              shl=4'b0100,shr=4'b0101,rol=4'b0110,ror=4'b0111,
              AND=4'b1000,OR=4'b1001,XOR=4'b1010,NOR=4'b1011,
              NAND=4'b1100,XNOR=4'b1101,gr8=4'b1110,eq=4'b1111;
  //for easier comparison 
  task main();
    Transaction item, ref_item;
    //item is the result , ref item is the correct ans
    scb.get(item);
    //original item is passed from the monitor to be checked
    ref_item = new();
    //	ref_item.copy(item);
    begin
      case (item.transaction_ALUSel)
        add:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A + item.transaction_B ;
        sub:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A - item.transaction_B ;
        mul:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A * item.transaction_B ;
        div:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A / item.transaction_B ;
        shl: {ref_item.transaction_CarryOut, ref_item.transaction_ALUOut} = item.transaction_A << 1;
        shr: {ref_item.transaction_CarryOut, ref_item.transaction_ALUOut} = item.transaction_A >> 1;
        rol:
        {ref_item.transaction_CarryOut, ref_item.transaction_ALUOut} = {
          item.transaction_A[6:0], item.transaction_A[7]
        };
        ror:
        {ref_item.transaction_CarryOut, ref_item.transaction_ALUOut} = {
          item.transaction_A[0], item.transaction_A[7:1]
        };
        AND:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A & item.transaction_B;
        OR:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A | item.transaction_B;
        XOR:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =item.transaction_A ^ item.transaction_B;
        NOR:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =~(item.transaction_A | item.transaction_B);
        NAND:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =~(item.transaction_A & item.transaction_B);
        XNOR:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =~(item.transaction_A ^ item.transaction_B);
        gr8:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                  =(item.transaction_B < item.transaction_A)?8'd1:8'd0;
        eq:
        {ref_item.transaction_CarryOut,ref_item.transaction_ALUOut}
                     =(item.transaction_A == item.transaction_B)?8'd1:8'd0;
        default: {ref_item.transaction_CarryOut, ref_item.transaction_ALUOut} = 8'd1;
      endcase
      //now we handled the ref value and we are ready to start comparing
      //the ref to the resulted ans from the DUT
      /*            if(ref_item.transaction_ALUOut==item.transaction_ALUOut)begin
                $display("Scoreboard pass! Your output (%h) matches the refrence (%h)",
                item.transaction_ALUOut,ref_item.transaction_ALUOut);
                //valid for all operations , for + and * we need to check not
                //only the output but the carry as well
                if (add || mul)begin
                    if(ref_item.transaction_CarryOut==item.transaction_CarryOut)begin
                        $display("Scoreboard pass! Your Carry (%h) matches the refrence (%h)",
                        item.transaction_CarryOut,ref_item.transaction_CarryOut); 
                        $display("Success");
                    end
                    else begin //wrong carry
                         $display("Scoreboard Failed! Your Carry (%h) doesnt match the refrence (%h)",
                        item.transaction_CarryOut,ref_item.transaction_CarryOut); 
                        $display("Fail");
                    end
                end
                else begin //not add or mul
                     $display("Success");
                end    
            end
            else begin //out is not correct
                 $display("Scoreboard Failed! Your output (%h) doesnt match the refrence (%h)",
                        item.transaction_CarryOut,ref_item.transaction_CarryOut); 
                        $display("Fail");
            end */
      if (ref_item.transaction_ALUOut == item.transaction_ALUOut) begin
        $display("Test Pass");
        item.cg.sample();

      end else $display("Test Fail");
      //     tr.display({"ScoreBoard  ", res});
      $display("Excpected: %0d    Actual %0d  A: %0d. B: %0d. ALU_Sel: %0h",
               ref_item.transaction_ALUOut, item.transaction_ALUOut, item.transaction_A,
               item.transaction_B, item.transaction_ALUSel);

    end

  endtask
endclass

