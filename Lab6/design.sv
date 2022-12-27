`include "alu.sv"
`include "regfile.sv"
`include "imem.sv"
`include "dmem.sv"

module datapath(
  input logic iClk,
  input logic iReset,
  input logic iRegWrite,
  input logic iMemWrite,
  input logic [2:0] iALUControl
);
  
  logic [31:0] oRdata, iWdata, oRdata1, oY;
  logic [4:0] iWaddr;

  logic [31:0] pc;
  logic [31:0] signExtend;
  logic prev;
  
  always @(posedge iClk or iReset) begin
    
    if (iReset == 1) begin
      pc = 32'h0000_0000;
      prev = 1;
    end
    
    else if (iReset == 0) begin
      if (prev == 0) begin
        pc = pc + 4;
      end
      
      prev = 0;
    end
    
  end
  
  imem im(
    .iAddr (pc),
    .oRdata (oRdata)
  );

  regfile rf(
    .iClk (iClk),
    .iReset (iReset),
    .iRaddr1 (oRdata[25:21]),
    .iRaddr2 (),
    .iWaddr (oRdata[20:16]),
    .iWe (iRegWrite),
    .iWdata (iWdata),
    .oRdata1 (oRdata1),
    .oRdata2 ()
  );
  
  integer i;
  always @(posedge iClk or iReset) begin
    signExtend[15:0] = oRdata[15:0];
    if (oRdata[15] == 1)
      for (i = 16; i < 32; i = i + 1)
        signExtend[i] = oRdata[15];
    else
      for (i = 16; i < 32; i = i + 1)
        signExtend[i] = 0;
  end
  
  alu al(
    .iA (oRdata1),
    .iB (signExtend),
    .iF (iALUControl),
    .oY (oY),
    .oZero ()
  );
  
  dmem dm(
    .iClk (iClk),
    .iWe (iMemWrite),
    .iAddr (oY),
    .iWdata (),
    .oRdata (iWdata)
  );
  
endmodule
