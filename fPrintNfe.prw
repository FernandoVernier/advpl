#Include 'Protheus.ch'
#Include "RPTDEF.CH"
#Include "FWPrintSetup.ch"
#Include "rwmake.ch"
#include "topconn.ch"
#include "inkey.ch"                                                                         
#include "tbiconn.ch" 
#INCLUDE "Directry.ch"

/*
------------------------------------------------------------------------------------------------------------
Função		: fPrintNfe
Tipo		: Funcao do usuario
Descrição	: Impressão de Danfe por JOB
Uso			: 
Parâmetros	:                                         
Retorno		: 
------------------------------------------------------------------------------------------------------------
Atualizações:
- 25/06/2014 - Fernando Vernier - Construção inicial do fonte
------------------------------------------------------------------------------------------------------------
*/

User Function fPrintNfe(xParam1,xParam2)

	Local cCGC		:= ""
	Local cIE		:= ""
	Local cIdEnt	:= ""
	Local cCli		:= ""
	Local cLoja		:= ""
	Local cDoc		:= ""
	Local cSerie	:= ""
	Local cCodRSef	:= ""

	
	If ValType(xParam1) == "A"
		cEmp := xParam1[1]
		cFil := xParam1[2]
	ElseIf ValType(xParam1) == "C"
		cEmp := xParam1
		cFil := xParam2
	Else
		cEmp := "01"
		cFil := "01"
	EndIf

	ConOut("Empresa: " + cEmp + " - Filial: " + cFil)
	
	//|Inicializa ambiente |
	//PREPARE ENVIRONMENT EMPRESA cEmp FILIAL cFil TABLES 'SF2' MODULO 'FAT'
	
	RPCSetType( 3 )	// N? consome licen? de uso
	RpcSetEnv(cEmp,cFil,,,'FAT',GetEnvServer(),{ "SF2" })
	/*
	Private aTab        := {"SX6","SF2"}
	RpcSetType(3) 
	RPCSetEnv("01","01","","","","",aTab)
	
	CODIGO
	
	RpcClearEnv()
	*/
	
	ConOut('-------Iniciando execucao da rotina fPrintNFe------')
	ConOut('---------------IMPRESSAO DE DANFE------------------')	
	ConOut('---------------------------------------------------') 
	
    cCodRSef:= "%" + FormatIn(GetMv("MV_YCODSEF",.F.,"100,124,125,' '"),",") + "%" //|Alterar aqui |
  
	If Select("_TRB") > 0
		_TRB->(dbCloseArea())
	EndIf
	
	ConOut('--------BUSCANDO NOTAS FISCAIS NAO IMPRESSAS-------')
	/*
	BeginSQL Alias "_TRB"
		SELECT DISTINCT F3_NFISCAL,F3_SERIE,F3_CLIEFOR,F3_LOJA,SubString(F3_CFO,1,1) AS CFO
		FROM   %Table:SF3% SF3
		WHERE  F3_FILIAL = %xFilial:SF3% 
		       AND F3_ESPECIE = 'SPED'
		       AND F3_YPRINT <> 'S'
		       AND SF3.%NotDel% 
	EndSQL
	*/
	 
	 
	BeginSQL Alias "_TRB"
		SELECT DISTINCT F3_NFISCAL,F3_SERIE,F3_CLIEFOR,F3_LOJA,SubString(F3_CFO,1,1) AS CFO
		FROM   %Table:SF3% SF3
		WHERE  F3_FILIAL = %xFilial:SF3% 
		       AND F3_ESPECIE = 'SPED'
		       AND F3_YPRINT <> 'S'
				 AND F3_DTCANC = ''
		       AND F3_CFO > '5000'
		       AND SF3.%NotDel% 
		      
	EndSQL
	
	

	Count To nQtde
	
	If nQtde == 0
		ConOut('--NAO EXISTEM NOVAS NOTAS FISCAIS PARA IMPRESSAO---')	
		ConOut('---------------------------------------------------')
		ConOut('------------Fim da rotina fPrintNFe----------------')	
		ConOut("")
		Return
	EndIf
	
	_TRB->(dbGoTop())
		
	While !_TRB->(EoF())
	
		cCli	:= _TRB->F3_CLIEFOR
		cLoja	:= _TRB->F3_LOJA                                                             
		cDoc	:= _TRB->F3_NFISCAL
		cSerie	:= _TRB->F3_SERIE
		cCFO	:= _TRB->CFO
		
		dbSelectArea("SF2")
		SF2->(dbSetOrder(2)) //|F2_FILIAL+F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE |
		If SF2->(dbSeek(xFilial("SF2") + cCli + cLoja + cDoc + cSerie))
			ConOut("IMPRIMINDO DANFE: " + cDoc + "/" + cSerie)
			PrintDANFE(cCFO)
			
			//|Atualiza as danfes impressas |
			ConOut("DANFE IMPRESSA: " + cDoc + "/" + cSerie)
			SFP006(cCli , cLoja , cDoc , cSerie,"A")
			ConOut('---------------------------------------------------')
		Else
			ConOut("NOTA FISCAL NÃO ENCONTRADA NA SF2: " + cDoc + "/" + cSerie)	
			SFP006(cCli , cLoja , cDoc , cSerie,"B")
		EndIf
		
		_TRB->(dbSkip())
		
	EndDo
	
	ConOut('---------------------------------------------------')
	ConOut('------------Fim da rotina fPrintNFe----------------')	
	ConOut("")

	
	
	RESET ENVIRONMENT

Return



/*
------------------------------------------------------------------------------------------------------------
Função		: PrintDANFE
Tipo		: Função de usuário
Descrição	: Impressão da DANFE 
Uso			: Faturamento - apos a transmissão automática na DANFE
Parâmetros	:
Retorno		: 
------------------------------------------------------------------------------------------------------------
Atualizações:
- 25/06/2014 - Pontin - Construção inicial do fonte
------------------------------------------------------------------------------------------------------------
*/
Static Function PrintDANFE(cCFO)
	Local cQuery	:= ""
	Local cAlias	:= ""                
	Local cCliente 	:= SF2->F2_CLIENTE
	Local cLoja		:= SF2->F2_LOJA
	Local cEmissao	:= SF2->F2_EMISSAO
	Local lImp		:= .F.  
	Local nVias 	:= 2
	
	Private cDoc    := SF2->F2_DOC
	Private cSerie 	:= SF2->F2_SERIE 
	Private cIdEnt
     
 	cAlias := GetNextAlias()
	BeginSql ALIAS cAlias
		SELECT SFT.FT_CHVNFE,SF4.F4_DUPLIC
		FROM %TABLE:SFT% SFT
		INNER JOIN %TABLE:SD2% SD2
			ON D2_FILIAL = FT_FILIAL
			AND D2_DOC   = FT_NFISCAL
			AND D2_SERIE = FT_SERIE
			AND D2_CLIENTE = FT_CLIEFOR
			AND D2_LOJA  = FT_LOJA      
			AND D2_ITEM  = FT_ITEM
			AND D2_COD   = FT_PRODUTO
			AND SD2.%NotDel% 
		INNER JOIN %TABLE:SF4% SF4
			ON F4_FILIAL = %xFilial:SF4% 
			AND F4_CODIGO = D2_TES
			AND SF4.%NotDel% 
		WHERE SFT.FT_NFISCAL = %Exp:cDoc%
		AND FT_CLIEFOR = %Exp:cCliente%
		AND FT_LOJA = %Exp:cLoja%
		AND FT_EMISSAO = %Exp:cEmissao%  
		AND SFT.%NotDel% 
	EndSQL
	
	//|Cria parametro |
    SFP002()                

	If (cAlias)->FT_CHVNFE != "" 
		If (cAlias)->F4_DUPLIC == 'S'
			nVias := 3
		Else
			nVias := 2
		EndIf	
		//|Realiza a impressão da DANFE |
   		SFP001(cCFO,nVias)
	EndIf            

	(cAlias)->(DbCloseArea())

Return 

/*
------------------------------------------------------------------------------------------------------------
Função		: SFP001
Tipo		: Função estática
Descrição	: Impressão da DANFE
Parâmetros	:
Retorno		: 
------------------------------------------------------------------------------------------------------------
Atualizações:
- 25/06/2014 - Pontin - Construção inicial do fonte
------------------------------------------------------------------------------------------------------------
*/
Static Function SFP001(cCFO,nVias)

	Local cFilePrint 		:= "DANFE_"+AllTrim(cDoc)+"_"+AllTrim(cSerie)
	Local cDirDanfe			:= "C:\TEMP\" + cFilAnt
	Local cSession     		:= GetPrinterSession()
	Local lAdjustToLegacy 	:= .F. //|Inibe legado de resolução com a TMSPrinter |                                               
	Local oDanfe
	
	//|Verifica e cria o diretório para salvar a Danfe |
	If !ExistDir(cDirDanfe)
		FWMakeDir( cDirDanfe, .F. )
	EndIf
	
	//|Exclui o arquivo, caso já exista |
	If File(cDirDanfe + "\" + cFilePrint)
		fErase(cDirDanfe + "\" + cFilePrint)
	EndIf
	
	nOrientation 	:= 1
	nLocal       	:= 2
	
	oDanfe := FWMSPrinter():New(cFilePrint,IMP_SPOOL, lAdjustToLegacy, cDirDanfe, .T., , ,GetMV("MV_YIMPRNF"), .F., , ,.F., nVias)           
	oDanfe:lInJob  := .T.
	oDanfe:lServer := .T.
	
	nFlags := PD_ISTOTVSPRINTER+ PD_DISABLEORIENTATION + PD_DISABLEPAPERSIZE + PD_DISABLEPREVIEW + PD_DISABLEMARGIN
	
	oSetup := FWPrintSetup():New(nFlags, "DANFE")
	
	oSetup:SetPropert(PD_PRINTTYPE   , 2) //Spool
	oSetup:SetPropert(PD_ORIENTATION , nOrientation)
	oSetup:SetPropert(PD_DESTINATION , nLocal)
	oSetup:SetPropert(PD_MARGIN      , {60,60,60,60})
	oSetup:SetPropert(PD_PAPERSIZE   , 2)

	//|Atualiza perguntas padrões da impressão de danfe |
	SFP005(cDoc, cSerie, cCFO)	 
	cIdEnt     := SFP004()
	
   U_PrtNfeSef(cIdEnt,'','',oDanfe,oSetup,cFilePrint, .T.)
	oSetup := Nil
	
Return 

/*
------------------------------------------------------------------------------------------------------------
Função		: SFP002
Tipo		: Função estática
Descrição	: Cria parametro para que seja informado a impressora de nota fiscal eletronica
Parâmetros	:
Retorno		: 
------------------------------------------------------------------------------------------------------------
Atualizações:
- 25/06/2014 - Pontin - Construção inicial do fonte
------------------------------------------------------------------------------------------------------------
*/
                 
Static Function SFP002()

	If !GetMV("MV_YIMPRNF",.T.)
		
		RecLock( "SX6",.T. )
		SX6->X6_FIL     := xFilial( "SX6" )
		SX6->X6_VAR     := "MV_YIMPRNF"
		SX6->X6_TIPO    := "C"		
		SX6->X6_DESCRIC := "Nome da impressora de notas fiscais eletronicas"
		SX6->X6_DESC1   := ""
		SX6->X6_DESC2   := ""
	  	SX6->X6_CONTEUD := "HP1102"  //|Alterar aqui |
		SX6->X6_CONTSPA := "HP1102" 	//|Alterar aqui |
		SX6->X6_CONTENG := "HP1102" 	//|Alterar aqui |
		MsUnLock()
	EndIf
Return 

/*
------------------------------------------------------------------------------------------------------------
Função		: SFP004
Tipo		: Função estática
Descrição	: 
Parâmetros	:
Retorno		: 
------------------------------------------------------------------------------------------------------------
Atualizações:
- 25/06/2014 - Pontin - Construção inicial do fonte
------------------------------------------------------------------------------------------------------------
*/ 
Static Function SFP004()

	Local aArea  := GetArea()
	Local cIdEnt := ""
	Local cURL   := PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Local oWs
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Obtem o codigo da entidade                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oWS := WsSPEDAdm():New()
	oWS:cUSERTOKEN := "TOTVS"
		
	oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")	
	oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
	oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM		
	oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
	oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
	oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
	oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
	oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
	oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
	oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
	oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
	oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
	oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
	oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
	oWS:oWSEMPRESA:cCEP_CP     := Nil
	oWS:oWSEMPRESA:cCP         := Nil
	oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
	oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
	oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
	oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
	oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
	oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
	oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cINDSITESP  := ""
	oWS:oWSEMPRESA:cID_MATRIZ  := ""
	oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
	oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
	If oWs:ADMEMPRESAS()
		cIdEnt  := oWs:cADMEMPRESASRESULT
	Else
		Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Teste"},3)
	EndIf
	
	RestArea(aArea)

Return(cIdEnt)
               

/*
------------------------------------------------------------------------------------------------------------
Função		: SFP005
Tipo		: Função de Usuário
Descrição	: Seta os valores da DANFE a serem impressos no grupo de perguntas
Parâmetros	:
Retorno		:
------------------------------------------------------------------------------------------------------------
Atualizações:
- 25/06/2014 - Pontin - Construção inicial do fonte
------------------------------------------------------------------------------------------------------------
*/
Static Function SFP005(cDoc, cSerie, cCFO)
	
	Local cOperac	:= ""

	If cCFO < "5"
		cOperac := 1	//|NF Entrada |
	Else
		cOperac := 2	//|NF Saída |
	EndIf
	
	
	//|Alterando registro de pergunta |
	DbSelectArea("SX1")
	DbSetOrder(1)
	If DbSeek(PadR("NFSIGW",Len(SX1->X1_GRUPO))+"01")
		while AllTrim(SX1->X1_GRUPO) == "NFSIGW"
			RecLock("SX1", .F.)
			If AllTrim(SX1->X1_PERGUNT) = 'Da Serie ?'
				SX1->X1_CNT01 := cSerie
			ElseIf AllTrim(SX1->X1_PERGUNT) = 'Da Nota Fiscal ?'
				SX1->X1_CNT01 := cDoc
			ElseIf AllTrim(SX1->X1_PERGUNT) = 'Ate a Nota Fiscal ?'
				SX1->X1_CNT01 := cDoc
			ElseIf AllTrim(SX1->X1_PERGUNT) = 'Tipo de Operacao ?'
				SX1->X1_PRESEL := cOperac
			EndIf
			
			SX1->(MsUnLock())
			SX1->(dbSkip())
		EndDo
		
	EndIf
		
Return


Static Function SFP006(cCli, cLoja, cDoc, cSerie, cTipo)

	Local cNomeRel	:= "DANFE_"+AllTrim(cDoc)+"_"+AllTrim(cSerie)
	Local cDirDanfe	:= "C:\TEMP\" + cFilAnt
	Local cQuery	:= ""   
	Local aFiles	:= {}
	Local aArea		:= GetArea()
	Local aAreaSF3	:= SF3->(GetArea())

	//|Verifica se gerou a DANFE |
	IF cTipo == "A"
		If File(cDirDanfe + "\" + cNomeRel + ".rel")
			
			aFiles := Directory(cDirDanfe + "\" + cNomeRel + ".rel")
			
			If Len(aFiles) < 1
				Return
			EndIf 
			
			If aFiles[1,2] < 1800
				Return
			EndIf
			
			cQuery := " UPDATE " + RetSqlName("SF3") + " SET F3_YPRINT = 'S' "
			cQuery += " WHERE F3_FILIAL = " + ValToSql(xFilial("SF3"))
			cQuery += " 	AND F3_CLIEFOR = " + ValToSql(cCli)
			cQuery += " 	AND F3_LOJA = " + ValToSql(cLoja)
			cQuery += " 	AND F3_NFISCAL = " + ValToSql(cDoc)
			cQuery += " 	AND F3_SERIE = " + ValToSql(cSerie)
			cQuery += " 	AND D_E_L_E_T_ = '' "
			TcSqlExec(cQuery)
			
		//	fErase(cDirDanfe + "\" + cNomeRel + ".rel")
				
		Else
			ConOut("NAO FOI ENCONTRADO CONFIRMACAO DE GERACAO DA DANFE:" + cDoc + "/" + cSerie)
			ConOut("STATUS DA DANFE NAO SERA ALTERADO PARA REIMPRESSAO FUTURA")
		EndIf
	Else
		cQuery := " UPDATE " + RetSqlName("SF3") + " SET F3_YPRINT = 'S' "
		cQuery += " WHERE F3_FILIAL = " + ValToSql(xFilial("SF3"))
		cQuery += " 	AND F3_CLIEFOR = " + ValToSql(cCli)
		cQuery += " 	AND F3_LOJA = " + ValToSql(cLoja)
		cQuery += " 	AND F3_NFISCAL = " + ValToSql(cDoc)
		cQuery += " 	AND F3_SERIE = " + ValToSql(cSerie)
		cQuery += " 	AND D_E_L_E_T_ = '' "
		TcSqlExec(cQuery)
		
		//fErase(cDirDanfe + "\" + cNomeRel + ".rel")
		
	EndIf
	
	RestArea(aAreaSF3)
	RestArea(aArea)

Return
