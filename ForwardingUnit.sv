module ForwardingUnit(
  input[3:0] src1, src2,
  input MEM_WB_EN, 
  input [3:0] MEM_Dest,
  input WB_WB_EN,
  input [3:0] WB_Dest,
  
  output reg [1:0] AInputSelector, BInputSelector
  );

  always@(*)begin
	if((MEM_Dest == src1) & (MEM_WB_EN))begin
			AInputSelector = 2'b01;
	end
	else begin
		if((WB_Dest == src1) & (WB_WB_EN))begin
			AInputSelector = 2'b10;
		end
		else begin
			AInputSelector = 2'b00;
		end
	end
	 
	if((MEM_Dest == src2) & (MEM_WB_EN))begin
       BInputSelector = 2'b01;
	end
	else begin
		if((WB_Dest == src2) & (WB_WB_EN))begin
			BInputSelector = 2'b10;
		end
		else begin
			BInputSelector = 2'b00;
		end
	end
		
    
  end
  
  
endmodule

