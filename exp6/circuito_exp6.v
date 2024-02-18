module circuito_exp6 (
 input        clock,
 input        reset,
 input        iniciar,
 input  [3:0] chaves,
 output       acertou,
 output       errou,
 output       pronto,
 output [3:0] leds,
 output       db_timeout,
 output       db_meio, 
 output       db_igual,
 output [6:0] db_contagem,
 output [6:0] db_memoria,
 output [6:0] db_estado,
 output [6:0] db_jogadafeita,
 output       db_clock,
 output       db_iniciar,
 output       db_tem_jogada  
);

wire fimC;
wire contaC;
wire zeraC;
wire zeraR;
wire contaT;
wire zeraT;
wire registraR;
wire jogada_feita;
wire igual;
wire fimT;

wire [3:0] estado_out;
wire [3:0] contagem_out;
wire [3:0] jogada_out;
wire [3:0] memoria_out;

// Unidade de controle ------------------------------
exp5_unidade_controle unidade_controle(
	.clock     (clock),
	.reset     (reset),
	.iniciar   (iniciar),
	.fim       (fimC),
    .jogada    (jogada_feita),
	.igual     (igual), 
    .fimT      (fimT),
	.zeraC     (zeraC),
	.contaC    (contaC),
    .zeraT     (zeraT),
    .contaT    (contaT),
	.zeraR     (zeraR),
	.registraR (registraR),
    .timeout   (db_timeout),
    .acertou   (acertou),
    .errou     (errou),
	.pronto    (pronto),
	.db_estado (estado_out)
); 

// Fluxo de Dados ------------------------------
exp5_fluxo_dados fluxo_dados (
	.clock         (clock),
	.zeraC         (zeraC),
	.contaC        (contaC),
    .zeraT         (zeraT),
    .contaT        (contaT),
	.zeraR         (zeraR),
	.registraR     (registraR), 
	.chaves        (chaves),
	.igual         (igual),
	.fimC          (fimC),
    .fimT          (fimT),
    .db_meio       (db_meio),
    .jogada_feita  (jogada_feita),
    .db_tem_jogada (db_tem_jogada),
	.db_contagem   (contagem_out),
	.db_memoria    (memoria_out),
	.db_jogada     (jogada_out)
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
	.hexa(jogada_out),
	.display(db_jogadafeita)
);

// Display5 -----------------------------------
hexa7seg HEX5(
	.hexa(estado_out),
	.display(db_estado)
);

assign db_igual = igual;
assign db_clock = clock;
assign db_iniciar = iniciar;

assign leds = chaves;

endmodule

