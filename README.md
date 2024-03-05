# Laboratório-Digital-I

## Projeto no ModelSim
Descrição de como simular testbenchs e visualizar as formas de onda no software ModelSim. 
1. File -> New -> Project;
2. Sempre preencher o nome do projeto igual ao módulo principal do testbench;
3. Escolher pasta com todos os arquivos verilog necessários para rodar o testbench;
4. Add Existing File;
5. Selecionar todos os arquivos necessários para o testbench;
6. Compilar os arquivos: Compile -> Compile All;
7. Iniciar simulação: Simulate -> Start Simulation;
8. Eescolher o arquivo do testbench;
9. Selecionar sinais para serem visualizados;
10. Botão direito -> Add Wave
11. Ir na aba de transcript e escrever *run -all*;

## Criando o projeto no Quartus

- Criar uma pasta com os arquivos. A localização da pasta deve seguir : Projetos -> T3BA6 -> ExpX -> expX_quartus
- Abrir o Quartus
- Clicar em New Project Wizard
- Adicionar caminho da pasta criada
- Colocar nome do projeto (geralmente o nome da entidade)
- Selecionar projeto vazio
- Colocar os arquivos do projeto
- Selecionar a FPGA específica (pin count 484/ core speed grade 7/ selecionar terceira da lista: **5CEBA4F23C7**)
- Deixar vazio o software de simulação 
- Finalizar

### Compilação parcial

- Para visualizar os arquivos, clicar em hierarchy e mudar para Files
- Compilar parcialmente: na aba esquerda, selecionar a task compilation e clicar no em analysis & synthesis

### Pinagem

- Clicar em assignment e pin planner ou no ícone de pin planner
- Fazer a pinagem de acordo com a tabela fornecida na experiência 

### RTL Viewer

- Navegar por: Tools -> Netlist Viewers -> RTL Viewer

### Compilação completa

- Clicar no ícone de play na parte superior da janela (compilation)

### Programação

- Ligar a placa de FPGA na USB e ligar a placa
- Navegar por: Tools -> Programação
- Abrir o gerenciador de dispositivos e localizar o Altera usb blaster
C- licar em hardware setup e selecionar o dispositivo do item anterior
- Clicar em start
  
Placa de fpga está configurada