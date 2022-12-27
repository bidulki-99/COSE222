module controller(
  input logic [5:0] iOp,
  output logic oRegWrite,
  output logic oMemWrite,
  output logic [2:0] oALUControl
);

  initial begin
    oALUControl = 3'b010;
  end
  
  always_comb
    case (iOp)
      6'b100011: begin
        oRegWrite = 1;
        oMemWrite = 0;
      end
      default: begin
        oRegWrite = 0;
        oMemWrite = 0;
      end
    endcase
  
endmodule
