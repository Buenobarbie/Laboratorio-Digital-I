
module desafio4_unidade_controle (
    input      clock,
    input      reset,
    input      iniciar,
    input      fimC,
    input      errou,
    output reg zeraC,
    output reg contaC,
    output reg zeraR,
    output reg registraR,
    output reg pronto,
    output reg [3:0] db_estado,
    output reg acertou
);

    // Define estados
    parameter inicial    = 4'b0000;  // 0
    parameter preparacao = 4'b0001;  // 1
    parameter registra   = 4'b0100;  // 4
    parameter comparacao = 4'b0101;  // 5
    parameter proximo    = 4'b0110;  // 6
    parameter fim_errou = 4'b1100;  // C
    parameter fim_acertou= 4'b1101;  // D

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
            inicial:     Eprox = iniciar ? preparacao : inicial;
            preparacao:  Eprox = registra;
            registra:    Eprox = comparacao;
            comparacao:  Eprox = (errou) ? fim_perdeu : (fimC) ? fim_acertou : proximo;
            proximo:     Eprox = registra;
            fim_errou:  Eprox = inicial;
            fim_acertou: Eprox = inicial;
            default:     Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraC     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraR     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra) ? 1'b1 : 1'b0;
        contaC    = (Eatual == proximo) ? 1'b1 : 1'b0;
        pronto    = (Eatual == fim_acertou || Eatual == fim_errou) ? 1'b1 : 1'b0;
        acertou   = (Eatual == fim_acertou) ? 1'b1 : 1'b0;

        // Saida de depuracao (estado)
        case (Eatual)
            inicial:     db_estado = 4'b0000;  // 0
            preparacao:  db_estado = 4'b0001;  // 1
            registra:    db_estado = 4'b0100;  // 4
            comparacao:  db_estado = 4'b0101;  // 5
            proximo:     db_estado = 4'b0110;  // 6
            fim_errou:   db_estado = 4'b1100;  // C
            fim_acertou: db_estado = 4'b1101;  // D
            
            default:     db_estado = 4'b1111;  // F
        endcase
    end

endmodule
