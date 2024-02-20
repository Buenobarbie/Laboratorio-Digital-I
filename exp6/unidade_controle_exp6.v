
module unidade_controle_exp6 (
    input      clock,
    input      reset,
    input      iniciar,
    input      fimE,
    input      fimRod,
    input      fimT,
    input      jogada,
    input      igual,
    input      enderecoIgualRodada,
    output reg zeraE,
    output reg contaE,
    output reg zeraRod,
    output reg contaRod,
    output reg zeraT,
    output reg contaT,
    output reg zeraR,
    output reg registraR,
    output reg acertou,
    output reg errou,
    output reg timeout,
    output reg pronto,
    output reg [3:0] db_estado
);

    // Define estados
    parameter inicial         = 4'b0000;  // 0
    parameter preparacao      = 4'b0001;  // 1
    parameter inicia_rodada   = 4'b0010;  // 2
    parameter espera_jogada   = 4'b0011;  // 3
    parameter registra        = 4'b0100;  // 4
    parameter comparacao      = 4'b0101;  // 5
    parameter proximo         = 4'b0110;  // 6
    parameter ultima_rodada   = 4'b0111;  // 7 
    parameter proxima_rodada  = 4'b1000;  // 8
    parameter fim_errou       = 4'b1110;  // E
    parameter fim_acertou     = 4'b1010;  // A  
    parameter fim_timeout     = 4'b1100;  // C

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
            inicial:         Eprox = (iniciar) ? preparacao : inicial;
            preparacao:      Eprox = inicia_rodada; 
            inicia_rodada:   Eprox = espera_jogada;
            espera_jogada:   Eprox = (jogada) ? registra : (fimT) ? fim_timeout : espera_jogada;
            registra:        Eprox = comparacao;
            comparacao:      Eprox = (~igual) ? fim_errou : (enderecoIgualRodada) ? ultima_rodada : proximo;
            proximo:         Eprox = espera_jogada;
            ultima_rodada:   Eprox = (fimRod) ? fim_acertou : proxima_rodada;
            proxima_rodada:  Eprox = inicia_rodada; 
            fim_errou:       Eprox = (iniciar) ? preparacao : fim_errou;
            fim_acertou:     Eprox = (iniciar) ? preparacao : fim_acertou;
            fim_timeout:     Eprox = (iniciar) ? preparacao : fim_timeout; 
            default:         Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraE     = (Eatual == inicial || Eatual == preparacao || Eatual == inicia_rodada) ? 1'b1 : 1'b0;
        zeraR     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraRod   = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraT     = (Eatual == inicial || Eatual == preparacao || Eatual== proximo) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra) ? 1'b1 : 1'b0;
        contaE    = (Eatual = proximo) ? 1'b1 : 1'b0;
        contaT    = (Eatual == espera_jogada) ? 1'b1 : 1'b0;
        contaRod  = (Eatual == proxima_rodada) ? 1'b1 : 1'b0;
        pronto    = (Eatual == fim_acertou || Eatual == fim_errou || Eatual == fim_timeout) ? 1'b1 : 1'b0;
        acertou   = (Eatual == fim_acertou) ? 1'b1 : 1'b0;
        errou     = (Eatual == fim_errou) ? 1'b1 : 1'b0;
        timeout   = (Eatual == fim_timeout) ? 1'b1 : 1'b0; 

        // Saida de depuracao (estado)
        case (Eatual)
            inicial:         db_estado = inicial;         // 0
            preparacao:      db_estado = preparacao;      // 1
            inicia_rodada:   db_estado = exibe_sequencia; // 2
            espera_jogada:   db_estado = espera_jogada;   // 3
            registra:        db_estado = registra;        // 4
            comparacao:      db_estado = comparacao;      // 5
            proximo:         db_estado = proximo;         // 6
            ultima_rodada:   db_estado = ultima_rodada;   // 7
            proxima_rodada:  db_estado = proxima_rodada;  // 8
            fim_errou:       db_estado = fim_errou;       // E
            fim_acertou:     db_estado = fim_acertou;     // A
            fim_timeout:     db_estado = fim_timeout;     // C

            
            default:       db_estado = 4'b1111;           // F
        endcase
    end

endmodule
