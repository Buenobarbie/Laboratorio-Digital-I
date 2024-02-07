
module exp5_unidade_controle (
    input      clock,
    input      reset,
    input      iniciar,
    input      fim,
    input      jogada,
    input      igual,
    input      fimT,
    output reg zeraC,
    output reg contaC,
    output reg zeraT,
    output reg contaT,
    output reg zeraR,
    output reg registraR,
    output reg timeout,
    output reg acertou,
    output reg errou,
    output reg pronto,
    output reg [3:0] db_estado
);

    // Define estados
    parameter inicial       = 4'b0000;  // 0
    parameter preparacao    = 4'b0001;  // 1
    parameter espera_jogada = 4'b0010;  // 2
    parameter registra      = 4'b0100;  // 4
    parameter comparacao    = 4'b0101;  // 5
    parameter proximo       = 4'b0110;  // 6
    parameter fim_timeout   = 4'b1100;  // C
    parameter fim_errou     = 4'b1110;  // E
    parameter fim_acertou   = 4'b1010;  // A

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
            inicial:       Eprox = iniciar ? preparacao : inicial;
            preparacao:    Eprox = espera_jogada;
            espera_jogada: Eprox = (jogada) ? registra : (fimT) ? fim_timeout : espera_jogada;
            registra:      Eprox = comparacao;
            comparacao:    Eprox = (~igual) ? fim_errou : (fim) ? fim_acertou : proximo;
            proximo:       Eprox = espera_jogada;
            fim_errou:     Eprox = (iniciar) ? preparacao : fim_errou;
            fim_timeout:   Eprox = (iniciar) ? preparacao : fim_timeout;
            fim_acertou:   Eprox = (iniciar) ? preparacao : fim_acertou;
            default:       Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraC     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraT     = (Eatual == inicial || Eatual == preparacao || Eatual==proximo) ? 1'b1 : 1'b0;
        zeraR     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra) ? 1'b1 : 1'b0;
        contaC    = (Eatual == proximo) ? 1'b1 : 1'b0;
        contaT    = (Eatual == espera_jogada) ? 1'b1 : 1'b0;
        pronto    = (Eatual == fim_acertou || Eatual == fim_errou || Eatual == fim_timeout) ? 1'b1 : 1'b0;
        timeout   = (Eatual == fim_timeout) ? 1'b1 : 1'b0;
        acertou   = (Eatual == fim_acertou) ? 1'b1 : 1'b0;
        errou     = (Eatual == fim_errou) ? 1'b1 : 1'b0;

        // Saida de depuracao (estado)
        case (Eatual)
            inicial:       db_estado = inicial;        // 0
            preparacao:    db_estado = preparacao;     // 1
            espera_jogada: db_estado = espera_jogada;  // 2
            registra:      db_estado = registra;       // 4
            comparacao:    db_estado = comparacao;     // 5
            proximo:       db_estado = proximo;        // 6
            fim_timeout:   db_estado = fim_timeout;    // C
            fim_errou:     db_estado = fim_errou;      // E
            fim_acertou:   db_estado = fim_acertou;    // A
            
            default:       db_estado = 4'b1111;        // F
        endcase
    end

endmodule
