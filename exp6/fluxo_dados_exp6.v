module fluxo_dados_exp6 (
input        clock,
input        zeraC,
input        contaC,
input        zeraT,
input        contaT,
input        zeraR,
input        registraR, 
input [3:0]  chaves,
output       igual,
output       fimC,
output       fimT,
output       db_meio,
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

  // temporizador (contador_M)

  contador_m temporizador(
    .clock(clock),
    .zera_as(zeraT),
    .zera_s(zeraT),
    .conta(contaT),
    .Q(),
    .fim(fimT),
    .meio(db_meio)
  );

  // Geração do sinal das chaves
  assign sinal = (chaves[0] ^ chaves[1] ^ chaves[2] ^ chaves[3]);
  assign db_tem_jogada = sinal;

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
