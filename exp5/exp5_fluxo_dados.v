module exp5_fluxo_dados (
input        clock,
input        zeraC,
input        contaC,
input        zeraR,
input        registraR, 
input [3:0]  chaves,
output       igual,
output       fimC,
output       jogada_feita,
output       db_tem_jogada,
output [3:0] db_contagem,
output [3:0] db_memoria,
output [3:0] db_jogada
);

wire [3:0] s_endereco;
wire menor;
wire maior;
wire [3:0] s_dado;
wire [3:0] s_chaves;
wire sinal;

  // contador_163
  contador_163 contador (
    .CLK( clock ),
    .CLR( zeraC ),
    .LD( 1'b1 ),
    .ENP( contaC ),
    .ENT( 1'b1 ),
    .D( 4'b0 ),
    .Q( s_endereco ),
    .RCO( fimC )
  );
  
  // comparador_85
  comparador_85 comparador (
    .A( s_dado ),
    .B( s_chaves ),
    .ALBi( 1'b0 ),
    .AGBi( 1'b0 ),
    .AEBi( 1'b1 ),
    .ALBo( menor ),
    .AGBo( maior ),
    .AEBo( igual )
  );
  
  // registrador
  registrador_4 registrador(
  .clock(clock),
  .clear(zeraR),
  .enable(registraR),
  .D(chaves),
  .Q(s_chaves)
  );
  
  // memoria
  sync_rom_16x4 memoria(
  .clock(clock),
  .address(s_endereco),
  .data_out(s_dado)
  );

  // Geração do sinal das chaves
  assign sinal = (chaves[0] ^ chaves[1] ^ chaves[2] ^ chaves[3]);

  // edge detector
    edge_detector edge_detector(
    .clock(clock),
    .reset(zeraC),
    .sinal(sinal),
    .pulso(jogada_feita)
    );
  
assign db_contagem = s_endereco;
assign db_jogada   = s_chaves;
assign db_memoria  = s_dado;

endmodule

// REGISTRADOR SÍNCRONO DE 4 BITS -------------------------------------------------------
module registrador_4 (
    input        clock,
    input        clear,
    input        enable,
    input  [3:0] D,
    output [3:0] Q
);

    reg [3:0] IQ;

    always @(posedge clock or posedge clear) begin
        if (clear)
            IQ <= 0;
        else if (enable)
            IQ <= D;
    end

    assign Q = IQ;

endmodule

// MEMÓRIA SÍNCRONA 16X4 -------------------------------------------------------
module sync_rom_16x4 (clock, address, data_out);
    input            clock;
    input      [3:0] address;
    output reg [3:0] data_out;

    always @ (posedge clock)
    begin
        case (address)
            4'b0000: data_out = 4'b0001;
            4'b0001: data_out = 4'b0010;
            4'b0010: data_out = 4'b0100;
            4'b0011: data_out = 4'b1000;
            4'b0100: data_out = 4'b0100;
            4'b0101: data_out = 4'b0010;
            4'b0110: data_out = 4'b0001;
            4'b0111: data_out = 4'b0001;
            4'b1000: data_out = 4'b0010;
            4'b1001: data_out = 4'b0010;
            4'b1010: data_out = 4'b0100;
            4'b1011: data_out = 4'b0100;
            4'b1100: data_out = 4'b1000;
            4'b1101: data_out = 4'b1000;
            4'b1110: data_out = 4'b0001;
            4'b1111: data_out = 4'b0100;
        endcase
    end
endmodule

// CONTADOR -------------------------------------------------------
module contador_163 ( CLK, CLR, LD, ENP, ENT, D, Q, RCO );
    input CLK, CLR, LD, ENP, ENT;
    input [3:0] D;
    output reg [3:0] Q;
    output reg RCO;

    always @ (posedge CLK)  // Create the counter f-f behavior
        if (CLR)               Q <= 4'd0;
        else if (~LD)           Q <= D;
        else if (ENT && ENP)    Q <= Q + 1;
        else                    Q <= Q;
 
    always @ (Q or ENT)     // Create RCO combinational output
        if (ENT && (Q == 4'd15))   RCO = 1;
        else                       RCO = 0;
endmodule

// COMPARADOR -------------------------------------------------------
module comparador_85 (ALBi, AGBi, AEBi, A, B, ALBo, AGBo, AEBo);

    input[3:0] A, B;
    input      ALBi, AGBi, AEBi;
    output     ALBo, AGBo, AEBo;
    wire[4:0]  CSL, CSG;

    assign CSL  = ~A + B + ALBi;
    assign ALBo = ~CSL[4];
    assign CSG  = A + ~B + AGBi;
    assign AGBo = ~CSG[4];
    assign AEBo = ((A == B) && AEBi);

endmodule /* comparador_85 */
