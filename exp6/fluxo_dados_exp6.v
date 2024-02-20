module fluxo_dados_exp6 (
input        clock,
input        zeraE,
input        contaE,
input        contaRod,
input        zeraRod,
input        zeraT,
input        contaT,
input        zeraR,
input        registraR, 
input [3:0]  chaves,
output       fimE,
output       fimRod,
output       fimT,
output       igual,
output       enderecoIgualRodada,
output       jogada_feita,
output       db_tem_jogada,
output [3:0] db_contagem,
output [3:0] db_memoria,
output [3:0] db_jogada,
output [3:0] db_rodada
);

wire [3:0] s_endereco;
wire [3:0] s_rodada;
wire [3:0] s_dado;
wire [3:0] s_chaves;
wire sinal;

  // contador do Endereco
  contador_163 ContEnd (
    .CLK( clock ),
    .CLR( zeraE ),
    .LD( 1'b1 ),
    .ENP( contaE ),
    .ENT( 1'b1 ),
    .D( 4'b0 ),
    .Q( s_endereco ),
    .RCO( fimE )
  );

  // contador da Rodada
  contador_163 ContRod (
    .CLK( clock ),
    .CLR( zeraRod ),
    .LD( 1'b1 ),
    .ENP( contaRod ),
    .ENT( 1'b1 ),
    .D( 4'b0 ),
    .Q(s_rodada),
    .RCO( fimRod )
  );
  
  // Compara Rodada
  comparador_85 comparadorR (
    .A( s_rodada ),
    .B( s_endereco ),
    .ALBi( 1'b0 ),
    .AGBi( 1'b0 ),
    .AEBi( 1'b1 ),
    .ALBo(  ),
    .AGBo(  ),
    .AEBo( enderecoIgualRodada )
  );

  // Compara Jogada
  comparador_85 comparadorJ (
    .A( s_dado ),
    .B( s_chaves ),
    .ALBi( 1'b0 ),
    .AGBi( 1'b0 ),
    .AEBi( 1'b1 ),
    .ALBo(  ),
    .AGBo(  ),
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
  sync_ram_16x4_file memoria(
  .clk(clock),
  .we(1'b0),
  .data(4'b0),
  .addr(s_endereco),
  .q(s_dado)
  );

  // temporizador (contador_M)

  contador_m temporizador(
    .clock(clock),
    .zera_as(zeraT),
    .zera_s(zeraT),
    .conta(contaT),
    .Q(),
    .fim(fimT),
    .meio()
  );

  // Geração do sinal das chaves
  assign sinal = (chaves[0] ^ chaves[1] ^ chaves[2] ^ chaves[3]);
  assign db_tem_jogada = sinal;

  // edge detector
    edge_detector edge_detector(
    .clock(clock),
    .reset(zeraE),
    .sinal(sinal),
    .pulso(jogada_feita)
    );
  
assign db_contagem = s_endereco;
assign db_jogada   = s_chaves;
assign db_memoria  = s_dado;
assign db_rodada   = s_rodada;

endmodule
