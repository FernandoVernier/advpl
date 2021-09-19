#include 'protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ JobExt      ºAutor  ³Fernando Vernier º Data ³  21.10.20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Job Processamento Extrato Bancario Automatico  e DDA       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#define __codBanco "341"
#define __nomBanco "ITAÚ"

#define nLarg  (605-35)
#define nAlt   842


User Function RBol341( oBoleto, lNota )

	Local nBloco1 := 0
	Local nBloco2 := 0
	Local nBloco3 := 0

	Local nPercJurosDia := SEE->EE__JRDIA / 100
	Local nPercMulta    := SEE->EE__MULTA / 100
	Local nDiasProtesto := SEE->EE_DIASPRT

	Local nMulta := 0
	Local nJuros := 0

	Private cAge	:= iif(alltrim(SEE->EE_XAGE) ="", alltrim(SEE->EE_AGENCIA),alltrim(SEE->EE_XAGE))
	Private cDvAge 	:= iif(alltrim(SEE->EE_XDVAGE)="", SEE->EE_DVAGE,SEE->EE_XDVAGE) 
	Private cCta	:= iif(alltrim(SEE->EE_XCTA)="", alltrim(SEE->EE_CONTA),alltrim(SEE->EE_XCTA))
	Private cDvCta 	:= iif(alltrim(SEE->EE_XDVCTA)="", alltrim(SEE->EE_DVCTA),alltrim(SEE->EE_XDVCTA))
	Private cDdCta	  := cAge+iif(alltrim(cDvAge)="","","-")+alltrim(cDvAge)+"/"+cCta+iif(alltrim(cDvCta)="","","-")+cDvCta
	
	Private oArial06  := TFont():New('Arial',06,06,,.F.,,,,.T.,.F.,.F.)
	Private oArial09N := TFont():New('Arial',10,10,,.T.,,,,.T.,.F.,.F.)
	Private oArial12N := TFont():New('Arial',12,12,,.T.,,,,.T.,.F.,.F.)
	Private oArial14  := TFont():New('Arial',16,16,,.F.,,,,.T.,.F.,.F.)
	Private oArial18N := TFont():New('Arial',21,21,,.T.,,,,.T.,.F.,.F.)


	Private aInstrucoes := {"","",""}
	Private aMensagens := {"","",""}

	//calcula o valor dos abatimentos
	Private nValorAbatimentos := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
	//calculo valor total
	Private nValorDocumento := ((SE1->E1_SALDO+SE1->E1_ACRESC)-SE1->E1_DECRESC)-nValorAbatimentos
	//nosso numero
	Private cNossoNumero := ""
	//codigo de barras
	Private cCodigoBarra := ""
	Private cLinhaDigitavel := ""
	Private cNossoNum := ""
	
	// Gerar nosso número banco.
	If Empty(SE1->E1_NUMBCO)	
		IF !Empty(SEE->EE_FAXATU)
			cNossoNum := strzero(val(SEE->EE_FAXATU)+1,8)
		else
			Aviso("Atenção","Tabela Parâmetros dos Bancos (EE_FAXATU) não configurada!",{"Sair"}, 2)
			Return
		EndIF
		IF !Empty(cNossoNum)
			IF RecLock("SEE",.F.)
				SEE->EE_FAXATU := cNossoNum
				SEE->(MsUnlock())
			EndIF
			 
			// Gravando sem o dígito da conta.
			IF RecLock("SE1",.F.)
				SE1->E1_NUMBCO := cNossoNum
				SE1->(MsUnlock())
			EndIF
			
		EndIF
	Endif
	// Cálculo do Digito é na hora da impressão.
	cNossoNumero 	:= substr(SE1->E1_NUMBCO,1,8) + "-" + alltrim(Str(nnItau(substr(SE1->E1_NUMBCO,1,8))))
	cCodigoBarra 	:= BolCodBar()
	
	//calcula o valor da Multa após o vencimento
	IF nPercJurosDia > 0
		aInstrucoes[1] := "Mora diária de (%): " + Alltrim(Transform(nPercJurosDia, "@E 99.999")) 
	EndIF

	//calculo o valor de juros por dia de atraso
	IF nPercMulta > 0
		aInstrucoes[2] := "Após vencimento cobrar Multa de " + Alltrim(Transform(nPercMulta, "@E 99.99")) + " %" 
	EndIF

	// Mensagem de Protesto
	If alltrim(nDiasProtesto) <> ""  
		aInstrucoes[3] := "Registro no Serviço Central de Proteção ao Crédito após " + Alltrim(nDiasProtesto) + " dias corrido ao vencimento."
	Endif
	
	//mensagens
	aMensagens[1] := SEE->EE__MSG01
	aMensagens[2] := SEE->EE__MSG02
	aMensagens[3] := SEE->EE__MSG03

	//inicia pagina
	oBoleto:StartPage()

	//Nome do Banco
	oBoleto:Say(nBloco1+33,25,"Itau",oArial12N )
	//logo
	oBoleto:SayBitmap(nBloco1+20, 20, "\boletos\logos\logo-banco-341.jpg", 75, 20)
	//Line(linha_inicial, coluna_inicial, linha final, coluna final)
	oBoleto:Line( nBloco1+20,  95, nBloco1+40,  95,,"01")
	oBoleto:Line( nBloco1+20, 146, nBloco1+40, 146,,"01")

	//Numero do Banco
	oBoleto:Say(nBloco1+35,99,"341-7", oArial18N )

	//adiciona mais dois ao depois
	nBloco1 += 3

	oBoleto:Say(nBloco1+33,455,"Comprovante de Entrega",oArial09N)

	//nome da empresa
	oBoleto:Say(nBloco1+45,25 ,"Beneficiário",oArial06)
	oBoleto:Say(nBloco1+57,25 ,substr(alltrim(SM0->M0_NOMECOM),1,47),oArial09N)

	oBoleto:Say(nBloco1+45,250,"Agência/Código Beneficiário",oArial06)
	oBoleto:Say(nBloco1+57,250,cDdCta ,oArial09N)

	oBoleto:Say(nBloco1+45,350,"Nro. Documento",oArial06)
	oBoleto:Say(nBloco1+57,350,alltrim(SE1->(E1_NUM+E1_PARCELA)) ,oArial09N) //Prefixo +Numero+Parcela

	oBoleto:Say(nBloco1+70,25,"Sacado",oArial06)
	oBoleto:Say(nBloco1+82,25,SA1->A1_NOME,oArial09N)				//Nome

	oBoleto:Say(nBloco1+70,250,"Vencimento",oArial06)
	oBoleto:Say(nBloco1+82,250, FormDate(SE1->E1_VENCTO),oArial09N)

	oBoleto:Say(nBloco1+70,350,"Valor do Documento",oArial06)
	oBoleto:Say(nBloco1+82,350,Transform(nValorDocumento,"@E 999,999,999.99"),oArial09N)

	oBoleto:Say(nBloco1+105,25,"Recebi(emos) o bloqueto/título",oArial09N)
	oBoleto:Say(nBloco1+117,25,"com as características acima.",oArial09N)

	oBoleto:Say(nBloco1+95,250,"Data",oArial06)
	oBoleto:Say(nBloco1+95,330,"Assinatura",oArial06)

	oBoleto:Say(nBloco1+120,250,"Data",oArial06)
	oBoleto:Say(nBloco1+120,330,"Entregador",oArial06)

	oBoleto:Say(nBloco1+ 50,455,"(  ) Mudou-se"                 ,oArial06)
	oBoleto:Say(nBloco1+ 60,455,"(  ) Ausente"                  ,oArial06)
	oBoleto:Say(nBloco1+ 70,455,"(  ) Não existe nº indicado"   ,oArial06)
	oBoleto:Say(nBloco1+ 80,455,"(  ) Recusado"                 ,oArial06)
	oBoleto:Say(nBloco1+ 90,455,"(  ) Não procurado"            ,oArial06)
	oBoleto:Say(nBloco1+100,455,"(  ) Endereço insuficiente"    ,oArial06)
	oBoleto:Say(nBloco1+110,455,"(  ) Desconhecido"             ,oArial06)
	oBoleto:Say(nBloco1+120,455,"(  ) Falecido"                 ,oArial06)
	oBoleto:Say(nBloco1+130,455,"(  ) Outros (anotar no verso)"  ,oArial06)

	//linhas horizontais
	oBoleto:Line(nBloco1+ 37,  20,nBloco1+ 37,nLarg,,"01")
	oBoleto:Line(nBloco1+ 62,  20,nBloco1+ 62, 450 ,,"01")
	oBoleto:Line(nBloco1+ 87,  20,nBloco1+ 87, 450 ,,"01")
	oBoleto:Line(nBloco1+112, 247,nBloco1+112, 450 ,,"01")
	oBoleto:Line(nBloco1+137,  20,nBloco1+137,nLarg ,,"01")

	//linhas vericais
	oBoleto:Line(nBloco1+ 37,247,nBloco1+137,247 ,,"01")
	oBoleto:Line(nBloco1+ 87,327,nBloco1+137,327 ,,"01")
	oBoleto:Line(nBloco1+ 37,347,nBloco1+ 87,347 ,,"01")
	oBoleto:Line(nBloco1+ 37,450,nBloco1+137,450 ,,"01")

	//ajuste fino
	nBloco2 += 5
	//Pontilhado separador
	For nPont := 10 to nLarg+10 Step 4
		oBoleto:Line(nBloco2+147, nPont,nBloco2+147, nPont+2,,)
	Next nPont

	//Nome do Banco
	oBoleto:Say(nBloco2+170,25,"Itau",oArial12N )
	//logo
	oBoleto:SayBitmap(nBloco2+157, 20, "\boletos\logos\logo-banco-341.jpg", 75, 20)
	//Line(linha_inicial, coluna_inicial, linha final, coluna final)
	oBoleto:Line( nBloco2+157,  95, nBloco2+177,  95,,"01")
	oBoleto:Line( nBloco2+157, 146, nBloco2+177, 146,,"01")
	oBoleto:Line( nBloco2+177,  20, nBloco2+177,nLarg,,"01")

	//Numero do Banco
	oBoleto:Say(nBloco2+174,99,"341-7",oArial18N )

	//adiciona mais dois ao depois
	nBloco1 += 3

	oBoleto:Say(nBloco2+174,455,"Recibo do Pagador",oArial09N)

	ImprimeBloco(oBoleto, nBloco2)

	//BLOCO 3

	//Pontilhado separador
	For nPont := 10 to nLarg+10 Step 4
		oBoleto:Line(nBloco3+460, nPont,nBloco3+460, nPont+2,,)
	Next nPont

	//Nome do Banco
	oBoleto:Say(nBloco2+485,25,"Itau",oArial12N )
	//logo
	oBoleto:SayBitmap(nBloco2+472, 20, "\boletos\logos\logo-banco-341.jpg", 75, 20)
	//Line(linha_inicial, coluna_inicial, linha final, coluna final)
	oBoleto:Line( nBloco2+472,  95, nBloco2+492,  95,,"01")
	oBoleto:Line( nBloco2+472, 146, nBloco2+492, 146,,"01")
	oBoleto:Line( nBloco2+492,  20, nBloco2+492,nLarg,,"01")

	//Numero do Banco
	oBoleto:Say(nBloco2+489,99,"341-7",oArial18N )
	//linha digitavel
	oBoleto:SayAlign(nBloco2+477,155,cLinhaDigitavel,oArial14,400,,,1)

	ImprimeBloco(oBoleto, nBloco3 + 320 )

	//oPrinter:FWMSBAR("INT25" /*cTypeBar*/,1/*nRow*/ ,1/*nCol*/, cCodINt25/*cCode*/,oPrinter/*oPrint*/,.T./*lCheck*/,/*Color*/,.T./*lHorz*/,0.02/*nWidth*/,0.8/*nHeigth*/,.T./*lBanner*/,"Arial"/*cFont*/,NIL/*cMode*/,.F./*lPrint*/,2/*nPFWidth*/,2/*nPFHeigth*/,.F./*lCmtr2Pix*/
	oBoleto:FWMSBAR("INT25" ,61.25,1.7, cCodigoBarra ,oBoleto,.F.,,.T.,0.02,1,.F.,"Arial",NIL,.F.,2,2,.F.)
	/*
	// Se impressão veio a partir da nota fiscal
	If lNota  
		oBoleto:Code128C(795,25,cCodigoBarra, 45 )
	Else
		oBoleto:Code128C(790,25,cCodigoBarra, 45 )
	Endif
	*/
	//Finaliza pagina
	oBoleto:EndPage()



Return




Static Function ImprimeBloco(oBoleto, nBloco)

	//bloco 2 linha 1 ->
	oBoleto:Say(nBloco+185,25 ,"Local de Pagamento",oArial06)
	//oBoleto:Say(nBloco+196,25 ,"PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO",oArial09N)
	oBoleto:Say(nBloco+196,25 ,"Até o vencimento, preferencialmente no Itaú. Após o vencimento, somente no Itaú.",oArial09N)
	oBoleto:Say(nBloco+185,425 ,"Vencimento",oArial06)
	oBoleto:Say(nBloco+196,435 ,FormDate(SE1->E1_VENCTO),oArial09N)

	//bloco 2 linha 2 ->
	oBoleto:Line( nBloco+200,  20, nBloco+200,nLarg,,"01")
	oBoleto:Say(nBloco+206,25 , "Beneficiário",oArial06)
	oBoleto:Say(nBloco+216,25 , SM0->M0_NOMECOM + " - CNPJ: " + transform(SM0->M0_CGC,"@R 99.999.999/9999-99") ,oArial09N)
	oBoleto:Say(nBloco+226,25 , SM0->M0_ENDCOB ,oArial09N)
	oBoleto:Say(nBloco+236,25 , transform(SM0->M0_CEPCOB,"@R 99999-999")+ " - " + alltrim(SM0->M0_CIDCOB)+"/"+SM0->M0_ESTCOB ,oArial09N)
	oBoleto:Say(nBloco+206,425 ,"Agência/Código Beneficiário",oArial06)
	oBoleto:Say(nBloco+216,435 ,cDdCta,oArial09N)

	//bloco 2 linha 3 ->
	oBoleto:Line( nBloco+220,  420, nBloco+220,nLarg,,"01")
	oBoleto:Say(nBloco+226,425 ,"Para uso do Banco",oArial06)

	//bloco 2 linha 4 ->
	oBoleto:Line( nBloco+240,  20, nBloco+240,nLarg,,"01")
	oBoleto:Say(nBloco+246,25, "Data do Documento" ,oArial06)
	oBoleto:Say(nBloco+256,25, FormDate(SE1->E1_EMISSAO), oArial09N)

	oBoleto:Line(nBloco+240, 110, nBloco+260,110,,"01")
	oBoleto:Say(nBloco+246,115, "Número Documento"                                  ,oArial06)
	oBoleto:Say(nBloco+256,115, alltrim(SE1->(E1_NUM+E1_PARCELA)) ,oArial09N)

	oBoleto:Line(nBloco+240, 232, nBloco+260,232,,"01")
	oBoleto:Say(nBloco+246,237, "Espécie Doc."                                   ,oArial06)
	oBoleto:Say(nBloco+256,237, "DM"										,oArial09N) //Tipo do Titulo

	oBoleto:Line(nBloco+240, 293, nBloco+260,293,,"01")
	oBoleto:Say(nBloco+246,298, "Aceite"                                         ,oArial06)
	oBoleto:Say(nBloco+256,298, "N"                                             ,oArial09N)

	oBoleto:Line(nBloco+240, 339, nBloco+260,339,,"01")
	oBoleto:Say(nBloco+246,344, "Data do Processamento"                          ,oArial06)
	oBoleto:Say(nBloco+256,344, FormDate(SE1->E1_EMISSAO),oArial09N) // Data impressao

	oBoleto:Say(nBloco+246,425 ,"Nosso Número",oArial06)
	oBoleto:Say(nBloco+256,435 ,SEE->EE_CODCART + "/" + cNossoNumero,oArial09N)

	//bloco 2 linha 5 ->
	oBoleto:Line( nBloco+260,  20, nBloco+260,nLarg,,"01")
	oBoleto:Say(nBloco+266,25,"Uso do Banco"                                   ,oArial06)

	oBoleto:Line(nBloco+260,110, nBloco+280,110,,"01")
	oBoleto:Say(nBloco+266,115 ,"Carteira"                                       ,oArial06)
	oBoleto:Say(nBloco+276,115 ,SEE->EE_CODCART                                	,oArial09N)

	oBoleto:Line(nBloco+260, 171, nBloco+280,171,,"01")
	oBoleto:Say(nBloco+266,176 ,"Espécie"                                        ,oArial06)
	oBoleto:Say(nBloco+276,176 ,"R$"                                             ,oArial09N)

	oBoleto:Line(nBloco+260, 232, nBloco+280,232,,"01")
	oBoleto:Say(nBloco+266,237,"Quantidade"                                     ,oArial06)
	oBoleto:Line(nBloco+260,339, nBloco+280,339,,"01")
	oBoleto:Say(nBloco+266,344,"Valor"                                          ,oArial06)

	oBoleto:Say(nBloco+266,425 ,"Valor do Documento",oArial06)
	oBoleto:Say(nBloco+276,435 ,Transform(nValorDocumento,"@E 999,999,999.99"),oArial09N)


	//bloco 2 linha 6 ->
	oBoleto:Line( nBloco+280,  20, nBloco+280,nLarg,,"01")
	oBoleto:Say( nBloco+286,25, "Instruções (INSTRUÇÕES DE RESPONSABILIDADE DO BENEFICIÁRIO. QUALQUER DÚVIDA SOBRE ESTE BOLETO, CONTATE O BENEFICIÁRIO.)" , oArial06)

	oBoleto:Say(nBloco+296,0025,aInstrucoes[1],oArial09N)
	oBoleto:Say(nBloco+306,0025,aInstrucoes[2],oArial09N)
	oBoleto:Say(nBloco+316,0025,aInstrucoes[3],oArial09N)
	oBoleto:Say(nBloco+326,0025,aMensagens[1],oArial09N)
	oBoleto:Say(nBloco+336,0025,aMensagens[2],oArial09N)
	oBoleto:Say(nBloco+346,0025,aMensagens[3],oArial09N)
	
	oBoleto:Say(nBloco+286,425,"(-)Desconto/Abatimento",oArial06)

	//bloco 2 linha 7 ->
	oBoleto:Line( nBloco+300,  420, nBloco+300,nLarg,,"01")
	oBoleto:Say(nBloco+306,425,"(-)Outras Deduções",oArial06)

	//bloco 2 linha 8 ->
	oBoleto:Line( nBloco+320,  420, nBloco+320,nLarg,,"01")
	oBoleto:Say(nBloco+326,425,"(+)Juros/Multa",oArial06)

	//bloco 2 linha 9 ->
	oBoleto:Line( nBloco+340,  420, nBloco+340,nLarg,,"01")
	oBoleto:Say(nBloco+346,425,"(+)Outros Acréscimos",oArial06)

	//bloco 2 linha 10 ->
	oBoleto:Line( nBloco+360,  420, nBloco+360,nLarg,,"01")
	oBoleto:Say(nBloco+366,425,"(=)Valor Cobrado",oArial06)
	oBoleto:Line( nBloco+177,  420, nBloco+380,420,,"01")

	//bloco 2 pagardor ->
	oBoleto:Line( nBloco+380,  20, nBloco+380,nLarg,,"01")
	oBoleto:Say(nBloco+386,25 ,"Pagador",oArial06)
	oBoleto:Say(nBloco+396,25 ,SA1->A1_NOME + " - CNPJ: " + transform(SA1->A1_CGC,"@R 99.999.999/9999-99") ,oArial09N)
	oBoleto:Say(nBloco+406,25 ,SA1->A1_END + " - " + SA1->A1_BAIRRO ,oArial09N)
	oBoleto:Say(nBloco+416,25 ,transform(SA1->A1_CEP,"@R 99999-999")+ " - " + alltrim(SA1->A1_MUN)+"/"+SA1->A1_EST ,oArial09N)

	//bloco 2 Sacador - autenticação ->
	oBoleto:Say(nBloco+425, 25, "Sacador/Avalista" , oArial06)
	oBoleto:Line( nBloco+427,  20, nBloco+427,nLarg,,"01")
	oBoleto:Say(nBloco+432,430, "Autenticação Mecânica - Ficha de compensação" , oArial06)

Return



Static Function BolCodBar()

	Local cValorFinal := StrZero(Round(nValorDocumento*100,0),10)
	Local nDigVerNN   := alltrim(Str(nnItau(substr(SE1->E1_NUMBCO,1,8))))
	Local nDigVerCB   := 0
	Local cCodigo     := ''
	Local cAuxiliar   := ''
	Local cFator      := StrZero( SE1->E1_VENCTO - CtoD("07/10/97"),4)

	Local cCarteira   := SEE->EE_CODCART
	Local cAgencia    := cAge //SUBSTR(SEE->EE_AGENCIA,1,4)
	Local cConta      := cCta //SUBSTR(SA6->A6_NUMCON,1,5)
	Local cDigConta   := cDvCta //SUBSTR(SA6->A6_NUMCON,7,1)

		
	//	 Definicao do CODIGO DE BARRAS
	cAuxiliar:= SEE->EE_CODIGO + "9" + cFator +  cValorFinal + cCarteira + alltrim(SE1->E1_NUMBCO)+ alltrim(nDigVerNN) + cAgencia + cConta + cDigConta + '000'
	nDigVerCB := modulo11(cAuxiliar)
	cCodigo   := SubStr(cAuxiliar, 1, 4) + alltrim(str(nDigVerCB)) + SubStr(cAuxiliar,5,39)
	
	//-------- Definicao da LINHA DIGITAVEL (Representacao Numerica)
	//	Campo 1			Campo 2			Campo 3			Campo 4		Campo 5
	//	AAABC.CCDDX		DDDDD.DDFFFY	FGGGG.GGHHHZ	K			UUUUVVVVVVVVVV
	// 	CAMPO 1:
	//	AAA	= Codigo do banco na Camara de Compensacao
	//	  B = Codigo da moeda, sempre 9
	//	CCC = Codigo da Carteira de Cobranca
	//	 DD = Dois primeiros digitos no nosso numero
	//	  X = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
	cAuxiliar    := SEE->EE_CODIGO + "9" + cCarteira + SubStr(alltrim(SE1->E1_NUMBCO),1,2)
	cLinhaDigitavel   := SubStr(cAuxiliar, 1, 5) + '.' + SubStr(cAuxiliar, 6, 4) + alltrim(str(modulo10(cAuxiliar))) + '  '

	// 	CAMPO 2:
	//	DDDDDD = Restante do Nosso Numero
	//	     E = DAC do campo Agencia/Conta/Carteira/Nosso Numero
	//	   FFF = Tres primeiros numeros que identificam a agencia
	//	     Y = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
	cAuxiliar := Subs(cNossoNumero,3,6) + Alltrim(nDigVerNN)+ Subs(cAgencia,1,3)
	cLinhaDigitavel +=  SubStr(cAuxiliar,1,5) + '.' + SubStr(cAuxiliar,6,5)  + alltrim(str(modulo10(cAuxiliar))) + ' '

	// 	CAMPO 3:
	//	     F = Restante do numero que identifica a agencia
	//	GGGGGG = Numero da Conta + DAC da mesma
	//	   HHH = Zeros (Nao utilizado)
	//	     Z = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
	cAuxiliar    := Subs(cAgencia,4,1) + Subs(cConta,1,4) +  Subs(cConta,5,1)+Alltrim(cDigConta)+'000'
	cLinhaDigitavel   := cLinhaDigitavel + Subs(cAgencia,4,1) + Subs(cConta,1,4) +'.'+ Subs(cConta,5,1)+Alltrim(cDigConta)+'000'+ alltrim(str(Modulo10(cAuxiliar)))

	//	CAMPO 4:
	//	     K = DAC do Codigo de Barras
	cLinhaDigitavel   := cLinhaDigitavel + ' ' + AllTrim(Str(nDigVerCB)) + '  '

	// 	CAMPO 5:
	//	      UUUU = Fator de Vencimento
	//	VVVVVVVVVV = Valor do Titulo
	cLinhaDigitavel   := cLinhaDigitavel + cFator + StrZero(Round(nValorDocumento * 100,0),14-Len(cFator))

Return cCodigo


Static Function Modulo10(cData)
	Local L,D,P := 0
	Local B     := .F.
	L := Len(cData)
	B := .T.
	D := 0
	While L > 0
		P := val(SubStr(cData, L, 1))
		IF (B)
			P := P * 2
			IF P > 9
				P := P - 9
			EndIF
		EndIF
		D := D + P
		L := L - 1
		B := !B
	EndDO
	D := 10 - (Mod(D,10))
	IF D = 10
		D := 0
	EndIF
Return(D)



Static Function Modulo11(cData)
	Local L, D, P := 0
	L := Len(cdata)
	D := 0
	P := 1
	While L > 0
		P := P + 1
		D := D + (val(SubStr(cData, L, 1)) * P)
		IF P = 9
			P := 1
		EndIF
		L := L - 1
	EndDO
	D := 11 - (mod(D,11))
	IF (D == 0 .Or. D == 1 .Or. D == 10 .Or. D == 11)
		D := 1
	EndIF
Return(D)


/*/{Protheus.doc} nnItau
(Gera nosso número Itaú)
@author administrador
@since 06/01/2016
@version 1.0
@param cNossoNum, character, (Descrição do parâmetro)
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/

Static Function nnItau(cNossoNum)
Local cNN := Strzero(val(cNossoNum),8)

cNN := Modulo10Itau(cAge + cCta + alltrim(SEE->EE_CODCART) + cNN)
Return(cNN)

Static Function Modulo10Itau(cNN)
	LOCAL L,D,P := 0
	LOCAL B     := .F.
	L := Len(cNN)
	B := .T.
	D := 0
	While L > 0
		P := Val(SubStr(cNN, L, 1))
		If (B)
			P := P * 2
			If P > 9
				P := P - 9
			End
		End
		D := D + P
		L := L - 1
		B := !B
	End
	D := 10 - (Mod(D,10))
	If D = 10
		D := 0
	End
Return(D)


/*
Local cDigNN := "" // Digito nosso número
Local nNossoNum := cNN
nSoma1 := val(subs(nNossoNum,01,1))*1 
nSoma2 := val(subs(nNossoNum,02,1))*2 
nSoma3 := val(subs(nNossoNum,03,1))*1
nSoma4 := val(subs(nNossoNum,04,1))*2
nSoma5 := val(subs(nNossoNum,05,1))*1
nSoma6 := val(subs(nNossoNum,06,1))*2
nSoma7 := val(subs(nNossoNum,07,1))*1
nSoma8 := val(subs(nNossoNum,08,1))*2
nSoma9 := val(subs(nNossoNum,09,1))*1
nSomaA := val(subs(nNossoNum,10,1))*2
nSomaB := val(subs(nNossoNum,11,1))*1
nSomaC := val(subs(nNossoNum,12,1))*2
nSomaD := val(subs(nNossoNum,13,1))*1
nSomaE := val(subs(nNossoNum,07,1))*2
nSomaF := val(subs(nNossoNum,08,1))*1
nSomaG := val(subs(nNossoNum,09,1))*2
nSomaH := val(subs(nNossoNum,10,1))*1
nSomaI := val(subs(nNossoNum,11,1))*2
nSomaJ := val(subs(nNossoNum,12,1))*1
nSomaK := val(subs(nNossoNum,13,1))*2
nResto := mod((nSoma1+nSoma2+nSoma3+nSoma4+nSoma5+nSoma6+nSoma7+;
	nSoma8+nSoma9+nSomaA+nSomaB+nSomaC+nSomaD+nSomaE+nSomaF+nSomaG;
	+nSomaH+nSomaI+nSomaJ+nSomaK),10)

cDigNN :=strzero(10-nResto,1)

Return (cDigNN)
*/
