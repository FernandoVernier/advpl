#INCLUDE  "PROTHEUS.CH"
  
User Function TestSX1(cPerg,aPerg)
/*
+-----------------------------------------------------------------------+
|Programa  | TestSX1  | Autor | Fernando Vernie                         |
|----------|------------------------------------------------------------|
|Descricao | Cria perguntas no SX1.                                     |
|----------+------------------------------------------------------------|
| Uso      | Específico                                          |
|-----------------------------------------------------------------------|
|PROGRAMADOR | DATA   | MOTIVO DA ALTERACAO                             |
|------------|--------|-------------------------------------------------|
|            |        |                                                 |
+-----------------------------------------------------------------------+
*/         

Private nXZ

/*
+------------------------------------------------------+
| Testa de os parametros para o SX1 foram cadastrados. |
| Caso contrario eles serao criados                    |
| aPerguntas -> 1 - Grupo                  C  06  0    |
|               2 - Descricao da Pergunta  C  20  0    |
|               3 - Tipo                   C  01  0    |
|               4 - Tamanho                N  02  0    |
|               5 - Decimal                N  01  0    |
|               6 - Get/Choice             G/C         |
|               7 - Validacao              C  20  0    |
|               8 - F3                     C  03  0    |
|               9 ... 13 - Cont. da choice C  15  0    |
|                                                      |
+------------------------------------------------------+ 
*/ 

For nxZ := 1 To Len(aPerg)
    PutSx1(cPerg,;                                                // Grupo de Perguntas sx1
           StrZero(nxZ,2),;                                       // Ordem do Parƒmetro
           aPerg[nxZ,2],;                                         // Descricao da pergunta Portugues
           "",;                                                   // Descricao da pergunta Espanhol
           "",;                                                   // Descricao da pergunta Ingles
           "Mv_Ch"+IIf(nxZ <=9,AllTrim(Str(nxZ)),Chr(nxZ + 55)),; // Nome Var Controle Auxilia (X1_VARIAVL)
           aPerg[nxZ,3],;                                         // Tipo do Parƒmetro
           aPerg[nxZ,4],;                                         // Tamanho do conteudo do parametro
           aPerg[nxZ,5],;                                         // Numero de decimais para conteudo numerico
           0,;                                                    // Define qual a opcao do combo e a padrao ou parametro
           aPerg[nxZ,6],;                                         // Define se a pergunta sera do tipo G-Get ou C-Choice
           aPerg[nxZ,7],;                                         // Expressao de validacao do parametro
           aPerg[nxZ,8],;                                         // Codigo da consulta F3
           "",;                                                   // Codigo do Grupo campos SXG para atualizacao automatica
           "",;                                                   // Se a pergunta estara disponivel no ambiente Pyme
           "Mv_Par"+StrZero(nxZ,2),;                              // Nome da variavel MV_PAR+"ORDEM" do Parametro
           aPerg[nxZ,9],;                                         // Descricao da opcao 1 do Combobox em pt
           aPerg[nxZ,9],;                                         // Descricao da opcao 1 do Combobox em es
           aPerg[nxZ,9],;                                         // Descricao da opcao 1 do Combobox em in
           "",;                                                   // Conteudo padrao do ultimo conteudo definco como resposta para este item
           aPerg[nxZ,10],;                                        // Descricao da opcao 2 do Combobox em pt
           aPerg[nxZ,10],;                                        // Descricao da opcao 2 do Combobox em es
           aPerg[nxZ,10],;                                        // Descricao da opcao 2 do Combobox em in
           aPerg[nxZ,11],;                                        // Descricao da opcao 3 do Combobox em pt
           aPerg[nxZ,11],;                                        // Descricao da opcao 3 do Combobox em es
           aPerg[nxZ,11],;                                        // Descricao da opcao 3 do Combobox em in
           aPerg[nxZ,12],;                                        // Descricao da opcao 4 do Combobox em pt
           aPerg[nxZ,12],;                                        // Descricao da opcao 4 do Combobox em es
           aPerg[nxZ,12],;                                        // Descricao da opcao 4 do Combobox em in
           aPerg[nxZ,13],;                                        // Descricao da opcao 5 do Combobox em pt
           aPerg[nxZ,13],;                                        // Descricao da opcao 5 do Combobox em es
           aPerg[nxZ,13],;                                        // Descricao da opcao 5 do Combobox em in
           {},;                                                   // Vetor(Arrey) simples contendo as linhas do Help em pt
           {},;                                                   // Vetor(Arrey) simples contendo as linhas do Help em es
           {},;                                                   // Vetor(Arrey) simples contendo as linhas do Help em in
           "")                                                    // Conteudo do campo X1_HELP
Next

Return
