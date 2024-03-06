
module unidade_controle_exp7 (
    input      clock,
    input      reset,
    input      iniciar,
    input      fimE,
    input      fimRod,
    input      fimT,
    input      fimP,
    input      jogada,
    input      igual,
    input      enderecoIgualRodada,
    output reg zeraE,
    output reg contaE,
    output reg contaP,
    output reg zeraRod,
    output reg contaRod,
    output reg zeraT,
    output reg zeraP,
    output reg contaT,
    output reg zeraR,
    output reg registraR,
    output reg we,
    output reg acertou,
    output reg errou,
    output reg timeout,
    output reg pronto,
    output reg [3:0] db_estado,
    output reg db_estado_extra,
    output reg sinal_led
);

    // Define estados
    parameter inicial              = 5'b00000;  // 0
    parameter preparacao           = 5'b00001;  // 1
    parameter exibe_jogada_inicial = 5'b00010;  // 2
    parameter inicia_rodada        = 5'b00011;  // 3
    parameter espera_jogada        = 5'b00100;  // 4
    parameter registra             = 5'b00101;  // 5
    parameter comparacao           = 5'b00110;  // 6
    parameter proximo              = 5'b00111;  // 7 
    parameter ultima_rodada        = 5'b01000;  // 8
    parameter espera_nova_jogada   = 5'b01001;  // 9
    parameter registra_nova_jogada = 5'b01011;  // B
    parameter escreve_memoria      = 5'b01101;  // D
    parameter proxima_rodada       = 5'b01111;  // F
    parameter fim_errou            = 5'b01110;  // E
    parameter fim_acertou          = 5'b01010;  // A  
    parameter fim_timeout          = 5'b01100;  // C
    parameter exemplo              = 5'100000;  // 10

    // Variaveis de estado
    reg [3:0] Eatual, Eprox;

    // Memoria de estado
    always @(posedge clock or posedge reset) begin
        if (reset)
            Eatual <= inicial;
        else
            Eatual <= Eprox;
    end
        
    // Logica de proximo estado 
    always @* begin
        case (Eatual) 
            inicial:              Eprox = (iniciar) ? preparacao : inicial;
            preparacao:           Eprox = exibe_jogada_inicial; 
            inicia_rodada:        Eprox = espera_jogada;
            exibe_jogada_inicial: Eprox = (fimP) ? inicia_rodada : exibe_jogada_inicial;
            espera_jogada:        Eprox = (jogada) ? registra : (fimT) ? fim_timeout : espera_jogada;
            registra:             Eprox = comparacao;
            comparacao:           Eprox = (~igual) ? fim_errou : (enderecoIgualRodada) ? ultima_rodada : proximo;
            proximo:              Eprox = espera_jogada;
            ultima_rodada:        Eprox = (fimRod) ? fim_acertou : espera_nova_jogada;
            espera_nova_jogada:   Eprox = (jogada) ? registra_nova_jogada : (fimT) ? fim_timeout : espera_nova_jogada;
            registra_nova_jogada: Eprox = escreve_memoria; 
            escreve_memoria:      Eprox = proxima_rodada;
            proxima_rodada:       Eprox = inicia_rodada; 
            fim_errou:            Eprox = (iniciar) ? preparacao : fim_errou;
            fim_acertou:          Eprox = (iniciar) ? preparacao : fim_acertou;
            fim_timeout:          Eprox = (iniciar) ? preparacao : fim_timeout; 
            default:              Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraE     = (Eatual == inicial || Eatual == preparacao || Eatual == inicia_rodada) ? 1'b1 : 1'b0;
        zeraR     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraP     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraRod   = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraT     = (Eatual == inicial || Eatual == preparacao || Eatual== proximo || Eatual == ultima_rodada) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra || Eatual == registra_nova_jogada) ? 1'b1 : 1'b0;
        contaE    = (Eatual == proximo || Eatual == ultima_rodada) ? 1'b1 : 1'b0;
        contaT    = (Eatual == espera_jogada || Eatual == espera_nova_jogada) ? 1'b1 : 1'b0;
        contaP    = (Eatual == exibe_jogada_inicial) ? 1'b1 : 1'b0;
        contaRod  = (Eatual == proxima_rodada) ? 1'b1 : 1'b0;
        pronto    = (Eatual == fim_acertou || Eatual == fim_errou || Eatual == fim_timeout) ? 1'b1 : 1'b0;
        acertou   = (Eatual == fim_acertou) ? 1'b1 : 1'b0;
        errou     = (Eatual == fim_errou) ? 1'b1 : 1'b0;
        timeout   = (Eatual == fim_timeout) ? 1'b1 : 1'b0; 
        we        = (Eatual == escreve_memoria) ? 1'b1 : 1'b0;
        sinal_led = (Eatual == exibe_jogada_inicial) ? 1'b1 : 1'b0; 
        db_estado = Eatual[4];

        // Saida de depuracao (estado)
        case (Eatual)
            inicial:              db_estado = inicial[3:0];         // 0
            preparacao:           db_estado = preparacao[3:0];      // 1
            exibe_jogada_inicial: db_estado = exibe_jogada_inicial[3:0]; // 2
            inicia_rodada:        db_estado = inicia_rodada[3:0];   // 3
            espera_jogada:        db_estado = espera_jogada[3:0];   // 4
            registra:             db_estado = registra[3:0];        // 5
            comparacao:           db_estado = comparacao[3:0];      // 6
            proximo:              db_estado = proximo[3:0];         // 7
            ultima_rodada:        db_estado = ultima_rodada[3:0];   // 8
            espera_nova_jogada:   db_estado = espera_nova_jogada[3:0]; // 9
            registra_nova_jogada: db_estado = registra_nova_jogada[3:0]; // B
            escreve_memoria:      db_estado = escreve_memoria[3:0]; // D
            proxima_rodada:       db_estado = proxima_rodada[3:0];  // F
            fim_errou:            db_estado = fim_errou[3:0];       // E
            fim_acertou:          db_estado = fim_acertou[3:0];     // A
            fim_timeout:          db_estado = fim_timeout[3:0];     // C
            
            default:       db_estado = 4'b0000;           // 0
        endcase

        

    end

endmodule
