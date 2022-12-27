module regfile(iClk, iReset, iRaddr1, iRaddr2,
               iWaddr, iWe, iWdata,
               oRdata1, oRdata2);
  
  input iClk, iReset, iWe;
  input [4:0] iRaddr1, iRaddr2, iWaddr;
  input [31:0] iWdata;
  output reg [31:0] oRdata1, oRdata2;
  
  reg [31:0] rf[0:31];
  integer i;
  
  assign oRdata1 = (iRaddr1) ? rf[iRaddr1] : 0;
  assign oRdata2 = (iRaddr2) ? rf[iRaddr2] : 0;
  
  always_ff @(posedge iClk) begin
    if (iReset) begin
      for (i = 0; i < 32; i = i + 1) begin
        rf[i] <= 0;
      end
    end
    
    else begin
      if (iWe == 1) begin
        rf[iWaddr] <= iWdata;
      end
    end	
    
  end
  
endmodule
