/*
  * Cenario de Teste 1 - Acerta todas as jogadas
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

    // Vetor com a memória
    reg [3:0] memoria [0:15] = 
    {   4'b0001, 
        4'b0010, 
        4'b0100, 
        4'b1000, 
        4'b0100, 
        4'b0010, 
        4'b0001, 
        4'b0001, 
        4'b0010, 
        4'b0010, 
        4'b0100, 
        4'b0100, 
        4'b1000, 
        4'b1000, 
        4'b0001, 
        4'b0100};

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
      #(10*clockPeriod);
      iniciar_in = 0;
      // espera
      #(10*clockPeriod);

      // -------------- LOOP DO JOGO ----------------
      initial begin
            for(i=0; i<10; i = i+1) begin
            //coisas
            end
        end


      // final dos casos de teste da simulacao
      caso = 200;
      #100;
      $display("Fim da simulacao");
      $stop;
    end

  endmodule