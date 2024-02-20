`timescale 1ns/1ns

module ganhou_circuito_exp6_tb;

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

    wire       enderecoIgualRodada_out;
    wire       db_timeout_out    ;

    wire       db_igual_out      ;
    wire [6:0] db_contagem_out   ;
    wire [6:0] db_memoria_out    ;
    wire [6:0] db_estado_out     ;
    wire [6:0] db_jogadafeita_out;
    wire [6:0] db_rodada_out     ;
    wire       db_clock_out      ;
    wire       db_iniciar_out    ;
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
      .db_estado      ( db_estado_out      ),
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

        // Teste 3. Rodada #1 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 3;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 2 -----------------

        // Teste 4. Rodada #2 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 4;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 5. Rodada #2 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 5;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 3 -----------------

        // Teste 6. Rodada #3 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 6;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 7. Rodada #3 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 7;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 8. Rodada #3 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 8;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 4 -----------------

        // Teste 9. Rodada #4 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 9;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 10. Rodada #4 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 10;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 11. Rodada #4 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 11;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 12. Rodada #4 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 12;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 5 -----------------

        // Teste 13. Rodada #5 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 13;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 14. Rodada #5 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 14;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 15. Rodada #5 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 15;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 16. Rodada #5 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 16;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 17. Rodada #5 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 17;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 6 -----------------

        // Teste 18. Rodada #6 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 18;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 19. Rodada #6 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 19;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 20. Rodada #6 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 20;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 21. Rodada #6 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 21;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 22. Rodada #6 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 22;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 23. Rodada #6 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 23;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 7 -----------------
        
        // Teste 24. Rodada #7 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 24;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 25. Rodada #7 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 25;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 26. Rodada #7 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 26;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 27. Rodada #7 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 27;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 28. Rodada #7 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 28;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 29. Rodada #7 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 29;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 30. Rodada #7 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 29;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        

        // ---------------- RODADA 8 -----------------

        // Teste 31. Rodada #8 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 31;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 32. Rodada #8 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 32;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 33. Rodada #8 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 33;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 34. Rodada #8 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 34;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 35. Rodada #8 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 35;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 36. Rodada #8 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 36;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 37. Rodada #8 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 37;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 38. Rodada #8 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 38;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        

        // ---------------- RODADA 9 -----------------

        // Teste 39. Rodada #9 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 39;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 40. Rodada #9 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 40;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 41. Rodada #9 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 41;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 42. Rodada #9 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 42;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 43. Rodada #9 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 43;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 44. Rodada #9 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 44;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 45. Rodada #9 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 45;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 46. Rodada #9 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 46;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 47. Rodada #9 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 47;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 10 -----------------
        

        // Teste 48. Rodada #10 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 48;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 49. Rodada #10 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 49;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 50. Rodada #10 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 50;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 51. Rodada #10 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 51;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 52. Rodada #10 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 52;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 53. Rodada #10 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 53;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 54. Rodada #10 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 54;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 55. Rodada #10 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 55;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 56. Rodada #10 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 56;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 57. Rodada #10 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 57;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 11 -----------------
        
        // Teste 58. Rodada #11 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 58;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 59. Rodada #11 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 59;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 60. Rodada #11 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 60;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 61. Rodada #11 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 61;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 62. Rodada #11 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 62;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 63. Rodada #11 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 63;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 64. Rodada #11 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 64;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 65. Rodada #11 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 65;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 66. Rodada #11 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 66;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 67. Rodada #11 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 67;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 68. Rodada #11 | jogada #11 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 68;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 12 -----------------
        
        // Teste 69. Rodada #12 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 69;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 70. Rodada #12 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 70;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 71. Rodada #12 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 71;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 72. Rodada #12 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 72;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 73. Rodada #12 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 73;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 74. Rodada #12 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 74;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 75. Rodada #12 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 75;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 76. Rodada #12 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 76;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 77. Rodada #12 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 77;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 78. Rodada #12 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 78;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 79. Rodada #12 | jogada #11 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 79;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 80. Rodada #12 | jogada #12 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 80;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 13 -----------------
        
        // Teste 81. Rodada #13 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 81;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 82. Rodada #13 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 82;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 83. Rodada #13 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 83;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 84. Rodada #13 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 84;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 85. Rodada #13 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 85;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 86. Rodada #13 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 86;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 87. Rodada #13 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 87;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 88. Rodada #13 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 88;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 89. Rodada #13 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 89;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 90. Rodada #13 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 90;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 91. Rodada #13 | jogada #11 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 91;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 92. Rodada #13 | jogada #12 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 92;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 93. Rodada #13 | jogada #13 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 93;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // ---------------- RODADA 14 -----------------

        // Teste 94. Rodada #14 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 94;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 95. Rodada #14 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 95;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 96. Rodada #14 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 96;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 97. Rodada #14 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 97;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 98. Rodada #14 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 98;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 99. Rodada #14 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 99;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 100. Rodada #14 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 100;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 101. Rodada #14 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 101;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 102. Rodada #14 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 102;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 103. Rodada #14 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 103;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 104. Rodada #14 | jogada #11 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 104;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 105. Rodada #14 | jogada #12 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 105;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 106. Rodada #14 | jogada #13 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 106;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 107. Rodada #14 | jogada #14 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 107;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // ---------------- RODADA 15 -----------------

        // Teste 108. Rodada #15 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 108;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 109. Rodada #15 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 109;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 110. Rodada #15 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 110;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 111. Rodada #15 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 111;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 112. Rodada #15 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 112;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 113. Rodada #15 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 113;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 114. Rodada #15 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 114;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 115. Rodada #15 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 115;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 116. Rodada #15 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 116;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 117. Rodada #15 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 117;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 118. Rodada #15 | jogada #11 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 118;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 119. Rodada #15 | jogada #12 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 119;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 120. Rodada #15 | jogada #13 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 120;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 121. Rodada #15 | jogada #14 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 121;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 122. Rodada #15 | jogada #15 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 122;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
  
        
        // ---------------- RODADA 16 -----------------

        // Teste 123. Rodada #16 | jogada #1 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 123;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 124. Rodada #16 | jogada #2 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 124;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 125. Rodada #16 | jogada #3 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 125;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
        // Teste 126. Rodada #16 | jogada #4 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 126;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 127. Rodada #16 | jogada #5 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 127;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 126. Rodada #16 | jogada #6 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 126;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 127. Rodada #16 | jogada #7 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 127;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 128. Rodada #16 | jogada #8 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 128;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 129. Rodada #16 | jogada #9 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 129;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 130. Rodada #16 | jogada #10 | (ajustar chaves para 0010 por 10 periodos de clock)
        caso = 130;
        @(negedge clock_in);
        botoes_in = 4'b0010;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 131. Rodada #16 | jogada #11 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 131;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 132. Rodada #16 | jogada #12 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 132;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 133. Rodada #16 | jogada #13 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 133;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);
        
         // Teste 134. Rodada #16 | jogada #14 | (ajustar chaves para 1000 por 10 periodos de clock)
        caso = 134;
        @(negedge clock_in);
        botoes_in = 4'b1000;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

         // Teste 135. Rodada #16 | jogada #15 | (ajustar chaves para 0001 por 10 periodos de clock)
        caso = 135;
        @(negedge clock_in);
        botoes_in = 4'b0001;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);

        // Teste 136. Rodada #16 | jogada #16 | (ajustar chaves para 0100 por 10 periodos de clock)
        caso = 136;
        @(negedge clock_in);
        botoes_in = 4'b0100;
        #(10*clockPeriod);
        botoes_in = 4'b0000;
        // espera entre jogadas
        #(10*clockPeriod);  
        
        // ---------------- FIM -----------------
      end

  endmodule