/*
  * Cenario de Teste 2 - Erra a segunda jogada da Rodada 2
  */

`timescale 1ns/1ns

module perdeu_circuito_exp6_tb;

    // Sinais para conectar com o DUT
    // valores iniciais para fins de simulacao (ModelSim)
    reg        clock_in   = 1;
    reg        reset_in   = 0;
    reg        iniciar_in = 0;
    reg  [3:0] botoes_in  = 4'b0000;

    wire       ganhou_out;
    wire       perdeu_out  ;
    wire       pronto_out ;
    wire [3:0] leds_out   ;

    wire       db_enderecoIgualRodada_out;
    wire       db_timeout_out    ;

    wire       db_igual_out      ;
    wire [6:0] db_contagem_out   ;
    wire [6:0] db_memoria_out    ;
    wire [6:0] db_estado_out     ;
    wire [6:0] db_jogadafeita_out;
    wire [6:0] db_rodada_out     ;
    wire       db_clock_out      ;
    wire       db_tem_jogada_out ;

    // Configuração do clock
    parameter clockPeriod = 1000000; // in ns, f=10kHz

    // Identificacao do caso de teste
    reg [31:0] caso = 0;

    // Gerador de clock
    always #((clockPeriod / 2)) clock_in = ~clock_in;

    // instanciacao do DUT (Device Under Test)
    circuito_exp6 dut (
      .clock          ( clock_in    ),
      .reset          ( reset_in    ),
      .iniciar        ( iniciar_in  ),
      .botoes         ( botoes_in   ),
      .leds           ( leds_out    ),
      .pronto         ( pronto_out  ),
      .ganhou         ( ganhou_out ),
      .perdeu         ( perdeu_out   ),
      .db_clock       ( db_clock_out       ),
      .db_tem_jogada  ( db_tem_jogada_out  ),
      .db_igual       ( db_igual_out       ),
      .db_enderecoIgualRodada ( db_enderecoIgualRodada_out ),
      .db_timeout     ( db_timeout_out     ),
      .db_contagem    ( db_contagem_out    ),
      .db_memoria     ( db_memoria_out     ),
      .db_jogadafeita ( db_jogadafeita_out ),  
      .db_rodada      ( db_rodada_out      ),
      .db_estado      ( db_estado_out      )
    );

    // geracao dos sinais de entrada (estimulos)
    initial begin
      $display("Inicio da simulacao");

      // condicoes iniciais
      caso       = 0;
      clock_in   = 1;
      reset_in   = 0;
      iniciar_in = 0;
      botoes_in  = 4'b0000;
      #clockPeriod;


      // Teste 1. resetar circuito
      caso = 1;
      // gera pulso de reset
      @(negedge clock_in);
      reset_in = 1;
      #(clockPeriod);
      reset_in = 0;
      // espera
      #(10*clockPeriod);

      // Teste 2. iniciar=1 por 5 periodos de clock
      caso = 2;
      iniciar_in = 1;
      #(5*clockPeriod);
      iniciar_in = 0;
      // espera
      #(10*clockPeriod);

     // ---------------- RODADA 1 -----------------

      // Teste 3. Rodada #1 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock
      caso = 3;
      @(negedge clock_in);
      botoes_in = 4'b0001;
      #(10*clockPeriod);
      botoes_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // ---------------- RODADA 2 -----------------

      // Teste 4. Rodada #2 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock
      caso = 4;
      @(negedge clock_in);
      botoes_in = 4'b0001;
      #(10*clockPeriod);
      botoes_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 5. Rodada #2 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock
      caso = 5;
      @(negedge clock_in);
      botoes_in = 4'b0010;
      #(10*clockPeriod);
      botoes_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // ---------------- RODADA 3 -----------------

      // Teste 6. Rodada #3 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock
      caso = 6;
      @(negedge clock_in);
      botoes_in = 4'b0001;
      #(10*clockPeriod);
      botoes_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 7. Rodada #3 | jogada #2 | (ajustar chaves para 0100 por 10 periodos de clock
      // ERRAR JOGADA
      caso = 7;
      @(negedge clock_in);
      botoes_in = 4'b0100;
      #(10*clockPeriod);
      botoes_in = 4'b0000;
      // e0010spera entre jogadas
      #(10*clockPeriod);

      // -------------- FIM_PERDEU -----------------


      // final dos casos de teste da simulacao
      caso = 99;
      #100;
      $display("Fim da simulacao");
      $stop;
    end

  endmodule