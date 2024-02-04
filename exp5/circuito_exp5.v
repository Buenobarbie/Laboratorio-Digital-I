module circuito_exp5 (
 input clock,
 input reset,
 input iniciar,
 input [3:0] chaves,
 output acertou,
 output errou,
 output pronto,
 output [3:0] leds,
 output db_igual,
 output [6:0] db_contagem,
 output [6:0] db_memoria,
 output [6:0] db_estado,
 output [6:0] db_jogadafeita,
 output db_clock,
 output db_iniciar,
 output db_tem_jogada
);

endmodule





module circuito_exp4_desafio(
input        clock,
input        reset,
input        iniciar,
input [3:0]  chaves,
output       pronto,
output       acertou,
output       errou,
output       db_igual,
output       db_iniciar,
output [6:0] db_contagem,
output [6:0] db_memoria,
output [6:0] db_chaves,
output [6:0] db_estado,
output       db_fimC,
output       db_contaC,
output       db_zeraC
);

wire fimC;
wire contaC;
wire zeraC;
wire zeraR;
wire registraR;

wire [3:0] estado_out;
wire [3:0] contagem_out;
wire [3:0] chaves_out;
wire [3:0] memoria_out;

// Unidade de controle ------------------------------
desafio4_unidade_controle unidade_controle(
	.clock(clock),
	.reset(reset),
	.iniciar(iniciar),
	.fimC(fimC),
	.errou(errou),
	.zeraC(zeraC),
	.contaC(contaC),
	.zeraR(zeraR),
	.registraR(registraR),
	.pronto(pronto),
	.db_estado(estado_out),
	.acertou(acertou)
); 

// Fluxo de Dados ------------------------------
desafio4_fluxo_dados fluxo_dados (
	.clock(clock),
	.chaves(chaves),
	.zeraR(zeraR),
	.registraR(registraR), 
	.contaC(contaC),
	.zeraC(zeraC),
	.chavesIgualMemoria(db_igual),
	.fimC(fimC),
	.db_contagem(contagem_out),
	.db_chaves(chaves_out),
	.db_memoria(memoria_out),
	.errou(errou)
);

// Display0 -----------------------------------
hexa7seg HEX0(
	.hexa(contagem_out),
	.display(db_contagem)
);

// Display1 -----------------------------------
hexa7seg HEX1(
	.hexa(memoria_out),
	.display(db_memoria)
);

// Display2 -----------------------------------
hexa7seg HEX2(
	.hexa(chaves_out),
	.display(db_chaves)
);

// Display5 -----------------------------------
hexa7seg HEX5(
	.hexa(estado_out),
	.display(db_estado)
);

assign db_iniciar = iniciar;
assign db_zeraC   = zeraC;
assign db_contaC  = contaC;
assign db_fimC    = fimC;

endmodule

module hexa7seg (hexa, display);
    input      [3:0] hexa;
    output reg [6:0] display;

    /*
     *    ---
     *   | 0 |
     * 5 |   | 1
     *   |   |
     *    ---
     *   | 6 |
     * 4 |   | 2
     *   |   |
     *    ---
     *     3
     */
        
    always @(hexa)
    case (hexa)
        4'h0:    display = 7'b1000000;
        4'h1:    display = 7'b1111001;
        4'h2:    display = 7'b0100100;
        4'h3:    display = 7'b0110000;
        4'h4:    display = 7'b0011001;
        4'h5:    display = 7'b0010010;
        4'h6:    display = 7'b0000010;
        4'h7:    display = 7'b1111000;
        4'h8:    display = 7'b0000000;
        4'h9:    display = 7'b0010000;
        4'ha:    display = 7'b0001000;
        4'hb:    display = 7'b0000011;
        4'hc:    display = 7'b1000110;
        4'hd:    display = 7'b0100001;
        4'he:    display = 7'b0000110;
        4'hf:    display = 7'b0001110;
        default: display = 7'b1111111;
    endcase
endmodule
