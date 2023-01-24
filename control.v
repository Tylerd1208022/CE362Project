`timescale 1ns/10ps

module control(INS,ALUCtrl);
//Derive a signal for each insruction
    input INS[31:0];
    output ALUCtrl;
    wire funcOP;//Selects whether the instruction uses the func field
    wire notOP[5:0];
    wire notFunc[5:0];
    genvar i;
    generate//Creates inverted signals for all control bits in instruction
        for(i = 0; i < 6; i = i + 1) begin
            not_gate notOPCODE(INS[31-i],notOP[5-i]);
            not_gate notFUNCCODE(INS[i],notFunc[i]);
        end
    endgenerate
    sixBitAnd funcOPand(notOP[5],notOP[4],notOP[3],notOP[2],notOP[1],notOP[0],funcOP);
    //FuncOps: R Type Instructions
    wire ADD,ADDU,SUB,SUBU,AND,OR,XOR,SEQ,SNE,SLT,SGT,SLE,SGE;
    wire MOVI2S,MOVS2I,SLL,SRL,SRA; //Other Mov Ins involve FP
    sixBitAnd ADD(INS[5],notFunc[4],notFunc[3],notFunc[2],notFunc[1],notFunc[0],ADD);
    sixBitAnd ADDU(INS[5],notFunc[4],notFunc[3],notFunc[2],notFunc[1],INS[0],ADDU);
    sixBitAnd SUB(INS[5],notFunc[4],notFunc[3],notFunc[2],INS[1],notFunc[0],SUB);
    sixBitAnd SUBU(INS[5],notFunc[4],notFunc[3],notFunc[2],INS[1],notFunc[0],SUBU);
    sixBitAnd AND(INS[5],notFunc[4],notFunc[3],INS[2],notFunc[1],notFunc[0],AND);
    sixBitAnd OR(INS[5],notFunc[4],notFunc[3],INS[2],notFunc[1],INS[0],OR);
    sixBitAnd XOR(INS[5],notFunc[4],notFunc[3],INS[2],INS[1],notFunc[0],XOR);
    sixBitAnd SEQ(INS[5],notFunc[4],INS[3],notFunc[2],notFunc[1],notFunc[0],SEQ);
    sixBitAnd SNE(INS[5],notFunc[4],INS[3],notFunc[2],notFunc[1],INS[0],SNE);
    sixBitAnd SLT(INS[5],notFunc[4],INS[3],notFunc[2],INS[1],notFunc[0],SLT);
    sixBitAnd SGT(INS[5],notFunc[4],INS[3],notFunc[2],INS[1],INS[2],SGT);
    sixBitAnd SLE(INS[5],notFunc[4],INS[3],INS[2],notFunc[1],notFunc[0],SLE);
    sixBitAnd SGE(INS[5],notFunc[4],INS[3],INS[2],notFunc[1],INS[0],SGE);
    sixBitAnd MOVI2S(INS[5],INS[4],notFunc[3],notFunc[2],notFunc[1],notFunc[0],MOVI2S);
    sixBitAnd MOVS2I(INS[5],INS[4],notFunc[3],notFunc[2],notFunc[1],INS[0],MOVS2I);
    sixBitAnd SLL(notFunc[5],notFunc[4],notFunc[3],INS[2],notFunc[1],notFunc[0],SLL);
    sixBitAnd SRL(notFunc[5],notFunc[4],notFunc[3],INS[2],INS[1],notFunc[0],SRL);
    sixBitAnd SRA(notFunc[5],notFunc[4],notFunc[3],INS[2],INS[1],INS[0],SRA);
    //END R TYPE INS -- Must be muxxed w/ funcOP Bool before passing control
    //I Types/J Types: Not using Func Field
    wire J, JAL, BEQZ, BNEZ;
    wire ADDI, ADDUI, SUBI, SUBUI, ANDI, ORI, XORI, LHI;
    wire RFE, TRAP, JR, JALR, SLLI, SRLI, SRAI;
    wire SEQI, SNEI, SLTI, SGTI, SLEI, SGEI;
    wire LB, LH, LW, LBU, LHU, LF, LD;
    wire SB, SH, SW, SF, SD;
    sixBitAnd(notOP[5],notOP[4],notOP[3],notOP[2],INS[27],notOP[0],J);
    sixBitAnd(notOP[5],notOP[4],notOP[3],notOP[2],INS[27],INS[26],JAL);
    sixBitAnd(notOP[5],notOP[4],notOP[3],INS[28],notOP[1],notOP[0],BEQZ);
    sixBitAnd(notOP[5],notOP[4],notOP[3],INS[28],notOP[1],INS[26],BNEZ);
    sixBitAnd(notOP[5],notOP[4],INS[29],notOP[2],notOP[1],notOP[0],ADDI);
    sixBitAnd(notOP[5],notOP[4],INS[29],notOP[2],notOP[1],INS[26],ADDUI);
    sixBitAnd(notOP[5],notOP[4],INS[29],notOP[2],INS[27],notOP[0],SUBI);
    sixBitAnd(notOP[5],notOP[4],INS[29],notOP[2],INS[27],INS[26],SUBUI);
        
    
    
