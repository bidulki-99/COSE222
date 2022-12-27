module testbench_lw();
  logic clk;
  logic reset;
  logic regwrite;
  logic memwrite;
  logic [2:0] alucontrol;

  datapath dut(
    .iClk		(clk),
    .iReset		(reset),
    .iRegWrite	(regwrite),
    .iMemWrite	(memwrite),
    .iALUControl(alucontrol)
  );

  always     // no sensitivity list, so it always executes
    begin
      clk = 1; #5; clk = 0; #5;
    end

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    reset = 0; #21;
    reset = 1; #10;
    regwrite = 1; memwrite = 0; alucontrol = 3'b010;
    reset = 0; #10;
    
    #10; $stop;
  end
endmodule
