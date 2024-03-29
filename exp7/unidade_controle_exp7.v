
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
    output reg sinal_led
);

    // Define estados
    parameter inicial              = 4'b0000;  // 0
    parameter preparacao           = 4'b0001;  // 1
    parameter exibe_jogada_inicial = 4'b0010;  // 2
    parameter inicia_rodada        = 4'b0011;  // 3
    parameter espera_jogada        = 4'b0100;  // 4
    parameter registra             = 4'b0101;  // 5
    parameter comparacao           = 4'b0110;  // 6
    parameter proximo              = 4'b0111;  // 7 
    parameter ultima_rodada        = 4'b1000;  // 8
    parameter espera_nova_jogada   = 4'b1001;  // 9
    parameter registra_nova_jogada = 4'b1011;  // B
    parameter escreve_memoria      = 4'b1101;  // D
    parameter proxima_rodada       = 4'b1111;  // F
    parameter fim_errou            = 4'b1110;  // E
    parameter fim_acertou          = 4'b1010;  // A  
    parameter fim_timeout          = 4'b1100;  // C

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

        // Saida de depuracao (estado)
        case (Eatual)
            inicial:              db_estado = inicial;         // 0
            preparacao:           db_estado = preparacao;      // 1
            exibe_jogada_inicial: db_estado = exibe_jogada_inicial; // 2
            inicia_rodada:        db_estado = inicia_rodada;   // 3
            espera_jogada:        db_estado = espera_jogada;   // 4
            registra:             db_estado = registra;        // 5
            comparacao:           db_estado = comparacao;      // 6
            proximo:              db_estado = proximo;         // 7
            ultima_rodada:        db_estado = ultima_rodada;   // 8
            espera_nova_jogada:   db_estado = espera_nova_jogada; // 9
            registra_nova_jogada: db_estado = registra_nova_jogada; // B
            escreve_memoria:      db_estado = escreve_memoria; // D
            proxima_rodada:       db_estado = proxima_rodada;  // F
            fim_errou:            db_estado = fim_errou;       // E
            fim_acertou:          db_estado = fim_acertou;     // A
            fim_timeout:          db_estado = fim_timeout;     // C
            
            default:       db_estado = 4'b0000;           // 0
        endcase
    end

endmodule
