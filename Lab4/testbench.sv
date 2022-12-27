module testbench_alu();
  logic [31:0] a, b, y;
  logic [2:0] f;
  logic zero;
  logic result;
  
  alu dut(
    .iA (a),
    .iB (b),
    .iF (f),
    .oY (y),
    .oZero (zero)
  );

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    result = 1'b1;
    
    a = 32'h1234_5678; b = 32'h0000_ffff; f=3'b000; #10;
    if(y!=32'h0000_5678) begin $display("000 failed."); result=1'b0; end

    a = 32'h1234_5678; b = 32'h0000_ffff; f=3'b001; #10;
    if(y!=32'h1234_ffff) begin $display("001 failed."); result=1'b0; end
    
    a = 32'h1234_5678; b = 32'h1111_2222; f=3'b010; #10;
    if(y!=32'h2345_789a) begin $display("010 failed."); result=1'b0; end
    
    a = 32'h1234_5678; b = 32'h0000_ffff; f=3'b100; #10;
    if(y!=32'h1234_0000) begin $display("100 failed."); result=1'b0; end
    
    a = 32'h1234_5678; b = 32'h0000_ffff; f=3'b101; #10;
    if(y!=32'hffff_5678) begin $display("101 failed."); result=1'b0; end
    
    a = 32'h1234_5678; b = 32'h1111_2222; f=3'b110; #10;
    if(y!=32'h0123_3456) begin $display("110 failed."); result=1'b0; end
    
    a = 32'h0000_5678; b = 32'h0000_ffff; f=3'b111; #10;
    if(y!=32'h0000_0001) begin $display("111 failed."); result=1'b0; end
    
    a = 32'h0000_0000; b = 32'h0000_0000; f=3'b000; #10;
    if(zero!=1) begin $display("zero failed."); result=1'b0; end
    
    if(result) 	$display("SUCCESS!");
    else		$display("FAILURE!");
  end
endmodule 
