module testbench_regfile();
  logic clk;
  logic reset;
  logic [4:0] raddr1, raddr2, waddr;
  logic we;
  logic [31:0] wdata;
  logic [31:0] rdata1, rdata2;
  logic result;
  logic [31:0] regs[31:0];
  integer i;

  regfile dut(
    .iClk	(clk),
    .iReset	(reset),
    .iRaddr1(raddr1),
    .iRaddr2(raddr2),
    .iWaddr	(waddr),
    .iWe	(we),
    .iWdata	(wdata),
    .oRdata1(rdata1),
    .oRdata2(rdata2)
  );

  always     // no sensitivity list, so it always executes
    begin
      clk = 1; #5; clk = 0; #5;
    end

  initial begin
    result = 1;
    $dumpfile("dump.vcd"); $dumpvars;
    reset = 0; #21;
    raddr1 = 0; raddr2 = 0; waddr = 0; we = 0; wdata = 0;
    for(i=0; i<32; i=i+1) regs[i]=0;
    reset = 1; #10;
    reset = 0; #10;
    for(i=0; i<32; i=i+1) begin
      waddr = i; we = 1; wdata = $random; regs[i] = wdata; #10;
    end
    waddr = 0; we = 0; wdata = 0;
    for(i=0; i<32; i=i+1) begin
      raddr1 = i; raddr2 = i; #1
      if(i==0) begin
        if(rdata1 != 0 | rdata2 != 0) begin
          $display("Read data from r0 failed");
          result = 0;
        end
      end else begin
        if(rdata1 != regs[i]) begin
          $display("Read data from port 1 at address %d failed %x %x", i, rdata1, regs[i]);
          result = 0;
        end
        if(rdata2 != regs[i]) begin
          $display("Read data from port 2 at address %d failed", i);
          result = 0;
        end
      end
      #9;
    end
    if(result) 	$display("SUCCESS!");
    else		$display("FAILURE!");
    #10; $stop;
  end
endmodule
