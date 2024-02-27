module circuito_exp7 (
 input        clock,
 input        reset,
 input        iniciar,
 input  [3:0] botoes,
 output [3:0] leds,
 output       pronto,
 output       ganhou,
 output       perdeu,
 output       db_clock,
 output       db_tem_jogada  ,
 output       db_igual,
 output       db_enderecoIgualRodada,
 output       db_timeout,
 output [6:0] db_contagem,
 output [6:0] db_memoria,
 output [6:0] db_jogadafeita,
 output [6:0] db_rodada,
 output [6:0] db_estado
);

wire fimE;
wire contaE;
wire zeraE;

wire zeraR;
wire registraR;

wire contaT;
wire zeraT;
wire fimT;

wire contaP;
wire zeraP;
wire fimP;

wire we;

wire sinal_led;

wire contaRod;
wire zeraRod;
wire fimRod;

wire jogada_feita;
wire igual;
wire enderecoIgualRodada;

wire [3:0] estado_out;
wire [3:0] contagem_out;
wire [3:0] jogada_out;
wire [3:0] memoria_out;
wire [3:0] rodada_out;

// Unidade de controle ------------------------------
unidade_controle_exp7 unidade_controle(
	.clock     (clock),
	.reset     (reset),
	.iniciar   (iniciar),
	.fimE      (fimE),
	.fimRod    (fimRod),
	.fimT      (fimT),
	.fimP      (fimP),
    .jogada    (jogada_feita),
	.igual     (igual), 
	.enderecoIgualRodada (enderecoIgualRodada),
	.zeraE     (zeraE),
	.contaE    (contaE),
	.contaP    (contaP),
	.zeraRod   (zeraRod),
	.contaRod  (contaRod),
	.zeraT     (zeraT),
	.zeraP     (zeraP),
	.contaT    (contaT),
	.zeraR     (zeraR),
	.registraR (registraR),
	.we        (we),
	.acertou   (ganhou),
	.errou     (perdeu),
    .timeout   (db_timeout),
	.pronto    (pronto),
	.db_estado (estado_out),
	.sinal_led (sinal_led)
); 

// Fluxo de Dados ------------------------------
fluxo_dados_exp7 fluxo_dados (
	.clock         (clock),
	.zeraE         (zeraE),
	.contaE        (contaE),
	.contaRod      (contaRod),
	.zeraRod       (zeraRod),
    .zeraT         (zeraT),
	.zeraP         (zeraP),
    .contaT        (contaT),
	.contaP        (contaP),
	.zeraR         (zeraR),
	.registraR     (registraR), 
	.chaves        (botoes),
	.we            (we),
	.sinal_led     (sinal_led),
	.fimE          (fimE),
	.fimRod        (fimRod),
    .fimT          (fimT),
	.fimP          (fimP),
	.igual         (igual),
	.enderecoIgualRodada (enderecoIgualRodada),
    .jogada_feita  (jogada_feita),
    .db_tem_jogada (db_tem_jogada),
	.db_contagem   (contagem_out),
	.db_memoria    (memoria_out),
	.db_jogada     (jogada_out),
	.db_rodada	   (rodada_out),
	.leds          (leds)
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

// Display3 -----------------------------------
hexa7seg HEX3(
	.hexa(rodada_out),
	.display(db_rodada)
);

// Display5 -----------------------------------
hexa7seg HEX5(
	.hexa(estado_out),
	.display(db_estado)
);

assign db_enderecoIgualRodada = enderecoIgualRodada;

assign db_igual = igual;
assign db_clock = clock;

endmodule
