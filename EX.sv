`timescale 1ns/1ns
module EXE(
    input clk, rst,
    input [3:0] EXE_CMD,
    input MEM_R_EN, MEM_W_EN, WB_EN, 
    input [31:0] PC,
    input [31:0] val_Rn, val_Rm, ALU_Res, WB_Val,
    input imm, 
    input [11:0] shift_oprand,
    input [23:0] signed_imm_24,
    input C_in,
    input [3:0] Dest,
    input [1:0] Sel_src1, Sel_src2,
    
    output [31:0] PC_out, ALU_result, Br_addr, val_Rm_out,
    output [3:0] status,
    output [3:0] Dest_out,
    output WB_EN_out, MEM_W_EN_out, MEM_R_EN_out
);

 logic mem_en;
 logic[31:0] val1, val2, val_gen_in;
 assign val1 = (Sel_src1 == 2'b00) ? val_Rn : ((Sel_src1 == 2'b01) ? ALU_Res : ((Sel_src1 == 2'b10) ? WB_Val : 32'b0));
 assign val_gen_in = (Sel_src2 == 2'b00) ? val_Rm : ((Sel_src2 == 2'b01) ? ALU_Res : ((Sel_src2 == 2'b10) ? WB_Val : 32'b0));
 assign mem_en = MEM_R_EN | MEM_W_EN;
 assign val_Rm_out = val_Rm;
 assign Dest_out = Dest;
 assign WB_EN_out = WB_EN;
 assign MEM_W_EN_out = MEM_W_EN;
 assign MEM_R_EN_out = MEM_R_EN;
 assign PC_out = PC;
 Val2_Generate V2G(val_gen_in, imm, mem_en, shift_oprand, val2);
 ALU alu(val1, val2, EXE_CMD, C_in, status, ALU_result);
 b32adder adder(PC, {{{8{signed_imm_24[23]}}, signed_imm_24}<<2},Br_addr);
          
endmodule
