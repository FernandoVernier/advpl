#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#include "rwmake.ch"

#DEFINE CRLF 	chr(13)+chr(10)

#DEFINE PLNP_UNIDADE	001
#DEFINE PLNP_CCUSTO		002
#DEFINE PANT_FERACUM	003
#DEFINE PANT_FERINSS	004
#DEFINE PANT_FERFGTS	005
#DEFINE PANT_DECACUM	006
#DEFINE PANT_DECINSS	007
#DEFINE PANT_DECFGTS 	008
#DEFINE PATU_FERACUM	009
#DEFINE PATU_FERINSS	010
#DEFINE PATU_FERFGTS	011
#DEFINE PATU_DECACUM	012
#DEFINE PATU_DECINSS	013
#DEFINE PATU_DECFGTS 	014
#DEFINE FOLH_FERACUM	015
#DEFINE FOLH_FERINSS	016
#DEFINE FOLH_FERFGTS	017
#DEFINE FOLH_DECACUM	018
#DEFINE FOLH_DECINSS	019
#DEFINE FOLH_DECFGTS 	020
#DEFINE RESU_FERACUM	021
#DEFINE RESU_FERINSS	022
#DEFINE RESU_FERFGTS	023
#DEFINE RESU_DECACUM	024
#DEFINE RESU_DECINSS	025
#DEFINE RESU_DECFGTS 	026


/*
+-----------------------------------------------------------------------+
|Programa  | IMPCTBFOL|Autor  |Fernando Vernier    | Data |  12/02/18   |
|----------+------------------------------------------------------------|
|Desc.     | Importação de Dados Contabeis do Sistema RM para Protheus  |
|          |                                                            |
|----------+------------------------------------------------------------|
|Uso       | Específico                                                 |
|          |                                                            |
+-----------------------------------------------------------------------+
*/
User Function ImpCtbFol()
	Private cPerg := PadR("IMPCFOL",10)
	Private oGeraTxt
	Private cLote := substr(dtos(dDatabase),1,6)
	

	AjustaSX1()
	If !Pergunte(cPerg)
		Return Nil
	Endif
	
	@ 200,1 TO 380,380 DIALOG oGeraTxt TITLE OemToAnsi("Integração RM - Protheus - " + Iif(MV_PAR03==1,'Folha','Impostos Folha'))
	@ 02,10 TO 080,190
	@ 10,018 Say " Integração dos Dados do Sistema RM Folha de "
	@ 18,018 Say " Pagamento, para o Sistema Contabil Protheus "
	@ 26,018 Say " Lote: "+cLote+" Data: "+dtoc(dDatabase)

	@ 70,128 BMPBUTTON TYPE 01 ACTION (_nOpc:=1,oGeraTxt:End())
	@ 70,158 BMPBUTTON TYPE 02 ACTION (_nOpc:=2,oGeraTxt:End())		

	Activate Dialog oGeraTxt Centered		
	If _nOpc = 1
		Processa({|| RunCont(MV_PAR01,MV_PAR02,MV_PAR03,(MV_PAR04==1),(MV_PAR05==1)) },"Gerando lancamentos contabeis...")
	Endif

Return

Static Function RunCont(nMes,nAno,nTipo,lItemContabil,lPreVisual)
Local aArea := GetArea()
Local dData := LastDay(CtoD('01/'+StrZero(nMes,2)+'/'+StrZero(nAno,4)))
Local aErro := {}

// Tratamento Datas Query Impostos

Set Century On

dDataAnter := LastDay(MonthSub(CtoD('01/'+StrZero(nMes,2)+'/'+StrZero(nAno,4)),1))
dDataAtual := LastDay(CtoD('01/'+StrZero(nMes,2)+'/'+StrZero(nAno,4)))

cDataAnter := StrZero(Month(FirstDate(dDataAnter)),2)+'/'+StrZero(Day(FirstDate(dDataAnter)),2)+'/'+Str(Year(FirstDate(dDataAnter)),4)
cDataAtual := StrZero(Month(FirstDate(dDataAtual)),2)+'/'+StrZero(Day(FirstDate(dDataAtual)),2)+'/'+Str(Year(FirstDate(dDataAtual)),4)

nMesAnt := Month(dDataAnter)
nAnoAnt := Year(dDataAnter)

If Empty(dData)
	MsgStop("Atenção Mes e Ano de Referencia Invalidos !")
	Return .f.
Endif

/*If dDataBase <> dData
	MsgStop("Atenção Data Base do Sistema Deve Ser o Ultimo Dia do Mês de Referência Escolhido, Mude Para " + DtoC(dData) + " !")
	Return .f.
Endif */

If nTipo==1	// Busca lancamentos da Folha de Funcionarios
	_cSql := " SELECT  DISTINCT CASE WHEN LEFT(Z3.Z3_CONTA,1) IN('1','2') THEN '' ELSE ISNULL(PCC.CODCCUSTO,'') END CODCCUSTO , "
	_cSql += "				PFFINAN.CODCOLIGADA,   "
	_cSql += "				PFUNC.CODSITUACAO,  "
	_cSql += "				PFFINAN.CHAPA,   "
	_cSql += "		        PFFINAN.CODEVENTO,   "
	_cSql += "		        Z3.Z3_CRES, "
	_cSql += "		        Z3.Z3_CONTA, "
	_cSql += "		        ISNULL((SELECT TOP 1 CTD_ITEM FROM " + RetSqlName("CTD") + " CTD WHERE CTD.CTD_DESC01 COLLATE DATABASE_DEFAULT = PFUNC.NOME COLLATE DATABASE_DEFAULT AND CTD.CTD_BLOQ <> '1' AND  CTD.CTD_ZCC COLLATE DATABASE_DEFAULT = PCC.CODCCUSTO COLLATE DATABASE_DEFAULT AND CTD.D_E_L_E_T_ = '' AND LEFT(Z3.Z3_CONTA,1) = '5'),'') CTD_ITEM," 
	_cSql += "		        PE.DESCRICAO,   "
	_cSql += "		        PFFINAN.ANOCOMP,   "
	_cSql += "		        PFFINAN.MESCOMP,   "
	_cSql += "		        CASE WHEN PE.PROVDESCBASE = 'D' AND Z3_CONTA <> '21030102' THEN PFFINAN.VALOR * -1  "
	_cSql += "					 WHEN PE.PROVDESCBASE = 'P' AND Z3_CONTA = '21030102' THEN PFFINAN.VALOR * -1  "
	_cSql += "		        ELSE PFFINAN.VALOR END VALOR,   "
	_cSql += "		        PFFINAN.REF,                      "
	_cSql += "		        PE.PROVDESCBASE,  "
	_cSql += "		        PFUNC.NOME NOME_FUNCIONARIO,  "
	_cSql += "		        PCC.NOME,  "
	_cSql += "		        PSECAO.CODIGO,  "
	_cSql += "		        PSECAO.DESCRICAO DESCRICAO_SECAO,  "
	_cSql += "		        (SELECT MAX(AHORA.DESCRICAO) FROM Corpore.dbo.PFHSTHOR PFHST, Corpore.dbo.AHORARIO AHORA  "
	_cSql += "					WHERE PFHST.CODCOLIGADA = AHORA.CODCOLIGADA  "
	_cSql += "		            AND PFHST.CODHORARIO = AHORA.CODIGO   "
	_cSql += "		            AND PFUNC.CODCOLIGADA = PFHST.CODCOLIGADA  "
	_cSql += "					AND PFUNC.CHAPA = PFHST.CHAPA  "
	_cSql += "					AND PFUNC.CODHORARIO = PFHST.CODHORARIO) AS HORARIO ,  "
	_cSql += "				PFFINAN.NROPERIODO, "
	_cSql += "				CASE "
	_cSql += "					WHEN SUBSTRING(PFUNC.CODSECAO,1,2) = '01' AND PFUNC.CODCOLIGADA = '01' THEN '01 - MATRIZ' "
	_cSql += "					WHEN SUBSTRING(PFUNC.CODSECAO,1,2) = '02' AND PFUNC.CODCOLIGADA = '01' THEN '02 - RECRIA' "
	_cSql += "					WHEN SUBSTRING(PFUNC.CODSECAO,1,2) = '04' AND PFUNC.CODCOLIGADA = '01' THEN '04 - UDI' "
	_cSql += "					WHEN SUBSTRING(PFUNC.CODSECAO,1,2) = '06' AND PFUNC.CODCOLIGADA = '01' THEN '06 - INDUSTRIA' "
	_cSql += "					WHEN SUBSTRING(PFUNC.CODSECAO,1,2) = '08' AND PFUNC.CODCOLIGADA = '01' THEN '07 - CONTAGEM' "
	_cSql += "					WHEN SUBSTRING(PFUNC.CODSECAO,1,2) = '01' AND PFUNC.CODCOLIGADA = '02' THEN 'SOMAI COMERCIAL' END  AS UNIDADE "
	_cSql += "		FROM Corpore.dbo.PFFINANC PFFINAN  "
	_cSql += "		    LEFT OUTER JOIN Corpore.dbo.PEVENTO PE ON (((PFFINAN.CODCOLIGADA = PE.CODCOLIGADA) AND (PFFINAN.CODEVENTO = PE.CODIGO)))           "
	_cSql += "		    LEFT OUTER JOIN Corpore.dbo.PFUNC PFUNC ON (((PFFINAN.CODCOLIGADA = PFUNC.CODCOLIGADA) AND (PFFINAN.CHAPA = PFUNC.CHAPA)))           "
	_cSql += "		    INNER JOIN Corpore.dbo.PSECAO PSECAO ON PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA  AND PSECAO.CODIGO = PFUNC.CODSECAO "
	_cSql += "		    LEFT JOIN Corpore.dbo.PFRATEIOFIXO PF ON PF.CODCOLIGADA = PFUNC.CODCOLIGADA AND PFUNC.CHAPA = PF.CHAPA AND PFFINAN.CHAPA = PF.CHAPA      "
	_cSql += "		    LEFT JOIN Corpore.dbo.PCCUSTO PCC ON  PF.CODCOLIGADA = PCC.CODCOLIGADA AND PF.CODCCUSTO = PCC.CODCCUSTO    "
	_cSql += "		    LEFT JOIN " + RetSqlName("CTT") + " CTT ON CTT.CTT_CUSTO COLLATE DATABASE_DEFAULT = PCC.CODCCUSTO COLLATE DATABASE_DEFAULT AND CTT.D_E_L_E_T_ = '' AND CTT.CTT_FILIAL = '" + xFilial("CTT") + "' "
	_cSql += "		    LEFT JOIN " + RetSqlName("SZ3") + "  Z3 ON Z3.Z3_COD COLLATE DATABASE_DEFAULT = PFFINAN.CODEVENTO COLLATE DATABASE_DEFAULT AND Z3.D_E_L_E_T_ = '' AND (LEFT(Z3.Z3_CONTA,1) = CTT.CTT_XTIPO OR LEFT(Z3.Z3_CONTA,1)='2' OR LEFT(Z3.Z3_CONTA,1)='1') AND Z3.Z3_FILIAL = '" + xFilial("SZ3") + "' "
	_cSql += "		    WHERE  PFFINAN.ANOCOMP = " + Str(nAno,4) + "  AND PFFINAN.MESCOMP = " + StrZero(nMes,2) + " AND PFFINAN.CODCOLIGADA IN (1,2,4,5,6)     "
	_cSql += "		    AND PE.PROVDESCBASE <> 'B' AND PFFINAN.NROPERIODO IN (1,2,3,4,5,6) "
	_cSql += "		    ORDER BY PFUNC.NOME "
    
	_cSql := ChangeQuery(_cSql)

	dbUseArea(.T.,"TOPCONN", TCGenQry(,,_cSql), "CT3QRY", .T., .T.)
	
	Count To nReg
	
	CT3QRY->(dbGoTop())
	
	nTotDebi := 0.00
	nTotCred := 0.00	
	aLcto := {}

	ProcRegua(nReg)
	While CT3QRY->(!Eof())
		IncProc("Processando Dados Contábeis...")                               
		
		If xFilial("CTT") == '02'
			If CT3QRY->UNIDADE <> '02 - RECRIA'
				CT3QRY->(dbSkip(1));Loop
			Endif
		ElseIf xFilial("CTT") == '01'
			If !AllTrim(CT3QRY->UNIDADE) $ '01 - MATRIZ'
				CT3QRY->(dbSkip(1));Loop
			Endif
		ElseIf xFilial("CTT") == '04'
			If CT3QRY->UNIDADE <> '04 - UDI'
				CT3QRY->(dbSkip(1));Loop
			Endif
		ElseIf xFilial("CTT") == '06'
			If CT3QRY->UNIDADE <> '06 - INDUSTRIA'
				CT3QRY->(dbSkip(1));Loop
			Endif
		ElseIf xFilial("CTT") == '07'
			If CT3QRY->UNIDADE <> '07 - CONTAGEM'
				CT3QRY->(dbSkip(1));Loop
			Endif
		ElseIf xFilial("CTT") == '08'
			If !AllTrim(CT3QRY->UNIDADE) $ 'SOMAI COMERCIAL'
				CT3QRY->(dbSkip(1));Loop
			Endif
		Endif
		
		If Empty(CT3QRY->Z3_CONTA)
			If Ascan(aErro,'Evento ' + CT3QRY->CODEVENTO + " Não Localizou Conta Contabil, Verificar Tabela Eventos x Contas !") == 0
				AAdd(aErro,'Evento ' + CT3QRY->CODEVENTO + " Não Localizou Conta Contabil, Verificar Tabela Eventos x Contas !")
			Endif
		Endif
		
		nAchou := Ascan(aLcto,{|x| x[1]+x[2]+x[3] == CT3QRY->CODCCUSTO+CT3QRY->Z3_CONTA+Iif(lItemContabil,CT3QRY->CTD_ITEM,'') })
		
		If Empty(nAchou)
			AAdd(aLcto,{CT3QRY->CODCCUSTO,;
						CT3QRY->Z3_CONTA,;
						Iif(lItemContabil .And. AllTrim(CT3QRY->CODCCUSTO)$'455',Iif(!Empty(CT3QRY->CTD_ITEM),CT3QRY->CTD_ITEM,'VEND000'),''),;
						CT3QRY->VALOR})
		Else
			aLcto[nAchou,4] += CT3QRY->VALOR
		Endif
		
		cTpLcto := Iif(CT3QRY->VALOR<0.00, 'C', 'D')
			
		If cTpLcto=='C'
			nTotCred += (CT3QRY->VALOR * -1)
		Else
			nTotDebi += CT3QRY->VALOR
		Endif					    
	
		CT3QRY->(dbSkip(1))
	Enddo
	CT3QRY->(dbCloseArea())
	
	aLcto := aSort(aLcto,,, { |x, y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] })	
	
	If StrZero(nTotCred,16,2) <> StrZero(nTotDebi,16,2)
		AAdd(aErro,'Diferença Total Credito x Débito ==> Credito ' + TransForm(nTotCred,'@E 9,999,999,999.99') + " Débito " + TransForm(nTotDebi,'@E 9,999,999,999.99') + " !")
	Endif

	// Se Houver Erro Entao Nao Processa
	
	If Len(aErro) > 0
		cTxt := ''
		For nErro := 1 To Len(aErro)
			cTxt += aErro[nErro]+CRLF
		Next
	
		Aviso("Error Log","Erros Encontrados Durante o Processamento: "+CRLF+cTxt,{"Ok"},3)	
	Endif
	
	
	// Pre Visualizacao
	
	If lPreVisual
    	aPreVisual := {}
		aItens := {}
		For nLc := 1 To Len(aLcto)
			cCustos	:=	aLcto[nLc,1]
			cConta  :=  Iif(!Empty(aLcto[nLc,2]),aLcto[nLc,2],'E R R O')
			cItem	:=	aLcto[nLc,3]
			nValor  :=  aLcto[nLc,4]                             
			
			If Empty(nValor)	// Valores zerados não são lançados.
				Loop
			Endif
			
			cHisto  :=	'FOLHA DE PAGAMENTO ' + Upper(MesExtenso(dData)) + " " + Str(nAno,4)
			cTpLcto := Iif(nValor<0.00, 'C', 'D')
			
			If !lItemContabil
				AAdd(aPreVisual,{StrZero(nLc,3),;
									'01',;
									iif(cTpLcto=='C','2','1'),;
					     			iif(cTpLcto=='D',cConta,''),;
					     			iif(cTpLcto=='C',cConta,''),;
					     			iif(cTpLcto=='C',nValor * -1,nValor),;
					     			iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='D',cCustos,''),;
					     			iif(cTpLcto=='C',cCustos,''),;
					     			cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0),;
					     			cHisto})
			Else
				AAdd(aPreVisual,{StrZero(nLc,3),;
									'01',;
									iif(cTpLcto=='C','2','1'),;
					     			iif(cTpLcto=='D',cConta,''),;
					     			iif(cTpLcto=='C',cConta,''),;
					     			iif(cTpLcto=='C',nValor * -1,nValor),;
					     			iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='D',cCustos,''),;
					     			iif(cTpLcto=='C',cCustos,''),;
					     			iif(cTpLcto=='D',cItem,''),;
					     			iif(cTpLcto=='C',cItem,''),;
					     			cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0),;
					     			cHisto})
			Endif
		Next                                                    
		
		@ 001,001 TO 400,1200 DIALOG oDlgDeta TITLE 'Pré-Visualizacao de Lançamentos Contábeis'
			                                                                                   
		If !lItemContabil			
			@ 001, 001 LISTBOX oDetalhes Fields HEADER 'Linha','Moeda','Tipo Lcto','Conta Débito','Conta Crédito','Valor','Dig D','Dig C','C.Custos Deb','C.Custos Cred','Historico','Origem' SIZE 600, 160 OF oDlgDeta PIXEL 
		Else
			@ 001, 001 LISTBOX oDetalhes Fields HEADER 'Linha','Moeda','Tipo Lcto','Conta Débito','Conta Crédito','Valor','Dig D','Dig C','C.Custos Deb','C.Custos Cred','Item Debito','Item Credito','Historico','Origem' SIZE 600, 160 OF oDlgDeta PIXEL 
		Endif
			
		oDetalhes:SetArray(aPreVisual)
		
		If !lItemContabil			
			oDetalhes:bLine := {|| {	aPreVisual[oDetalhes:nAt,1],;
									    aPreVisual[oDetalhes:nAt,2],;
									    aPreVisual[oDetalhes:nAt,3],;
									    aPreVisual[oDetalhes:nAt,4],;
									    aPreVisual[oDetalhes:nAt,5],;
									    TransForm(aPreVisual[oDetalhes:nAt,6],'@E 9,999,999,999.99'),;
									    aPreVisual[oDetalhes:nAt,7],;
									    aPreVisual[oDetalhes:nAt,8],;
									    aPreVisual[oDetalhes:nAt,9],;
									    aPreVisual[oDetalhes:nAt,10],;
									    aPreVisual[oDetalhes:nAt,12],;
									    aPreVisual[oDetalhes:nAt,11]}}
		Else
			oDetalhes:bLine := {|| {	aPreVisual[oDetalhes:nAt,1],;
									    aPreVisual[oDetalhes:nAt,2],;
									    aPreVisual[oDetalhes:nAt,3],;
									    aPreVisual[oDetalhes:nAt,4],;
									    aPreVisual[oDetalhes:nAt,5],;
									    TransForm(aPreVisual[oDetalhes:nAt,6],'@E 9,999,999,999.99'),;
									    aPreVisual[oDetalhes:nAt,7],;
									    aPreVisual[oDetalhes:nAt,8],;
									    aPreVisual[oDetalhes:nAt,9],;
									    aPreVisual[oDetalhes:nAt,10],;
									    aPreVisual[oDetalhes:nAt,11],;
									    aPreVisual[oDetalhes:nAt,12],;
									    aPreVisual[oDetalhes:nAt,14],;
									    aPreVisual[oDetalhes:nAt,13]}}
		Endif
	
		@ 170,120 SAY "Total Debito:"   SIZE 80,10 COLOR CLR_BLUE,CLR_WHITE 
		@ 170,180 SAY oRmMarD VAR nTotDebi Picture '@E 9,999,999,999.99' SIZE 100,15 COLOR CLR_RED,CLR_WHITE  OF oDlgDeta PIXEL 
		oRmMarD:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)
			
		@ 180,120 SAY "Total Credito:"   SIZE 80,10 COLOR CLR_BLUE,CLR_WHITE 
		@ 180,180 SAY oRmMarC VAR nTotCred Picture '@E 9,999,999,999.99' SIZE 100,15 COLOR CLR_BLUE,CLR_WHITE  OF oDlgDeta PIXEL 
		oRmMarC:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)
		
		nOpc := 0

		If Empty(Len(aErro))
			@ 180,300 BUTTON "Continua"				SIZE 50,15 ACTION (nOpc:=1,Close(oDlgDeta))
		Else     
			cErro := "Foram Encontrados Erros, Impossível Efetuar Contabilização"   
			
			@ 165,300 SAY oErro VAR cErro SIZE 300,10 COLOR CLR_RED,CLR_WHITE OF oDlgDeta PIXEL 
			
			oErro:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)
			
			@ 180,350 BUTTON "_Excel"          		SIZE 50,15 ACTION Processa({|| PlnXls(lItemContabil) })
			
		Endif

		@ 180,400 BUTTON "_Sair"          		SIZE 50,15 ACTION (nOpc:=0,Close(oDlgDeta))
				
		ACTIVATE DIALOG oDlgDeta CENTERED
		
		If nOpc <> 1
			Return .f.
		Endif     
	Endif
	
	aCab:= {{"dDataLanc",dDatabase		,NIL},;
			{"cLote"	,cLote			,NIL},;
			{"cSubLote"	,"001"			,NIL}}
	
	aItens := {}
	For nLc := 1 To Len(aLcto)
		cCustos	:=	aLcto[nLc,1]
		cConta  :=  aLcto[nLc,2]
		cItem	:=	aLcto[nLc,3]
		nValor  :=  aLcto[nLc,4]                             
		
		If Empty(nValor)	// Valores zerados não são lançados.
			Loop
		Endif
		
		cHisto  :=	'FOLHA DE PAGAMENTO ' + Upper(MesExtenso(dData)) + " " + Str(nAno,4)
		
		cTpLcto := Iif(nValor<0.00, 'C', 'D')

		If !lItemContabil
			aAdd(aItens,{{"CT2_FILIAL"	,xFilial("CT2")										,NIL},;
						{"CT2_LINHA"	,StrZero(nLc,3)										,NIL},;		
						{"CT2_MOEDLC"	,"01"												,NIL},;
				     	{"CT2_DC"		,iif(cTpLcto=='C','2','1')							,NIL},;
				     	{"CT2_DEBITO"	,iif(cTpLcto=='D',cConta,'')			 			,NIL},;
				     	{"CT2_CREDIT"	,iif(cTpLcto=='C',cConta,'')			 			,NIL},;
				     	{"CT2_VALOR"	,iif(cTpLcto=='C',nValor * -1,nValor)				,NIL},;
						{"CT2_DCD"		,iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
						{"CT2_DCC"		,iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
				     	{"CT2_CCD"		,iif(cTpLcto=='D',cCustos,'')			 			,NIL},;
				     	{"CT2_CCC"		,iif(cTpLcto=='C',cCustos,'')						,NIL},;
				     	{"CT2_ORIGEM"	,cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0)		,NIL},;
				     	{"CT2_HIST"		,cHisto												,NIL}})
		Else
			aAdd(aItens,{{"CT2_FILIAL"	,xFilial("CT2")										,NIL},;
						{"CT2_LINHA"	,StrZero(nLc,3)										,NIL},;		
						{"CT2_MOEDLC"	,"01"												,NIL},;
				     	{"CT2_DC"		,iif(cTpLcto=='C','2','1')							,NIL},;
				     	{"CT2_DEBITO"	,iif(cTpLcto=='D',cConta,'')			 			,NIL},;
				     	{"CT2_CREDIT"	,iif(cTpLcto=='C',cConta,'')			 			,NIL},;
				     	{"CT2_VALOR"	,iif(cTpLcto=='C',nValor * -1,nValor)				,NIL},;
						{"CT2_DCD"		,iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
						{"CT2_DCC"		,iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
				     	{"CT2_CCD"		,iif(cTpLcto=='D',cCustos,'')			 			,NIL},;
				     	{"CT2_CCC"		,iif(cTpLcto=='C',cCustos,'')						,NIL},;
				     	{"CT2_ITEMD"	,iif(cTpLcto=='D',cItem,'')				 			,NIL},;
				     	{"CT2_ITEMC"	,iif(cTpLcto=='C',cItem,'')							,NIL},;
				     	{"CT2_ORIGEM"	,cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0)		,NIL},;
				     	{"CT2_HIST"		,cHisto												,NIL}})
		Endif
	Next

		// inclusao
	lMsErroAuto := .F.
	BEGIN TRANSACTION
	MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)},aCab,aItens,3)
	If lMsErroAuto
		MostraErro()
		DisarmTransaction()
		Return .F.
	Endif
	END TRANSACTION

ElseIf nTipo == 2 // Lancamento de impostos

	// Processa Mes Anterior

	_cSql := " SELECT A.CHAPA, A.NOME, A.CODCCUSTO, A.DESCCC, A.CODSECAO, A.CODCOLIGADA, " + CRLF
	_cSql += "				ROUND(A.FERIAS_ACUMULADO,2) FERIAS_ACUMULADO, A.AVOS,ROUND((A.FERIAS_ACUMULADO) * 0.282,2) INSSACUM, ROUND((A.FERIAS_ACUMULADO) * 0.08,2) FGTSACUM, " + CRLF
	_cSql += "				ROUND(A.FERIAS_MENSAL,2) FERIAS_MENSAL, ROUND((A.FERIAS_MENSAL),2) INSSMENSAL, ROUND((A.FERIAS_MENSAL ),2) FGTSACUMMENSAL, " + CRLF
	_cSql += "				ROUND(A.ACUMULADO_V13,2) ACUMULADO_V13, ROUND((A.ACUMULADO_V13) * 0.282,2) INSS13ACUM, ROUND((A.ACUMULADO_V13) * 0.08,2) FGTS13ACUM, " + CRLF
	_cSql += "				ROUND(A.V13_MES,2) V13_MES, ROUND((A.V13_MES ),2) INSS13MENSAL, ROUND((A.V13_MES ),2) FGTS13MENSAL, A.NROAVOS13DEC " + CRLF
	_cSql += "				FROM (  SELECT " + CRLF
	_cSql += "				            PFUNC.CHAPA, "  + CRLF
	_cSql += "				            PFUNC.NOME, " + CRLF
	_cSql += "				            PFUNC.CODSECAO, "  + CRLF
	_cSql += "				            PFUNC.CODCOLIGADA, " + CRLF
	_cSql += "				            PCC.CODCCUSTO, " + CRLF
	_cSql += "				            PCC.NOME DESCCC, " + CRLF
	_cSql += "				            CASE  WHEN PFUNC.CODOCORRENCIA IN (2, 6) THEN '06' " + CRLF
	_cSql += "				                  WHEN PFUNC.CODOCORRENCIA IN (3, 7) THEN 9 " + CRLF
	_cSql += "				                  WHEN PFUNC.CODOCORRENCIA IN (4, 8) THEN 6 " + CRLF
	_cSql += "				                  ELSE 0 " + CRLF
	_cSql += "				            END AS 'ACRESCIMO_INSS', " + CRLF
	_cSql += "				            PFH1.VALPROVFER AS 'FERIAS_ACUMULADO', " + CRLF
	_cSql += "				            CASE  WHEN PFH1.VALPROVFER > PFH2.VALPROVFER " + CRLF
	_cSql += "				                  THEN PFH1.VALPROVFER - isnull (PFH2.VALPROVFER,0) " + CRLF
	_cSql += "				                  ELSE (PFH1.VALPROVSEMABATFER - PFH2.VALPROVCOMABATFER ) " + CRLF
	_cSql += "				            END AS 'FERIAS_MENSAL', " + CRLF
	_cSql += "				            (PFH1.NROAVOSVENCFERDEC + PFH1.NROAVOSPROPORCDEC) AS 'AVOS', " + CRLF
	_cSql += "				            ( " + CRLF
	_cSql += "				            PFH1.VALPROV13 - ISNULL( " + CRLF
	_cSql += "				                        ( " + CRLF
	_cSql += "				                        SELECT SUM(F.VALOR) " + CRLF
	_cSql += "				                              FROM  Corpore.dbo.PEVENTO E, " + CRLF
	_cSql += "				                                   Corpore.dbo.PFFINANC F " + CRLF
	_cSql += "				                              WHERE F.CODCOLIGADA = E.CODCOLIGADA " + CRLF
	_cSql += "				                              AND   F.CODEVENTO = E.CODIGO " + CRLF
	_cSql += "				                              AND   F.CODCOLIGADA = PFUNC.CODCOLIGADA " + CRLF
	_cSql += "				                              AND   F.CHAPA     = PFUNC.CHAPA " + CRLF
	_cSql += "				                              AND   E.CODIGOCALCULO   = 9 " + CRLF
	_cSql += "				                              AND   F.MESCOMP <= '" + StrZero(nMesAnt,2) + "' " + CRLF
	_cSql += "				                              AND   F.ANOCOMP = PFH1.ANO " + CRLF
	_cSql += "				                        ), 0 ) " + CRLF
	_cSql += "				            ) AS 'ACUMULADO_V13', " + CRLF
	_cSql += "				            CASE  WHEN PFH1.VALPROV13 > PFH2.VALPROV13  " + CRLF
	_cSql += "				                  THEN (PFH1.VALPROV13 - PFH2.VALPROV13) " + CRLF
	_cSql += "				                        WHEN PFH1.NROAVOS13DEC=0 " + CRLF
	_cSql += "				                        THEN 0 " + CRLF
	_cSql += "				                        WHEN PFH1.VALPROV13 < PFH2.VALPROV13 " + CRLF
	_cSql += "				                  THEN PFH1.VALPROV13 / PFH1.NROAVOS13DEC " + CRLF
	_cSql += "				            END AS 'V13_MES', " + CRLF
	_cSql += "				            PFH1.NROAVOS13DEC, " + CRLF
	_cSql += "				            PFH1.VALPROV13 " + CRLF
	_cSql += "				            FROM  Corpore.dbo.PFUNC PFUNC " + CRLF
	_cSql += "				                  LEFT JOIN Corpore.dbo.PFRATEIOFIXO PF ON PFUNC.CHAPA = PF.CHAPA AND PFUNC.CODCOLIGADA = PF.CODCOLIGADA " + CRLF
	_cSql += "				                  LEFT JOIN Corpore.dbo.PCCUSTO PCC ON PF.CODCCUSTO = PCC.CODCCUSTO " + CRLF
	_cSql += "				                  LEFT OUTER JOIN Corpore.dbo.PFHSTPROV PFH1(NOLOCK) ON PFH1.CODCOLIGADA = PFUNC.CODCOLIGADA       AND PFH1.CHAPA = PFUNC.CHAPA " + CRLF
	_cSql += "				                  LEFT OUTER JOIN Corpore.dbo.PFHSTPROV PFH2(NOLOCK) ON PFH2.CODCOLIGADA = PFH1.CODCOLIGADA  AND PFH2.CHAPA = PFH1.CHAPA " + CRLF
	_cSql += "				                  AND PFH2.MES = (CASE    WHEN PFH1.MES=1 "  + CRLF
	_cSql += "				                                   THEN '" + StrZero(nMesAnt,2) + "' " + CRLF
	_cSql += "				                                   WHEN  ( " + CRLF
	_cSql += "				                                         SELECT COUNT(*) " + CRLF
	_cSql += "				                                         FROM  Corpore.dbo.PFHSTPROV PFH11 " + CRLF
	_cSql += "				                                         WHERE PFH11.CHAPA = PFUNC.CHAPA " + CRLF
	_cSql += "				                                         AND   PFH11.CODCOLIGADA = PFUNC.CODCOLIGADA " + CRLF
	_cSql += "				                                         ) = 1 " + CRLF
	_cSql += "				                                   THEN  PFH1.MES " + CRLF
	_cSql += "				                                   ELSE  PFH1.MES-1 " + CRLF
	_cSql += "				                              END) " + CRLF
	_cSql += "				                  AND   PFH2.ANO =  (CASE WHEN PFH1.MES <> 1 " + CRLF
	_cSql += "				                                         THEN PFH1.ANO " + CRLF
	_cSql += "				                                         ELSE  CASE WHEN   ( " + CRLF
	_cSql += "				                                                           SELECT COUNT (*)  " + CRLF
	_cSql += "				                                                           FROM  Corpore.dbo.PFHSTPROV PFV" + CRLF
	_cSql += "				                                                           WHERE PFV.CHAPA=PFUNC.CHAPA " + CRLF
	_cSql += "				                                                           AND   PFV.CODCOLIGADA = PFUNC.CODCOLIGADA) = 1 " + CRLF
	_cSql += "				                                                     THEN PFH1.ANO " + CRLF
	_cSql += "				                                                     ELSE PFH1.ANO-1 " + CRLF
	_cSql += "				                                               END " + CRLF
	_cSql += "				                                   END) " + CRLF
	_cSql += "				            WHERE PFH1.MES = '" + StrZero(nMesAnt,2) + "' " + CRLF
	_cSql += "				            AND   PFH1.ANO = " + StrZero(nAnoAnt,4) + CRLF
	_cSql += "				            AND   PFUNC.CODSECAO IN (SELECT CODIGO FROM Corpore.dbo.PSECAO) " + CRLF
	_cSql += "				            AND   PFUNC.CODCOLIGADA IN (1,2)  AND SUBSTRING(PFUNC.CODSECAO,1,2) = CASE WHEN  '"+xFilial("CTT")+"' = '07' THEN '08' ELSE '"+xFilial("CTT")+"' END " 	 + CRLF
	//_cSql += "				            AND   PFUNC.CODCOLIGADA ='" + xFilial("CTT") + "' "	 + CRLF
	//_cSql += "				            AND     DATEDIFF(DAY, PFUNC.DATAADMISSAO, DATEADD(DAY, -1, CONVERT(DATETIME, (DATEADD(MONTH, 1,  '" + cDataAnter + "'))))) > 31 " + CRLF
	_cSql += "				            AND   (case " + CRLF
	_cSql += "				                  when dttransferencia is null " + CRLF
	_cSql += "				                  THEN '1' " + CRLF
	_cSql += "				                  Else " + CRLF
	_cSql += "				                        CASE " + CRLF
	_cSql += "				                              WHEN dttransferencia < CONVERT (DATETIME, (CONVERT (VARCHAR,  '" + DtoC(dDataAnter) + "')),103) " + CRLF
	_cSql += "				                              then '1' " + CRLF
	_cSql += "				                              ELSE '0' " + CRLF
	_cSql += "				                        END " + CRLF
	_cSql += "				            END) = 1   " + CRLF
	_cSql += "				            AND (case " + CRLF
	_cSql += "				                  when datademissao is null " + CRLF
	_cSql += "				                  THEN '1' " + CRLF
	_cSql += "				                  Else " + CRLF
	_cSql += "				                        CASE " + CRLF
	_cSql += "				                              WHEN datademissao > CONVERT (DATETIME, (CONVERT (VARCHAR,   '" + DtoC(dDataAnter) + "')),103) " + CRLF
	_cSql += "				                              then '1' " + CRLF
	_cSql += "				                              ELSE '0' " + CRLF
	_cSql += "				                        END " + CRLF
	_cSql += "				            END) = 1 " + CRLF
	_cSql += "				           " + CRLF
	_cSql += "				) A " + CRLF
	_cSql += "ORDER BY CODCCUSTO " + CRLF

	_cSql := ChangeQuery(_cSql)

	dbUseArea(.T.,"TOPCONN", TCGenQry(,,_cSql), 'CT3QRY', .T., .T.)
	
	Count To nReg
	
	CT3QRY->(dbGoTop())

	aProvisoes := {}

	ProcRegua(nReg)
	While CT3QRY->(!Eof())
		IncProc("Pre Processamento de Impostos...")
		
		nAchou := Ascan(aProvisoes,{|X| X[PLNP_UNIDADE]==Left(CT3QRY->CODSECAO,2) .And. X[PLNP_CCUSTO]==CT3QRY->CODCCUSTO })
		If Empty(nAchou)
			AAdd(aProvisoes,{Left(CT3QRY->CODSECAO,2),;
							CT3QRY->CODCCUSTO,;
							CT3QRY->FERIAS_ACUMULADO,;
							CT3QRY->INSSACUM,;
							CT3QRY->FGTSACUM,;
							CT3QRY->ACUMULADO_V13,;
							CT3QRY->INSS13ACUM,;
							CT3QRY->FGTS13ACUM,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0})
		Else
				aProvisoes[nAchou,PANT_FERACUM] += CT3QRY->FERIAS_ACUMULADO
				aProvisoes[nAchou,PANT_FERINSS] += CT3QRY->INSSACUM
				aProvisoes[nAchou,PANT_FERFGTS] += CT3QRY->FGTSACUM
				aProvisoes[nAchou,PANT_DECACUM] += CT3QRY->ACUMULADO_V13
				aProvisoes[nAchou,PANT_DECINSS] += CT3QRY->INSS13ACUM
				aProvisoes[nAchou,PANT_DECFGTS] += CT3QRY->FGTS13ACUM
		Endif		

		CT3QRY->(dbSkip(1))
	Enddo		
	CT3QRY->(dbCloseArea())

	// Processa Mes Atual

	_cSql := " SELECT A.CHAPA, A.NOME, A.CODCCUSTO, A.DESCCC, A.CODSECAO, A.CODCOLIGADA, " + CRLF
	_cSql += "				ROUND(A.FERIAS_ACUMULADO,2) FERIAS_ACUMULADO, A.AVOS,ROUND((A.FERIAS_ACUMULADO) * 0.282,2) INSSACUM, ROUND((A.FERIAS_ACUMULADO) * 0.08,2) FGTSACUM, " + CRLF
	_cSql += "				ROUND(A.FERIAS_MENSAL,2) FERIAS_MENSAL, ROUND((A.FERIAS_MENSAL),2) INSSMENSAL, ROUND((A.FERIAS_MENSAL ),2) FGTSACUMMENSAL, " + CRLF
	_cSql += "				ROUND(A.ACUMULADO_V13,2) ACUMULADO_V13, ROUND((A.ACUMULADO_V13) * 0.282,2) INSS13ACUM, ROUND((A.ACUMULADO_V13) * 0.08,2) FGTS13ACUM, " + CRLF
	_cSql += "				ROUND(A.V13_MES,2) V13_MES, ROUND((A.V13_MES ),2) INSS13MENSAL, ROUND((A.V13_MES ),2) FGTS13MENSAL, A.NROAVOS13DEC " + CRLF
	_cSql += "				FROM ( "
	_cSql += "				            SELECT "
	_cSql += "				            PFUNC.CHAPA, "
	_cSql += "				            PFUNC.NOME, "
	_cSql += "				            PFUNC.CODSECAO, "  
	_cSql += "				            PFUNC.CODCOLIGADA, "
	_cSql += "				            PCC.CODCCUSTO, "
	_cSql += "				            PCC.NOME DESCCC, "
	_cSql += "				            CASE  WHEN PFUNC.CODOCORRENCIA IN (2, 6) THEN '06' "
	_cSql += "				                  WHEN PFUNC.CODOCORRENCIA IN (3, 7) THEN 9 "
	_cSql += "				                  WHEN PFUNC.CODOCORRENCIA IN (4, 8) THEN 6 "
	_cSql += "				                  ELSE 0 "
	_cSql += "				            END AS 'ACRESCIMO_INSS', "
	_cSql += "				            PFH1.VALPROVFER AS 'FERIAS_ACUMULADO', "
	_cSql += "				            CASE  WHEN PFH1.VALPROVFER > PFH2.VALPROVFER "
	_cSql += "				                  THEN PFH1.VALPROVFER - isnull (PFH2.VALPROVFER,0) "
	_cSql += "				                  ELSE (PFH1.VALPROVSEMABATFER - PFH2.VALPROVCOMABATFER ) "
	_cSql += "				            END AS 'FERIAS_MENSAL', "
	_cSql += "				            (PFH1.NROAVOSVENCFERDEC + PFH1.NROAVOSPROPORCDEC) AS 'AVOS', "
	_cSql += "				            ( "
	_cSql += "				            PFH1.VALPROV13 - ISNULL( "
	_cSql += "				                        ( "
	_cSql += "				                        SELECT SUM(F.VALOR) "
	_cSql += "				                              FROM  Corpore.dbo.PEVENTO E, "
	_cSql += "				                                   Corpore.dbo.PFFINANC F "
	_cSql += "				                              WHERE F.CODCOLIGADA = E.CODCOLIGADA "
	_cSql += "				                              AND   F.CODEVENTO = E.CODIGO "
	_cSql += "				                              AND   F.CODCOLIGADA = PFUNC.CODCOLIGADA "
	_cSql += "				                              AND   F.CHAPA     = PFUNC.CHAPA "
	_cSql += "				                              AND   E.CODIGOCALCULO   = 9 "
	_cSql += "				                              AND   F.MESCOMP <= '" + StrZero(nMes,2) + "' "
	_cSql += "				                              AND   F.ANOCOMP = PFH1.ANO "
	_cSql += "				                        ), 0 ) "
	_cSql += "				            ) AS 'ACUMULADO_V13', "
	_cSql += "				            CASE  WHEN PFH1.VALPROV13 > PFH2.VALPROV13 "
	_cSql += "				                  THEN (PFH1.VALPROV13 - PFH2.VALPROV13) "
	_cSql += "				                        WHEN PFH1.NROAVOS13DEC=0 "
	_cSql += "				                        THEN 0 "
	_cSql += "				                        WHEN PFH1.VALPROV13 < PFH2.VALPROV13 "
	_cSql += "				                  THEN PFH1.VALPROV13 / PFH1.NROAVOS13DEC "
	_cSql += "				            END AS 'V13_MES', "
	_cSql += "				            PFH1.NROAVOS13DEC, "
	_cSql += "				            PFH1.VALPROV13 "      
	_cSql += "				            FROM  Corpore.dbo.PFUNC PFUNC "
	_cSql += "				                  LEFT JOIN Corpore.dbo.PFRATEIOFIXO PF ON PFUNC.CHAPA = PF.CHAPA AND PFUNC.CODCOLIGADA = PF.CODCOLIGADA  "
	_cSql += "				                  LEFT JOIN Corpore.dbo.PCCUSTO PCC ON PF.CODCCUSTO = PCC.CODCCUSTO "
	_cSql += "				                  LEFT OUTER JOIN Corpore.dbo.PFHSTPROV PFH1(NOLOCK) ON PFH1.CODCOLIGADA = PFUNC.CODCOLIGADA       AND PFH1.CHAPA = PFUNC.CHAPA "
	_cSql += "				                  LEFT OUTER JOIN Corpore.dbo.PFHSTPROV PFH2(NOLOCK) ON PFH2.CODCOLIGADA = PFH1.CODCOLIGADA  AND PFH2.CHAPA = PFH1.CHAPA "
	_cSql += "				                  AND PFH2.MES = (CASE    WHEN PFH1.MES=1 "
	_cSql += "				                                   THEN '" + StrZero(nMes,2) + "'  "
	_cSql += "				                                   WHEN  ( "
	_cSql += "				                                         SELECT COUNT(*)  "
	_cSql += "				                                         FROM  Corpore.dbo.PFHSTPROV PFH11 "
	_cSql += "				                                         WHERE PFH11.CHAPA = PFUNC.CHAPA "
	_cSql += "				                                         AND   PFH11.CODCOLIGADA = PFUNC.CODCOLIGADA "
	_cSql += "				                                         ) = 1 "
	_cSql += "				                                   THEN  PFH1.MES "
	_cSql += "				                                   ELSE  PFH1.MES-1 "
	_cSql += "				                              END) "
	_cSql += "				                  AND   PFH2.ANO =  (CASE WHEN PFH1.MES <> 1 "
	_cSql += "				                                         THEN PFH1.ANO "
	_cSql += "				                                         ELSE  CASE WHEN   ( "
	_cSql += "				                                                           SELECT COUNT (*) "
	_cSql += "				                                                           FROM  Corpore.dbo.PFHSTPROV PFV "
	_cSql += "				                                                           WHERE PFV.CHAPA=PFUNC.CHAPA "
	_cSql += "				                                                           AND   PFV.CODCOLIGADA = PFUNC.CODCOLIGADA) = 1 "
	_cSql += "				                                                     THEN PFH1.ANO "
	_cSql += "				                                                     ELSE PFH1.ANO-1 "
	_cSql += "				                                               END "
	_cSql += "				                                   END) "
	_cSql += "				            WHERE PFH1.MES = '" + StrZero(nMes,2) + "' "
	_cSql += "				            AND   PFH1.ANO = " + StrZero(nAno,4)
	_cSql += "				            AND   PFUNC.CODSECAO IN (SELECT CODIGO FROM Corpore.dbo.PSECAO) "
	_cSql += "				            AND   PFUNC.CODCOLIGADA IN (1,2)  AND SUBSTRING(PFUNC.CODSECAO,1,2) = CASE WHEN  '"+xFilial("CTT")+"' = '07' THEN '08' ELSE '"+xFilial("CTT")+"' END " 	 + CRLF
	//_cSql += "				            AND   PFUNC.CODCOLIGADA ='" + xFilial("CTT") + "' "	
	//_cSql += "				            AND     DATEDIFF(DAY, PFUNC.DATAADMISSAO, DATEADD(DAY, -1, CONVERT(DATETIME, (DATEADD(MONTH, 1,  '" + cDataAtual + "'))))) > 31 "
	_cSql += "				            AND   (case "
	_cSql += "				                  when dttransferencia is null "
	_cSql += "				                  THEN '1' "
	_cSql += "				                  Else "
	_cSql += "				                        CASE "
	_cSql += "				                              WHEN dttransferencia < CONVERT (DATETIME, (CONVERT (VARCHAR,  '" + DtoC(dDataAtual) + "')),103) "
	_cSql += "				                              then '1' "
	_cSql += "				                              ELSE '0' "
	_cSql += "				                        END "
	_cSql += "				            END) = 1   "
	_cSql += "				            AND (case "
	_cSql += "				                  when datademissao is null "
	_cSql += "				                  THEN '1' "
	_cSql += "				                  Else "
	_cSql += "				                        CASE "
	_cSql += "				                              WHEN datademissao > CONVERT (DATETIME, (CONVERT (VARCHAR,   '" + DtoC(dDataAtual) + "')),103) "
	_cSql += "				                              then '1' "
	_cSql += "				                              ELSE '0' "
	_cSql += "				                        END "
	_cSql += "				            END) = 1 "
	_cSql += "				           "
	_cSql += "				) A "
	_cSql += "ORDER BY CODCCUSTO "
    
	_cSql := ChangeQuery(_cSql)

	dbUseArea(.T.,"TOPCONN", TCGenQry(,,_cSql), 'CT3QRY', .T., .T.)
	
	Count To nReg
	
	CT3QRY->(dbGoTop())

	ProcRegua(nReg)
	While CT3QRY->(!Eof())
		IncProc("Pre Processamento de Impostos...")
		
		nAchou := Ascan(aProvisoes,{|X| X[PLNP_UNIDADE]==Left(CT3QRY->CODSECAO,2) .And. X[PLNP_CCUSTO]==CT3QRY->CODCCUSTO })
		If Empty(nAchou)
			AAdd(aProvisoes,{Left(CT3QRY->CODSECAO,2),;
							CT3QRY->CODCCUSTO,;      
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							CT3QRY->FERIAS_ACUMULADO,;
							CT3QRY->INSSACUM,;
							CT3QRY->FGTSACUM,;
							CT3QRY->ACUMULADO_V13,;
							CT3QRY->INSS13ACUM,;
							CT3QRY->FGTS13ACUM,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							0})
		Else
				aProvisoes[nAchou,PATU_FERACUM] += CT3QRY->FERIAS_ACUMULADO
				aProvisoes[nAchou,PATU_FERINSS] += CT3QRY->INSSACUM
				aProvisoes[nAchou,PATU_FERFGTS] += CT3QRY->FGTSACUM
				aProvisoes[nAchou,PATU_DECACUM] += CT3QRY->ACUMULADO_V13
				aProvisoes[nAchou,PATU_DECINSS] += CT3QRY->INSS13ACUM
				aProvisoes[nAchou,PATU_DECFGTS] += CT3QRY->FGTS13ACUM
		Endif		

		CT3QRY->(dbSkip(1))
	Enddo		
	CT3QRY->(dbCloseArea())

	aProvisoes := aSort(aProvisoes,,, { |x, y| x[1]+x[2] < y[1]+y[2] })	

	ProcRegua(Len(aProvisoes))
	For nProv := 1 To Len(aProvisoes)
		IncProc("Calculando Provisoes...")
		
		aProvisoes[nProv,RESU_FERACUM] := Round( ((aProvisoes[nProv,PATU_FERACUM]-aProvisoes[nProv,PANT_FERACUM])+aProvisoes[nProv,FOLH_FERACUM]),2)
		aProvisoes[nProv,RESU_FERINSS] := Round( ((aProvisoes[nProv,PATU_FERINSS]-aProvisoes[nProv,PANT_FERINSS])+aProvisoes[nProv,FOLH_FERINSS]),2)
		aProvisoes[nProv,RESU_FERFGTS] := Round( ((aProvisoes[nProv,PATU_FERFGTS]-aProvisoes[nProv,PANT_FERFGTS])+aProvisoes[nProv,FOLH_FERFGTS]),2)
		aProvisoes[nProv,RESU_DECACUM] := Round( ((aProvisoes[nProv,PATU_DECACUM]-aProvisoes[nProv,PANT_DECACUM])+aProvisoes[nProv,FOLH_DECACUM]),2)
		aProvisoes[nProv,RESU_DECINSS] := Round( ((aProvisoes[nProv,PATU_DECINSS]-aProvisoes[nProv,PANT_DECINSS])+aProvisoes[nProv,FOLH_DECINSS]),2)
		aProvisoes[nProv,RESU_DECFGTS] := Round( ((aProvisoes[nProv,PATU_DECFGTS]-aProvisoes[nProv,PANT_DECFGTS])+aProvisoes[nProv,FOLH_DECFGTS]),2)

	Next

	nTotDebi := 0.00
	nTotCred := 0.00	
	aLcto := {}                         
		//           TIPO,DIGITO CONTA, CONTA, LCTO POSITIVO, LCTO NEGATIVO, HISTORICO POSITIVO, HISTORICO NEGATIVO
/*
	aSituacao := {	{1,'4','4020102005','D','C','PROVISAO FERIAS'				,'REVERSAO FERIAS'				, 0.00},; 
					{1,'5','5010101005','D','C','PROVISAO FERIAS'				,'REVERSAO FERIAS'				, 0.00},;
					{1,'2','2010103003','C','D','PROVISAO FERIAS'				,'REVERSAO FERIAS'				, 0.00},;
					{2,'4','4020102002','D','C','PROVISAO INSS FERIAS'			,'REVERSAO INSS FERIAS'			, 0.00},; 
					{2,'5','5010101002','D','C','PROVISAO INSS FERIAS'			,'REVERSAO INSS FERIAS'			, 0.00},;
					{2,'2','2010104006','C','D','PROVISAO INSS FERIAS'			,'REVERSAO INSS FERIAS'			, 0.00},;
					{3,'4','4020102004','D','C','PROVISAO FGTS FERIAS'			,'REVERSAO FGTS FERIAS'			, 0.00},; 
					{3,'5','5010101004','D','C','PROVISAO FGTS FERIAS'			,'REVERSAO FGTS FERIAS'			, 0.00},;
					{3,'2','2010104002','C','D','PROVISAO FGTS FERIAS'			,'REVERSAO FGTS FERIAS'			, 0.00},;
					{4,'4','4020102006','D','C','PROVISAO 13 SALARIO'			,'REVERSAO 13 SALARIO'			, 0.00},; 
					{4,'5','5010101006','D','C','PROVISAO 13 SALARIO'			,'REVERSAO 13 SALARIO '	  		, 0.00},;
					{4,'2','2010103004','C','D','PROVISAO 13 SALARIO'			,'REVERSAO 13 SALARIO '	 		, 0.00},;
					{5,'4','4020102002','D','C','PROVISAO INSS 13 SALARIO'		,'REVERSAO INSS 13 SALARIO '	, 0.00},; 
					{5,'5','5010101002','D','C','PROVISAO INSS 13 SALARIO'		,'REVERSAO INSS 13 SALARIO '	, 0.00},;
					{5,'2','2010104007','C','D','PROVISAO INSS 13 SALARIO'		,'REVERSAO INSS 13 SALARIO '	, 0.00},;
					{6,'4','4020102004','D','C','PROVISAO FGTS 13 SALARIO'		,'REVERSAO FGTS 13 SALARIO '	, 0.00},; 
					{6,'5','5010101004','D','C','PROVISAO FGTS 13 SALARIO'		,'REVERSAO FGTS 13 SALARIO '	, 0.00},;
					{6,'2','2010104003','C','D','PROVISAO FGTS 13 SALARIO'		,'REVERSAO FGTS 13 SALARIO '	, 0.00}}
	
*/
	aSituacao := {}
	
	SZ7->(dbGotop())
	While SZ7->(!Eof())
		AAdd(aSituacao,{Val(SZ7->Z7_SITU),;
				SZ7->Z7_INICT,;
				SZ7->Z7_CONTA,;
				SZ7->Z7_POSDC,;
				SZ7->Z7_NEGDC,;
				SZ7->Z7_POSHIS,;
				SZ7->Z7_NEGHIS,;
				0.00})
		SZ7->(dbSkip(1))
	Enddo

	ProcRegua(5)
	nConta := 1
	For nColuna := RESU_FERACUM To RESU_DECFGTS                      
		IncProc("Processando Dados Contábeis...")                               

		For nProv := 1 To Len(aProvisoes)
		
			If AllTrim(aProvisoes[nProv,PLNP_CCUSTO])=='700' .And. aProvisoes[nProv,PLNP_UNIDADE]=='01'	// C.Custos 700 Nao pode processar na Matriz
				Loop
			Endif
		
			If aProvisoes[nProv,PLNP_UNIDADE]==Iif(xFilial("CT2")=='07','08',xFilial("CT2")) // Tratamento de Unidade
				CTT->(dbSetOrder(1), dbSeek(xFilial("CTT")+aProvisoes[nProv,PLNP_CCUSTO]))
			
				nAchou := Ascan(aLcto,{|x| x[PLNP_UNIDADE]+x[PLNP_CCUSTO] == aProvisoes[nProv,PLNP_UNIDADE]+aProvisoes[nProv,PLNP_CCUSTO] })
		
				If Empty(nAchou)                                                        
				
					// Identificacao da Conta Contabil, Tipo de Lancamento e Historico
					
					nTpLanc := Ascan(aSituacao,{|z| z[1]==nConta .And. z[2]==CTT->CTT_XTIPO })
					If Empty(nTpLanc)
						Loop
					Endif
					
					cConta := aSituacao[nTpLanc,3]
					cTipo  := Iif(aProvisoes[nProv,nColuna]>0.00,aSituacao[nTpLanc,4],aSituacao[nTpLanc,5])
					cHist  := Iif(aProvisoes[nProv,nColuna]>0.00,aSituacao[nTpLanc,6],aSituacao[nTpLanc,7])

					AAdd(aLcto,{aProvisoes[nProv,PLNP_CCUSTO],;
								cConta,;
								'',;
								aProvisoes[nProv,nColuna],;
								cTipo,;
								cHist,;
								Str(nConta,1)})
					nAchou := Len(aLcto)

					// Totaliza Contas Iniciadas em 2

					nTpLanc := Ascan(aSituacao,{|z| z[1]==nConta .And. z[2]=='2' })
					If Empty(nTpLanc)
						Loop
					Endif
					
					aSituacao[nTpLanc,8] += aProvisoes[nProv,nColuna]
				Else
					aLcto[nAchou,4] += aProvisoes[nProv,nColuna]
				Endif                                    
				
				If aLcto[nAchou,5]=='C'
					nTotCred += (aLcto[nAchou,4] * -1)
				Else
					nTotDebi += aLcto[nAchou,4]
				Endif					     
			Endif
		Next 
		
		// Total de Lancamento contas Inicial 2, se estiver negativas o sinal sera invertido para positivo Credito
		                
		nTpLanc := Ascan(aSituacao,{|z| z[1]==nConta .And. z[2]=='2' })
		cConta := aSituacao[nTpLanc,3]
		cTipo  := Iif(aSituacao[nTpLanc,8]>0.00,aSituacao[nTpLanc,4],aSituacao[nTpLanc,5])
		cHist  := Iif(aSituacao[nTpLanc,8]>0.00,aSituacao[nTpLanc,6],aSituacao[nTpLanc,7])
		If aSituacao[nTpLanc,8] < 0.00
			aSituacao[nTpLanc,8] := (aSituacao[nTpLanc,8] * -1)
		Endif

		If cTipo=='C'
			nTotCred += aSituacao[nTpLanc,8]
		Else
			nTotDebi += aSituacao[nTpLanc,8]
		Endif					     

		AAdd(aLcto,{'999',;
					cConta,;
					'',;
					aSituacao[nTpLanc,8],;
					cTipo,;
					cHist,;
					Str(nConta,1)})
		nConta++
	Next

	aLcto := aSort(aLcto,,, { |x, y| x[7]+x[1] < y[7]+y[1] })	
	
	If StrZero(nTotCred,16,2) <> StrZero(nTotDebi,16,2)
		AAdd(aErro,'Diferença Total Credito x Débito ==> Credito ' + TransForm(nTotCred,'@E 9,999,999,999.99') + " Débito " + TransForm(nTotDebi,'@E 9,999,999,999.99') + " !")
	Endif

	// Se Houver Erro Entao Nao Processa
	
	If Len(aErro) > 0
		cTxt := ''
		For nErro := 1 To Len(aErro)
			cTxt += aErro[nErro]+CRLF
		Next
	
		Aviso("Error Log","Erros Encontrados Durante o Processamento: "+CRLF+cTxt,{"Ok"},3)	
	Endif
	
	
	// Pre Visualizacao
	
	If lPreVisual
    	aPreVisual := {}
		aItens := {}
		For nLc := 1 To Len(aLcto)
			cCustos	:=	Iif(aLcto[nLc,1]='999','000',aLcto[nLc,1])
			cConta  :=  Iif(!Empty(aLcto[nLc,2]),aLcto[nLc,2],'E R R O')
			cItem	:=	aLcto[nLc,3]
			nValor  :=  aLcto[nLc,4]                             
			
			If Empty(nValor)	// Valores zerados não são lançados.
				Loop
			Endif
			
			cTpLcto := 	aLcto[nLc,5]

			CT1->(dbSetOrder(1), dbSeek(xFilial("CT1")+cConta))
			
			cHisto  :=	AllTrim(aLcto[nLc,6]) + ' ' + Upper(MesExtenso(dData)) + " " + Str(nAno,4)
			
			If !lItemContabil
				AAdd(aPreVisual,{StrZero(nLc,3),;
									'01',;
									iif(cTpLcto=='C','2','1'),;
					     			iif(cTpLcto=='D',cConta,''),;
					     			iif(cTpLcto=='C',cConta,''),;
					     			iif(nValor < 0.00,nValor * -1,nValor),;
					     			iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='D',cCustos,''),;
					     			iif(cTpLcto=='C',cCustos,''),;
					     			cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0),;
					     			cHisto})
			Else
				AAdd(aPreVisual,{StrZero(nLc,3),;
									'01',;
									iif(cTpLcto=='C','2','1'),;
					     			iif(cTpLcto=='D',cConta,''),;
					     			iif(cTpLcto=='C',cConta,''),;
					     			iif(nValor < 0.00,nValor * -1,nValor),;
					     			iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),''),;
					     			iif(cTpLcto=='D',cCustos,''),;
					     			iif(cTpLcto=='C',cCustos,''),;
					     			iif(cTpLcto=='D',cItem,''),;
					     			iif(cTpLcto=='C',cItem,''),;
					     			cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0),;
					     			cHisto})
			Endif
		Next                                                    
		
		@ 001,001 TO 400,1200 DIALOG oDlgDeta TITLE 'Pré-Visualizacao de Lançamentos Contábeis IMPOSTOS'
			                                                                                   
		If !lItemContabil			
			@ 001, 001 LISTBOX oDetalhes Fields HEADER 'Linha','Moeda','Tipo Lcto','Conta Débito','Conta Crédito','Valor','Dig D','Dig C','C.Custos Deb','C.Custos Cred','Historico','Origem' SIZE 600, 160 OF oDlgDeta PIXEL 
		Else
			@ 001, 001 LISTBOX oDetalhes Fields HEADER 'Linha','Moeda','Tipo Lcto','Conta Débito','Conta Crédito','Valor','Dig D','Dig C','C.Custos Deb','C.Custos Cred','Item Debito','Item Credito','Historico','Origem' SIZE 600, 160 OF oDlgDeta PIXEL 
		Endif
			
		oDetalhes:SetArray(aPreVisual)
		
		If !lItemContabil			
			oDetalhes:bLine := {|| {	aPreVisual[oDetalhes:nAt,1],;
									    aPreVisual[oDetalhes:nAt,2],;
									    aPreVisual[oDetalhes:nAt,3],;
									    aPreVisual[oDetalhes:nAt,4],;
									    aPreVisual[oDetalhes:nAt,5],;
									    TransForm(aPreVisual[oDetalhes:nAt,6],'@E 9,999,999,999.99'),;
									    aPreVisual[oDetalhes:nAt,7],;
									    aPreVisual[oDetalhes:nAt,8],;
									    aPreVisual[oDetalhes:nAt,9],;
									    aPreVisual[oDetalhes:nAt,10],;
									    aPreVisual[oDetalhes:nAt,12],;
									    aPreVisual[oDetalhes:nAt,11]}}
		Else
			oDetalhes:bLine := {|| {	aPreVisual[oDetalhes:nAt,1],;
									    aPreVisual[oDetalhes:nAt,2],;
									    aPreVisual[oDetalhes:nAt,3],;
									    aPreVisual[oDetalhes:nAt,4],;
									    aPreVisual[oDetalhes:nAt,5],;
									    TransForm(aPreVisual[oDetalhes:nAt,6],'@E 9,999,999,999.99'),;
									    aPreVisual[oDetalhes:nAt,7],;
									    aPreVisual[oDetalhes:nAt,8],;
									    aPreVisual[oDetalhes:nAt,9],;
									    aPreVisual[oDetalhes:nAt,10],;
									    aPreVisual[oDetalhes:nAt,11],;
									    aPreVisual[oDetalhes:nAt,12],;
									    aPreVisual[oDetalhes:nAt,14],;
									    aPreVisual[oDetalhes:nAt,13]}}
		Endif
	
		@ 170,120 SAY "Total Debito:"   SIZE 80,10 COLOR CLR_BLUE,CLR_WHITE 
		@ 170,180 SAY oRmMarD VAR nTotDebi Picture '@E 9,999,999,999.99' SIZE 100,15 COLOR CLR_RED,CLR_WHITE  OF oDlgDeta PIXEL 
		oRmMarD:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)
			
		@ 180,120 SAY "Total Credito:"   SIZE 80,10 COLOR CLR_BLUE,CLR_WHITE 
		@ 180,180 SAY oRmMarC VAR nTotCred Picture '@E 9,999,999,999.99' SIZE 100,15 COLOR CLR_BLUE,CLR_WHITE  OF oDlgDeta PIXEL 
		oRmMarC:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)
		
		nOpc := 0

		If Empty(Len(aErro))
			@ 180,300 BUTTON "Continua"				SIZE 50,15 ACTION (nOpc:=1,Close(oDlgDeta))
		Else     
			cErro := "Foram Encontrados Erros, Impossível Efetuar Contabilização"   
			
			@ 165,300 SAY oErro VAR cErro SIZE 300,10 COLOR CLR_RED,CLR_WHITE OF oDlgDeta PIXEL 
			
			oErro:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)
			
			@ 180,350 BUTTON "_Excel"          		SIZE 50,15 ACTION Processa({|| PlnXls(lItemContabil) })
			
		Endif

		@ 180,400 BUTTON "_Sair"          		SIZE 50,15 ACTION (nOpc:=0,Close(oDlgDeta))
				
		ACTIVATE DIALOG oDlgDeta CENTERED
		
		If nOpc <> 1
			Return .f.
		Endif     
	Endif
	
	aCab:= {{"dDataLanc",dDatabase		,NIL},;
			{"cLote"	,cLote			,NIL},;
			{"cSubLote"	,"001"			,NIL}}
	
	aItens := {}
	For nLc := 1 To Len(aLcto)
		cCustos	:=	Iif(aLcto[nLc,1]='999','000',aLcto[nLc,1])
		cConta  :=  aLcto[nLc,2]
		cItem	:=	aLcto[nLc,3]
		nValor  :=  aLcto[nLc,4]                             
		
		If Empty(nValor)	// Valores zerados não são lançados.
			Loop
		Endif
		
		cTpLcto := 	aLcto[nLc,5]
		cHisto  :=	AllTrim(aLcto[nLc,6]) + ' ' + Upper(MesExtenso(dData)) + " " + Str(nAno,4)

		If !lItemContabil
			aAdd(aItens,{{"CT2_FILIAL"	,xFilial("CT2")										,NIL},;
						{"CT2_LINHA"	,StrZero(nLc,3)										,NIL},;		
						{"CT2_MOEDLC"	,"01"												,NIL},;
				     	{"CT2_DC"		,iif(cTpLcto=='C','2','1')							,NIL},;
				     	{"CT2_DEBITO"	,iif(cTpLcto=='D',cConta,'')			 			,NIL},;
				     	{"CT2_CREDIT"	,iif(cTpLcto=='C',cConta,'')			 			,NIL},;
				     	{"CT2_VALOR"	,iif(nValor<0.00,nValor * -1,nValor)				,NIL},;
						{"CT2_DCD"		,iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
						{"CT2_DCC"		,iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
				     	{"CT2_CCD"		,iif(cTpLcto=='D',cCustos,'')			 			,NIL},;
				     	{"CT2_CCC"		,iif(cTpLcto=='C',cCustos,'')						,NIL},;
				     	{"CT2_ORIGEM"	,cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0)		,NIL},;
				     	{"CT2_HIST"		,cHisto												,NIL}})
		Else
			aAdd(aItens,{{"CT2_FILIAL"	,xFilial("CT2")										,NIL},;
						{"CT2_LINHA"	,StrZero(nLc,3)										,NIL},;		
						{"CT2_MOEDLC"	,"01"												,NIL},;
				     	{"CT2_DC"		,iif(cTpLcto=='C','2','1')							,NIL},;
				     	{"CT2_DEBITO"	,iif(cTpLcto=='D',cConta,'')			 			,NIL},;
				     	{"CT2_CREDIT"	,iif(cTpLcto=='C',cConta,'')			 			,NIL},;
				     	{"CT2_VALOR"	,iif(nValor<0.00,nValor * -1,nValor)				,NIL},;
						{"CT2_DCD"		,iif(cTpLcto=='D',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
						{"CT2_DCC"		,iif(cTpLcto=='C',CtbDigCont("CT1->CT1_CONTA"),'')	,NIL},;
				     	{"CT2_CCD"		,iif(cTpLcto=='D',cCustos,'')			 			,NIL},;
				     	{"CT2_CCC"		,iif(cTpLcto=='C',cCustos,'')						,NIL},;
				     	{"CT2_ITEMD"	,iif(cTpLcto=='D',cItem,'')				 			,NIL},;
				     	{"CT2_ITEMC"	,iif(cTpLcto=='C',cItem,'')							,NIL},;
				     	{"CT2_ORIGEM"	,cUserName+" "+DTOC(dDatabase)+" "+FUNNAME(0)		,NIL},;
				     	{"CT2_HIST"		,cHisto												,NIL}})
		Endif
	Next

		// inclusao
	lMsErroAuto := .F.
	BEGIN TRANSACTION
	MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)},aCab,aItens,3)
	If lMsErroAuto
		MostraErro()
		DisarmTransaction()
		Return .F.
	Endif
	END TRANSACTION
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Marcos V. Ferreira    ³ Data ³04/11/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Altera descricao da pergunta no SX1                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR900			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//*****************************************************************************
Static Function AjustaSX1()
//*****************************************************************************

_aArea := GetArea()

DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PadR(cPerg,10)

aRegs:={}
//          Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

aAdd(aRegs,{cPerg,"01","Mes Referencia ?" ,"mv_ch1","N",02,0,0,"G","MV_PAR01 >= 1 .And. MV_PAR02 <=12","mv_par01",""     ,"","","","",""        ,"","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Ano Referencia ?" ,"mv_ch2","N",04,0,0,"G",""                                 ,"mv_par02",""     ,"","","","",""        ,"","","","","","","","",""})
AAdd(aRegs,{cPerg,"03","Tipo Lançto    ? ","mv_ch3","N",01,0,0,"C","","mv_par03","Folha","","Provisoes","","Encargos","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"04","Item Contabil  ? ","mv_ch4","N",01,0,0,"C","","mv_par04","Sim","","Nao","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"05","Pre-Visualizar ? ","mv_ch5","N",01,0,0,"C","","mv_par05","Sim","","Nao","","","","","","","","","","","",""})

For i := 1 To Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		SX1->X1_GRUPO   := aRegs[i,01]
		SX1->X1_ORDEM   := aRegs[i,02]
		SX1->X1_PERGUNT := aRegs[i,03]
		SX1->X1_VARIAVL := aRegs[i,04]
		SX1->X1_TIPO    := aRegs[i,05]
		SX1->X1_TAMANHO := aRegs[i,06]
		SX1->X1_DECIMAL := aRegs[i,07]
		SX1->X1_PRESEL  := aRegs[i,08]
		SX1->X1_GSC     := aRegs[i,09]
		SX1->X1_VALID   := aRegs[i,10]
		SX1->X1_VAR01   := aRegs[i,11]
		SX1->X1_DEF01   := aRegs[i,12]
		SX1->X1_CNT01   := aRegs[i,13]
		SX1->X1_VAR02   := aRegs[i,14]
		SX1->X1_DEF02   := aRegs[i,15]
		SX1->X1_CNT02   := aRegs[i,16]
		SX1->X1_VAR03   := aRegs[i,17]
		SX1->X1_DEF03   := aRegs[i,18]
		SX1->X1_CNT03   := aRegs[i,19]
		SX1->X1_VAR04   := aRegs[i,20]
		SX1->X1_DEF04   := aRegs[i,21]
		SX1->X1_CNT04   := aRegs[i,22]
		SX1->X1_VAR05   := aRegs[i,23]
		SX1->X1_DEF05   := aRegs[i,24]
		SX1->X1_CNT05   := aRegs[i,25]
		SX1->X1_F3      := aRegs[i,26]
		MsUnlock()
		DbCommit()
	Endif
Next

RestArea(_aArea)

Return()



Static Function PlnXls(lItemContabil)
Local oFWMsExcel
Local oExcel
Local cArquivo	:= GetTempPath()+'PNG_'+DtoS(dDataBase)+'.xml'

//Criando o objeto que irá gerar o conteudo do Excel
oFWMsExcel := FWMSExcel():New()  
	     
//Alterando atributos
oFWMsExcel:SetFontSize(12)                 //Tamanho Geral da Fonte
oFWMsExcel:SetFont("Arial")                //Fonte utilizada
oFWMsExcel:SetTitleBold(.T.)               //Título Negrito
oFWMsExcel:SetTitleFrColor("#94eaff")      //Cor da Fonte do título - Azul Claro
	    
cPlan	:=	'Integra Folha RM'

oFWMsExcel:AddworkSheet(cPlan) 
oFWMsExcel:AddTable(cPlan,cPlan)
 
 
If !lItemContabil			
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Linha',1,2) 
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Moeda',1,2) 
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Tipo Lcto',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Conta Débito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Conta Crédito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Valor',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Digito D',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Digito C',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'C.Custos Débito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'C.Custos Crédito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Histórico',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Origem',1,2)
Else
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Linha',1,2) 
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Moeda',1,2) 
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Tipo Lcto',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Conta Débito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Conta Crédito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Valor',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Digito D',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Digito C',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'C.Custos Débito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'C.Custos Crédito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Item Débito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Item Crédito',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Histórico',1,2)
	oFWMsExcel:AddColumn(cPlan, cPlan, 'Origem',1,2)
Endif
 
For nPosicao := 1 To Len(aPreVisual)
	If !lItemContabil
		oFWMsExcel:AddRow(cPlan, cPlan, {aPreVisual[nPosicao,1],;
										 aPreVisual[nPosicao,2],;
										 aPreVisual[nPosicao,3],;
										 aPreVisual[nPosicao,4],;
										 aPreVisual[nPosicao,5],;
										 TransForm(aPreVisual[nPosicao,6],'@E 9,999,999,999.99'),;
										 aPreVisual[nPosicao,7],;
										 aPreVisual[nPosicao,8],;
										 aPreVisual[nPosicao,9],;
										 aPreVisual[nPosicao,10],;
										 aPreVisual[nPosicao,12],;
										 aPreVisual[nPosicao,11]})
	Else
		oFWMsExcel:AddRow(cPlan, cPlan, {aPreVisual[nPosicao,1],;
										 aPreVisual[nPosicao,2],;
										 aPreVisual[nPosicao,3],;
										 aPreVisual[nPosicao,4],;
										 aPreVisual[nPosicao,5],;
										 TransForm(aPreVisual[nPosicao,6],'@E 9,999,999,999.99'),;
										 aPreVisual[nPosicao,7],;
										 aPreVisual[nPosicao,8],;
										 aPreVisual[nPosicao,9],;
										 aPreVisual[nPosicao,10],;
										 aPreVisual[nPosicao,11],;
										 aPreVisual[nPosicao,12],;
										 aPreVisual[nPosicao,14],;
										 aPreVisual[nPosicao,13]})
	Endif
Next

//Ativando o arquivo e gerando o xml
oFWMsExcel:Activate()
oFWMsExcel:GetXMLFile(cArquivo)
	         
//Abrindo o excel e abrindo o arquivo xml

oExcel := MsExcel():New()          	//Abre uma nova conexão com Excel
oExcel:WorkBooks:Open(cArquivo)    	//Abre uma planilha
oExcel:SetVisible(.T.)             	//Visualiza a planilha
oExcel:Destroy()                   	//Encerra o processo do gerenciador de tarefas
Return .T.



