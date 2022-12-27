module alu(iA, iB, iF,
           oY, oZero);
  
  input [31:0] iA;
  input [31:0] iB;
  input [2:0] iF;
  output logic [31:0] oY;
  output logic oZero;
  
  always_comb
    case (iF)
      3'b000:
        oY = iA & iB;
      3'b001:
        oY = iA | iB;
      3'b010:
        oY = iA + iB;
      3'b100:
        oY = iA & ~iB;
      3'b101:
        oY = iA | ~iB;
      3'b110:
        oY = iA - iB;
      3'b111:
        oY = (iA < iB) ? 32'h0000_0001 : 32'h0000_0000;
      default:
        oY = 32'h0000_0000;
    endcase
  
  assign oZero = (oY) ? 1'b0 : 1'b1;
  
endmodule
