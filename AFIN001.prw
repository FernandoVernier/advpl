/*
+----------------------------------------------------------------------------+
!                         FICHA TECNICA DO PROGRAMA                          !
+----------------------------------------------------------------------------+
!   DADOS DO PROGRAMA                                                        !
+------------------+---------------------------------------------------------+
!Tipo              ! Rotina                                                  !
+------------------+---------------------------------------------------------+
!Modulo            ! Financeiro                                              !
+------------------+---------------------------------------------------------+
!Nome              ! AFIN001.PRW                                             !
+------------------+---------------------------------------------------------+
!Descricao         ! Rotina enviar boleto por email                          !
+------------------+---------------------------------------------------------+
!Autor             ! Fernando Vernier                                        !
+------------------+---------------------------------------------------------+
!Data de Criacao   ! 11/03/2016                                              !
+------------------+---------------------------------------------------------+
!   ATUALIZACOES                                                             !
+-------------------------------------------+-----------+-----------+--------+
!   Descricao detalhada da atualizacao      !Nome do    ! Analista  !Data da !
!                                           !Solicitante! Respons.  !Atualiz.!
+-------------------------------------------+-----------+-----------+--------+
! Inclusão de chamada para função de gera-  ! Luana     ! Funaki    !17/08/16!
! ção de DANFE em PDF para envio.           !           !           !        !
+-------------------------------------------+-----------+-----------+--------+
! Inclusçao de encio de email de conforme   ! Elvino    ! Mario F.  !24/09/19!
! cadastro PLANILHA do contrato             !           !           !        !
+-------------------------------------------+-----------+-----------+--------+
*/
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"
#include "TBICONN.CH"
#include "AP5MAIL.CH"

#DEFINE CRLF (chr(13)+chr(10))

User Function AFIN001()

	Local aArea := GetArea()
	
	Private cNomeRot	:= FunName()
	Private cPerg 		:= PadR(cNomeRot,10)
	Private nOpcx		:= 1
	
	Private nPosMark  	:= 1
	Private nPosEnv   	:= 2
	Private nPosSer   	:= 3
	Private nPosDoc   	:= 4
	Private nPosCli   	:= 5
	Private	nPosLoja  	:= 6
	Private nPosNome  	:= 7
	Private nPosFPg   	:= 8
	Private nPosNFSe  	:= 9
	Private nPosCod   	:= 10
	Private nPosMail  	:= 11
	Private nPosRegno 	:= 12
	
	CriaSx1()
	
	While nOpcx == 1
		if !Pergunte(cPerg,.T.)
			Return .F.
		EndIf
		
		AFIN01PR()
		
	EndDo
	
	RestArea(aArea)
Return()

/*/{Protheus.doc} AFIN01PR
Função para exibir uma tela com os documento de saída que podem gerar boletos
@type function
@author Mario Faria
@since 14/03/2016
@version 1.0
/*/Static Function AFIN01PR()
	Local oBtnGer	:= Nil
	Local oBtnFec	:= Nil
	Local oBtnMar	:= Nil
	
	Private oListDoc	:= Nil
	Private aListDoc	:= {}
	Private oDlgDoc		:= Nil
	
	Private oSayQtd	 := Nil
	Private oQtdSel	 := Nil
	Private nQtdReg	 := 0
	
	Private oFont16n := TFont():New("Arial",,16,,.T.,,,,.F.,.F.)
	
	Private oOk	:= Loadbitmap(GetResources(), 'LBOK')
	Private oNo	:= Loadbitmap(GetResources(), 'LBNO')
	
	Private oVm	:= Loadbitmap(GetResources(), "BR_VERMELHO")
	Private oVd	:= Loadbitmap(GetResources(), "BR_VERDE")
	
	DEFINE MSDIALOG oDlgDoc From 000,000 To 500,800 Title "Boletos" Of oMainWnd PIXEL
	
	@003,002 GROUP oGrpUM TO 234,400 PROMPT "Documentos de Saída" OF oDlgDoc PIXEL
	
	@010,006 LISTBOX oListDoc FIELDS HEADERS "  ","Env.Mail","Série","Documento","Cliente","Loja","Nome","Frm.Pgto","NFS-e","Prot.";
		Size 390,220 PIXEL ColSizes 30,20,20,40,30,20,120,30,20,20,20 Of oDlgDoc;
		On dblClick(TROCA(oListDoc:nAt,aListDoc), oListDoc:Refresh() )
	
	oSayQtd := TSay():New(238,326,{||"Selecionados: "},oDlgDoc,,oFont16n,,,,.T.,CLR_BLUE,,200,20)
	oQtdSel := TSay():New(238,380,{||"0"}			  ,oDlgDoc,,oFont16n,,,,.T.,CLR_BLUE,,200,20)
	
	ATUDADOS()
	
	oListDoc:Refresh()
	
	oBtnGer := tButton():New(238,003,"Enviar" 		,oDlgDoc,;
		{|| Processa( {|lEnd| GeraBol(@lEnd)},"Processando...","Processando..."),nOpcx := 1,oDlgDoc:End()},;
		36,10,,,,.T.)
	oBtnGer:cToolTip := "Enviar"
	
	oBtnMar := tButton():New(238,043,"Marca Tudo" 	,oDlgDoc,{|| INVERTE()},36,10,,,,.T.)
	oBtnMar:cToolTip := "Marca Tudo"
	
	oBtnFec := tButton():New(238,083,"Fechar" 		,oDlgDoc,{|| nOpcx := 1,oDlgDoc:End()},36,10,,,,.T.)
	oBtnFec:cToolTip := "Fechar"
	
	ACTIVATE MSDIALOG oDlgDoc CENTERED

Return

/*/{Protheus.doc} ATUDADOS
Função para buscar os dados de acordo com as perguntas
@type function
@author Mario Faria
@since 14/03/2016
@version 1.0
/*/Static Function ATUDADOS()

	Local nX		:= 0
	Local aDadosMail	:= {}
	Local cQuery	:= ""
	Local cMailTo 	:= ""
	Local cFrmPgt	:= ""
	Local cEnvBol	:= ""
	Local cAliasDoc	:= GetNextAlias()
	
	cQuery := "	SELECT DISTINCT " + CRLF
	cQuery += "		F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, A1_NOME, A1_CGC, " + CRLF
	cQuery += "		F2_NFELETR, F2_CODNFE, F2_XENVBOL, SF2.R_E_C_N_O_ REGNO " + CRLF
	cQuery += "	FROM " + RetSqlName("SF2") + " SF2 " + CRLF
	cQuery += "	INNER JOIN " + RetSqlName("SA1") + " SA1 ON " + CRLF
	cQuery += "			A1_FILIAL = '" + xFilial("SA1") + "' " + CRLF
	cQuery += "		AND A1_COD = F2_CLIENTE " + CRLF
	cQuery += "		AND A1_LOJA = F2_LOJA " + CRLF
	cQuery += "		AND SA1.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "	INNER JOIN " + RetSqlName("SE1") + " SE1 ON " + CRLF
	cQuery += "			E1_FILIAL = F2_FILIAL " + CRLF
	cQuery += "		AND E1_PREFIXO = F2_SERIE " + CRLF
	cQuery += "		AND E1_NUM = F2_DOC " + CRLF
	cQuery += "		AND E1_TIPO = 'NF' " + CRLF
	cQuery += "		AND E1_SALDO > 0 " + CRLF
	cQuery += "		AND SE1.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "	WHERE " + CRLF
	cQuery += "			F2_FILIAL = '" + xFilial("SF2") + "' " + CRLF
	cQuery += "		AND F2_NFELETR != '' " + CRLF
	cQuery += "		AND F2_EMISSAO BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02)  + "' " + CRLF
	cQuery += "		AND F2_SERIE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' " + CRLF
	cQuery += "		AND F2_DOC BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' " + CRLF
	cQuery += "		AND F2_NFELETR BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' " + CRLF
	cQuery += "		AND F2_CLIENTE BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR11 + "' " + CRLF
	cQuery += "		AND F2_LOJA BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR12 + "' " + CRLF
	
	If (MV_PAR13 == 1)	//Enviados
		cQuery += "		AND F2_XENVBOL = 'S' " + CRLF
	ElseIf (MV_PAR13 == 2)	//Não Enviados
		cQuery += "		AND F2_XENVBOL != 'S' " + CRLF
	EndIf
	
	cQuery += "		AND SF2.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "	ORDER BY F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA " + CRLF
	
	TCQuery cQuery New Alias (cAliasDoc)
	
	aListDoc := {}
	While !(cAliasDoc)->(Eof())
		
		//Busca Forma de Pagamento e e-mail
		//*********************************
		cMsg := ""
		aDadosMail := BSCMAIL((cAliasDoc)->F2_SERIE,(cAliasDoc)->F2_DOC,(cAliasDoc)->A1_NOME)
		
		cMailTo := aDadosMail[01]
		cFrmPgt	:= aDadosMail[02]
		
		If !"@" $ cMailTo
			cMsg := cMailTo
			cMailTo := Lower(SuperGetMv("IM_MAILNC",.F.,""))
		EndIf
		
		Do Case
			Case (cFrmPgt == "1")
				cFrmPgt := "Boleto"
			Case (cFrmPgt == "2")
				cFrmPgt := "Depósito"
			Otherwise
				cFrmPgt := "N/C"
		EndCase
		
		Do Case
			Case ((cAliasDoc)->F2_XENVBOL == "S")
				cEnvBol := "S"
			Otherwise
				cEnvBol := "N"
		EndCase
		//*********************************
		
		aAdd(aListDoc,	{;
							.T.,;
							cEnvBol,;
							(cAliasDoc)->F2_SERIE,;
							(cAliasDoc)->F2_DOC,;
							(cAliasDoc)->F2_CLIENTE,;
							(cAliasDoc)->F2_LOJA,;
							AllTrim((cAliasDoc)->A1_NOME),;
							cFrmPgt,;
							AllTrim((cAliasDoc)->F2_NFELETR),;
							AllTrim((cAliasDoc)->F2_CODNFE),;
							AllTrim(cMailTo),;
							(cAliasDoc)->REGNO;
						})
		(cAliasDoc)->(dbSkip())
	EndDo
	
	(cAliasDoc)->(dbCloseArea())
	
	If Len(aListDoc) = 0
		aAdd(aListDoc,	{;
			.F.,;
			"",;
			"",;
			"",;
			"",;
			"",;
			"SEM BOLETOS PARA IMPRIMIR",;
			"",;
			"",;
			"";
			})
	EndIf
	
	oListDoc:SetArray(aListDoc)
	
	oListDoc:bLine:={||{;
		If(aListDoc[oListDoc:nAt,nPosMark],oOk,oNo),;
		If(aListDoc[oListDoc:nAt,nPosEnv] == "S",oVd,oVm),;
		aListDoc[oListDoc:nAt,nPosSer],;
		aListDoc[oListDoc:nAt,nPosDoc],;
		aListDoc[oListDoc:nAt,nPosCli],;
		aListDoc[oListDoc:nAt,nPosLoja],;
		aListDoc[oListDoc:nAt,nPosNome],;
		aListDoc[oListDoc:nAt,nPosFPg],;
		aListDoc[oListDoc:nAt,nPosNFSe],;
		aListDoc[oListDoc:nAt,nPosCod];
		}}
	
	oListDoc:Refresh()
	
	QTDSEL()

Return()

/*/{Protheus.doc} GeraBol
Função para montar o objeto do relatorio e buscar os dados do titulo
@type function
@author Mario Faria
@since 14/03/2016
@version 1.0
@param lEnd, ${param_type}, (Descrição do parâmetro)
/*/Static Function GeraBol(lEnd)

	Local nX 		:= 0
	Local cNomeRel  := ""
	Local cDadBol	:= ""
	Local cDirPdf 	:= "C:\TEMP\"
	Local lBordero 	:= .T.
	Local aAliasSE1	:= {}
	
	Local cCodProc	:= FunName()
	Local cDescr	:= "Fatura"
	Local cAssunto	:= "Fatura"
	Local cMailTo	:= ""
	Local cArqHtml	:= "\workflow\mailboleto.htm"
	Local cArqAnexo	:= ""
	Local aAnexos	:= {}
	Local aDadMail	:= {}

//Alteração Mário Faria - 2018.07.03
//Alterado: declaração de variáveis
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*	
	Local aBoleto	:= {}
	Local aEnvMail	:= {}
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	
	Local cMsg		:= ""
	Local cNomeLog	:= ""
	Local cCidCob	:= ""
	Local nGera		:= 0
	
	Private oBoleto := Nil
	Private aLog	:= {}
	
	If Aviso("Envio de Fatura por E-mail","Confirma o envio das faturas selecionadas por e-mail?",{"Sim","Não"},2) == 2
		Return()
	EndIf
	
	dbSelectArea("SEE")
	SEE->(dbSetOrder(1))
	
	dbSelectArea("SE1")
	SE1->(dbSetOrder(1))
	
	dbSelectArea("SA1")
	SA1->(dbSetOrder(1))
	
	If !ExistDir(cDirPdf)
		MakeDir(cDirPdf)
	EndIf
	
	ProcRegua(0)
	
	IncProc("Analisando Dados...")
	
	For nX := 1 to Len(aListDoc)
		
		lEnvia		:= .T.
		aAnexos		:= {}
		
		//Imprime somente os selecionados
		If aListDoc[nX,nPosMark]
			
			nGera++
			
			cDadBol 	:= ""
			cNomeRel 	:= ""
			cArqAnexo	:= ""
			cDirPdf 	:= "C:\TEMP\"
			
			/* Incluído em 17.08.2016 - Funaki (GoLive) */
			/* Se for Curitiba, chama a função para geração da DANFE de serviços para enviar junto com o boleto */
			_lContinua := .T.
			cCidCob := Upper(AllTrim(NoAcento(SM0->M0_CIDCOB)))
			If cCidCob == "CURITIBA"
				_cPDFNf := U_R0502({aListDoc[nX,nPosDoc],aListDoc[nX,nPosSer]})
				
				If Empty(_cPDFNf)
					_lContinua := .F.
					lEnvia := .F.
				Endif
			Endif
			/* 17.08.2016 - Fim da alteração - Funaki (GoLive) */
			
			If AllTrim(aListDoc[nX,nPosFPg]) == "Boleto" .And. _lContinua
			
				cQuery := "	SELECT " + CRLF
				cQuery += "		E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, " + CRLF
				cQuery += "		E1_CLIENTE, E1_LOJA, " + CRLF
				cQuery += "		E1_PORTADO, E1_AGEDEP, E1_CONTA " + CRLF
				cQuery += "	FROM " + RetSqlName("SE1") + " " + CRLF
				cQuery += "	WHERE " + CRLF
				cQuery += "			E1_FILIAL = '" + xFilial("SE1") + "' " + CRLF
				cQuery += "		AND E1_PREFIXO = '" + aListDoc[nX,nPosSer] + "' " + CRLF
				cQuery += "		AND E1_NUM = '" + aListDoc[nX,nPosDoc] + "' " + CRLF
				cQuery += "		AND E1_TIPO = 'NF' " + CRLF
				cQuery += "		AND E1_SALDO > 0 " + CRLF
				cQuery += "		AND D_E_L_E_T_ = ' ' " + CRLF
				cQuery += "	ORDER BY E1_PREFIXO, E1_NUM, E1_PARCELA " + CRLF
				
				aAliasSE1	:= GetNextAlias()
				TCQuery cQuery New Alias (aAliasSE1)
				
				//Verifica se todos os titulos que geram boleto estão em bordero
				lBordero := .T.
				While !(aAliasSE1)->(Eof())
					If Empty((aAliasSE1)->E1_PORTADO)
						lBordero := .F.
						Exit
					EndIf
					
					(aAliasSE1)->(dbSkip())
				EndDo
				
				(aAliasSE1)->(dbGoTop())
				
				lEnvia := .T.
				If !lBordero
					
					aAdd(aLog,	{;
									aListDoc[nX,nPosSer],;	//[01] - Serie/Prefixo
									aListDoc[nX,nPosDoc],;	//[02] - Documento/Titulo
									"",;					//[03] - Parcela
									aListDoc[nX,nPosCli],;	//[04] - Código Cliente
									aListDoc[nX,nPosLoja],;	//[05] - Loja Cliente
									aListDoc[nX,nPosNome],;	//[06] - Nome Cliente
									aListDoc[nX,nPosNFSe],;	//[07] - Numero NFS-e
									"Título sem borderô. Enviado somente link para NFS-e";	//[08] - Mensagem
								})
					
				EndIf
				
				IncProc("Processando Título: " + AllTrim(aListDoc[nX,nPosDoc]) + " - " + cValToChar(nGera) + "/" + cValToChar(nQtdReg))
				
				If lBordero
					cNomeRel	:= "BOL_" + AllTrim(aListDoc[nX,nPosSer]) + "_" + AllTrim(aListDoc[nX,nPosDoc]) + "_" + DtoS(Date()) + "_"  + StrTran(Time(),":","")
					oBoleto 	:= FWMSPrinter():New(cNomeRel,IMP_PDF,.F.,cDirPdf,.T.,,,,,.F.,,.F.,1)
					oBoleto:lViewPdf := .F.
					oBoleto:cPathPDF := cDirPdf

					While !(aAliasSE1)->(Eof())
						
						SEE->(dbGoTop())
						SEE->(dbSeek(xFilial("SEE") + (aAliasSE1)->(E1_PORTADO + E1_AGEDEP + E1_CONTA)))
						
						SE1->(dbGoTop())
						SE1->(dbSeek(xFilial("SE1") + (aAliasSE1)->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)))
						
						SA1->(dbGoTop())
						SA1->(dbSeek(xFilial("SA1") + (aAliasSE1)->(E1_CLIENTE + E1_LOJA)))
						
						Do Case
							
							Case (aAliasSE1)->E1_PORTADO == "237" //Banco HSBC
								U_RBol237(oBoleto, .F.)
								
							Case (aAliasSE1)->E1_PORTADO == "399" //Banco HSBC
								U_RBol399(oBoleto, .F.)
								
							Case (aAliasSE1)->E1_PORTADO == "341" //Banco Itau
								U_RBol341(oBoleto, .F.)
							
						Otherwise
							aAdd(aLog,	{;
											aListDoc[nX,nPosSer],;		//[01] - Serie/Prefixo
											aListDoc[nX,nPosDoc],;		//[02] - Documento/Titulo
											(aAliasSE1)->E1_PARCELA,;	//[03] - Parcela
											aListDoc[nX,nPosCli],;		//[04] - Código Cliente
											aListDoc[nX,nPosLoja],;		//[05] - Loja Cliente
											aListDoc[nX,nPosNome],;		//[06] - Nome Cliente
											aListDoc[nX,nPosNFSe],;		//[07] - Numero NFS-e
											"Banco " + AllTrim((aAliasSE1)->E1_PORTADO) + " não configurado para impressão de boleto.";	//[08] - Mensagem
										})
							
							lEnvia := .F.
						EndCase
						
						(aAliasSE1)->(dbSkip())
						
					EndDo
					
					(aAliasSE1)->(dbCloseArea())
					
					oBoleto:EndPage()
					oBoleto:Print()

					__CopyFile(cDirPdf+cNomeRel+".PDF", "\_BOLETO_PDF\"+cNomeRel+".PDF",,,.F.)

					CPYT2S(cDirPdf+cNomeRel+".PDF","\_BOLETO_PDF\",.T.)

					cDirPdf := "\_BOLETO_PDF\"

					cDadBol := "Segue anexo boleto referente a NFS-e: " + AllTrim(aListDoc[nX,nPosNFSe]) + "."
				EndIf
			EndIf
			
			//Envia Workflow
			//***********************************************************
			If lEnvia
				cMailTo := Lower(aListDoc[nX,nPosMail])
				
				If !Empty(cMailTo)

					IncProc("Enviando e-mail Título: " + AllTrim(aListDoc[nX,nPosDoc]) + " - " + cValToChar(nGera) + "/" + cValToChar(nQtdReg))
					
					//Gera link para NFS-e
					//*******************************************
					cCidCob := Upper(AllTrim(NoAcento(SM0->M0_CIDCOB)))
					Do Case
					Case cCidCob == "CURITIBA"
						cLinkImpr :=  "http://isscuritiba.curitiba.pr.gov.br/portalnfse/Default.aspx?doc=" +;
						AllTrim(SM0->M0_CGC) + "&num=" + AllTrim(aListDoc[nX,nPosNFSe]) + "&cod=" + AllTrim(aListDoc[nX,nPosCod])
					Case cCidCob == "SAO JOSE DOS PINHAIS"
						cLinkImpr := "https://nfe.sjp.pr.gov.br/servicos/validarnfse/validar.php?CCM=" +;
						AllTrim(SM0->M0_INSCM) + "&verificador=" + AllTrim(aListDoc[nX,nPosCod]) + "&nrnfs=" + AllTrim(SubStr(aListDoc[nX,nPosNFSe],5,Len(aListDoc[nX,nPosNFSe])))
					OtherWise
						cLinkImpr := ""
					EndCase
					//*******************************************
					
					If !Empty(cNomeRel)
						cArqAnexo := cDirPdf + AlLTrim(cNomeRel) + ".PDF"
					Else
						cArqAnexo := ""
					EndIf
					
					aAnexos := {}
					aAdd(aAnexos,cArqAnexo)
					
					If (cCidCob == "CURITIBA")
						aAdd(aAnexos,_cPDFNf)
					EndIf
					
					//aAdd(aAnexos,"\workflow\cabec.jpg")
					//aAdd(aAnexos,"\workflow\rodape.jpg")
					
					aDadMail := {}
					aAdd(aDadMail,cLinkImpr)
					aAdd(aDadMail,cDadBol)
					aAdd(aDadMail,cMsg)
					
					cAssunto := "Fatura da nota fiscal " + AllTrim(aListDoc[nX,nPosNFSe])

//Alteração Mário Faria - 2018.07.03
//Alterado: 
//	1º gera todos os PDf's de nota e boleto e guarda dados em um array
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*	 Inicio			
					aBoleto := {}
					aAdd(aBoleto,cCodProc)
					aAdd(aBoleto,cDescr)
					aAdd(aBoleto,cAssunto)
					aAdd(aBoleto,cMailTo)
					aAdd(aBoleto,cArqHtml)
					aAdd(aBoleto,aAnexos)
					aAdd(aBoleto,aDadMail)
					aAdd(aBoleto,aListDoc[nX,nPosFPg])
					aAdd(aBoleto,aListDoc[nX,nPosSer])
					aAdd(aBoleto,aListDoc[nX,nPosDoc])
					aAdd(aBoleto,aListDoc[nX,nPosCli])
					aAdd(aBoleto,aListDoc[nX,nPosLoja])
					aAdd(aBoleto,aListDoc[nX,nPosNome])
					aAdd(aBoleto,aListDoc[nX,nPosNFSe])
					aAdd(aBoleto,aListDoc[nX,nPosRegno])
					
					aAdd(aEnvMail,aBoleto)

				EndIf
			EndIf
			//***********************************************************
			
			IncProc("Gerando Boleto...")
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* Fim
			
		EndIf	
	Next nX

//Alteração Mário Faria - 2018.07.03
//Alterado: 
//	2º Envia o e-mail conforme arry criado acima
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*	Inicio
	Sleep(5000)
	
	For nX := 1 to Len(aEnvMail)
	
		ENVMAIL(	aEnvMail[nX,01],;	//cCodProc,;
					aEnvMail[nX,02],;	//cDescr,;
					aEnvMail[nX,03],;	//cAssunto,;
					aEnvMail[nX,04],;	//cMailTo,;
					aEnvMail[nX,05],;	//cArqHtml,;
					aEnvMail[nX,06],;	//aAnexos,;
					aEnvMail[nX,07],;	//aDadMail,;
					aEnvMail[nX,08],;	//aListDoc[nX,nPosFPg],;
					aEnvMail[nX,09],;	//aListDoc[nX,nPosSer],;
					aEnvMail[nX,10],;	//aListDoc[nX,nPosDoc],;
					aEnvMail[nX,11],;	//aListDoc[nX,nPosCli],;
					aEnvMail[nX,12],;	//aListDoc[nX,nPosLoja],;
					aEnvMail[nX,13],;	//aListDoc[nX,nPosNome],;
					aEnvMail[nX,14])	//aListDoc[nX,nPosNFSe])
					
					SF2->(dbGoTo(aEnvMail[nX,15]))
				
					RecLock("SF2",.F.)
					SF2->F2_XENVBOL := "S"
					SF2->(MsUnlock())					

		IncProc("Enviando Email...")
					
	Next nX
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* Fim 
	
	//Gera LOG
	If Len(aLog) > 0
		IncProc("Gerando Log...")
		cNomeLog := GravaLog()
	EndIf
	
	//RESET ENVIRONMENT

Return()

/*/{Protheus.doc} GravaLog
Função para gravar LOG
@type function
@author Mario Faria
@since 25/04/2016
@version 1.0
@history Rafael Ricardo Vieceli, 04/08/2018, Alterado para salvar no servidro
/*/
Static Function GravaLog()

	Local nX		:= 0
	Local cDirLog	:= "\LogsBoletos\"
	Local cNomeLog	:= "BOLETO_"+cFilAnt+"_"+cUserName+"_" + DtoS(dDatabase) + "_" + StrTran(Time(),":","") + ".log"
	
	If ! ExistDir(cDirLog)
		FWMakeDir(cDirLog)
	EndIf
	
	cPath := Alltrim(cDirLog) + AllTrim(cNomeLog)
	
	nHdl := fCreate(cPath)
	If (nHdl < 0)
		Alert("Problema ao gerar arquivo de Log" + cPath + "." + CRLF + Str(fError()))
		Return()
	EndIf
	
	cCabec := " " + PadR("Serie/Prefixo",15) + " | " +;
		PadR("Doc/Titulo",10) + " | " +;
		PadR("Parcela",07) + " | " +;
		PadR("Cliente/Loja/Nome",30) + " | " +;
		PadR("NFS-e ",20) + " | " +;
		"Mensagem " + CRLF
	
	//Grava cabeçalho
	fWrite(nHdl, cCabec, Len(cCabec))
	
	For nX := 1 to Len(aLog)
		
		cLinha := " " + 	PadR(aLog[nX,01],15) + " | " +;		//[01] - Serie/Prefixo
							PadR(aLog[nX,02],10) + " | " +;     //[02] - Doc/Titulo
							PadR(aLog[nX,03],07) + " | " +;     //[03] - Parcela
							SubStr(aLog[nX,04] + "-" + aLog[nX,05] + "-" + PadR(AllTrim(aLog[nX,06]),32),1,30) + " | " +;
							PadR(aLog[nX,07],20) + " | " +;     //[07] - NFS-e
							AllTrim(aLog[nX,08]) + CRLF			//[08] - Mensagem
		
		//Grava linha
		fWrite(nHdl, cLinha, Len(cLinha))
		
	Next nX
	
	fClose(nHdl)

Return(cDirLog + cNomeLog)

/*/{Protheus.doc} BSCMAIL
Função para buscar o e-mail do contrato
@type function
@author Mario Faria
@since 22/03/2016
@version 1.0
/*/Static Function BSCMAIL(cSerie,cDoc,cCliente)

	Local aRet 		:= {}
	Local cMsg		:= ""
	Local lAchou	:= .T.

	Local cQuery	:= ""
	Local aAliasCon	:= ""
	Local aAliasPla	:= ""
	Local cFilCtr	:= SupergetMV("IM_FILCTR",.F.,"010101")

	
	//Busca endereço de email na planilha - Nova Medição IMTEP
	//**************************************************************
	cQuery := "	SELECT TOP 1 " + CRLF
	cQuery += "		CNA_XMAIL, CNA_XMAIL2, CNA_XFORPG " + CRLF
	cQuery += "	FROM " + RetSqlName("SD2") + " SD2 " + CRLF 
	cQuery += "	INNER JOIN " + RetSqlName("SF2") + " SF2 ON " + CRLF
	cQuery += "			F2_FILIAL = D2_FILIAL " + CRLF
	cQuery += "		AND F2_DOC    = D2_DOC " + CRLF
	cQuery += "		AND F2_SERIE  = D2_SERIE " + CRLF
	cQuery += "		AND SF2.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "	INNER JOIN " + RetSqlName("SC5") + " SC5 ON  " + CRLF
	cQuery += "			C5_FILIAL = D2_FILIAL " + CRLF
	cQuery += "		AND C5_NUM    = D2_PEDIDO " + CRLF
	cQuery += "		AND SC5.D_E_L_E_T_ = ' ' " + CRLF 
	cQuery += "	INNER JOIN " + RetSqlName("CN9") + " CN9 ON " + CRLF
	cQuery += "			CN9_FILIAL = '" + cFilCtr + "' " + CRLF
	cQuery += "		AND CN9_NUMERO = C5_MDCONTR " + CRLF
	cQuery += "		AND CN9_SITUAC = '05' " + CRLF
	cQuery += "		AND CN9.D_E_L_E_T_ = ' ' " + CRLF 
	cQuery += "	INNER JOIN " + RetSqlName("SZD") + " SZD ON " + CRLF
	cQuery += "			ZD_FILIAL = C5_FILIAL " + CRLF
	cQuery += "		AND ZD_CONTRA = C5_MDCONTR " + CRLF
	cQuery += "		AND ZD_REVISA = CN9_REVISA " + CRLF
	cQuery += "		AND ZD_MEDCND = C5_MDNUMED " + CRLF
	cQuery += "		AND SZD.D_E_L_E_T_ = ' ' " + CRLF 
	cQuery += "	INNER JOIN " + RetSqlName("SZE") + " SZE ON " + CRLF
	cQuery += "			ZE_FILIAL = ZD_FILIAL " + CRLF
	cQuery += "		AND ZE_NUMMED = ZD_NUMMED " + CRLF
	cQuery += "		AND ZE_REVISA = ZD_REVISA " + CRLF
	cQuery += "		AND ZE_QUANT  > 0 " + CRLF
	cQuery += "		AND SZE.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "	INNER JOIN " + RetSqlName("CNA") + " CNA ON " + CRLF
	cQuery += "			CNA_FILIAL = ZD_FILCTR " + CRLF
	cQuery += "		AND CNA_CONTRA = ZD_CONTRA " + CRLF
	cQuery += "		AND CNA_REVISA = ZD_REVISA " + CRLF
	cQuery += "		AND CNA_NUMERO = ZE_NUMERO " + CRLF
	cQuery += "		AND CNA.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "	WHERE " + CRLF 
	cQuery += "			D2_FILIAL = '" + xFilial("SD2") + "' " + CRLF
	cQuery += "		AND D2_SERIE =	'" + cSerie + "' " + CRLF
	cQuery += "		AND D2_DOC = '" + cDoc + "' " + CRLF
	cQuery += "		AND SD2.D_E_L_E_T_ = ' ' " + CRLF

	cQuery := ChangeQuery(cQuery)
	aAliasPla := MPSysOpenQuery(cQuery)

	If !(aAliasPla)->(Eof()) 
		If !Empty((aAliasPla)->CNA_XMAIL) .Or. !Empty((aAliasPla)->CNA_XMAIL2) 
			aAdd(aRet,AllTrim((aAliasPla)->CNA_XMAIL) + If(!Empty((aAliasPla)->CNA_XMAIL2),";" + AllTrim((aAliasPla)->CNA_XMAIL2),""))
			aAdd(aRet,AllTrim((aAliasPla)->CNA_XFORPG))
			lAchou := .T.
		Else
			lAchou := .F.
		EndIf
	Else
		lAchou := .F.
	EndIf

	(aAliasPla)->(dbCloseArea())
	//**************************************************************

	//Se não achou email na planilha busca no contrato
	//Medição padrão Protheus - Forma antiga de medição
	//**************************************************************
	If !lAchou

		cQuery := "	SELECT TOP 1 " + CRLF
		cQuery += "		CN9_EMAIL, CN9_EMAIL2, CN9_XFORPG " + CRLF
		cQuery += "	FROM " + RetSqlName("SD2") + " SD2 " + CRLF
		cQuery += "	INNER JOIN " + RetSqlName("SC5") + " SC5 ON " + CRLF
		cQuery += "			C5_FILIAL = '" + xFilial("SC5") + "' " + CRLF
		cQuery += "		AND C5_NUM = D2_PEDIDO " + CRLF
		cQuery += "		AND SC5.D_E_L_E_T_ = ' ' " + CRLF
		cQuery += "	INNER JOIN " + RetSqlName("CN9") + " CN9 ON " + CRLF
		cQuery += "			CN9_FILIAL = '" + xFilial("CN9") + "' " + CRLF
		cQuery += "		AND CN9_NUMERO = C5_MDCONTR " + CRLF
		cQuery += "		AND CN9.D_E_L_E_T_ = ' ' " + CRLF
		cQuery += "	WHERE " + CRLF
		cQuery += "			D2_FILIAL = '" + xFilial("SD2") + "' " + CRLF
		cQuery += "		AND D2_SERIE =	'" + cSerie + "' " + CRLF
		cQuery += "		AND D2_DOC = '" + cDoc + "' " + CRLF
		cQuery += "		AND SD2.D_E_L_E_T_ = ' ' " + CRLF
		cQuery += "		ORDER BY CN9_REVISA DESC " + CRLF

		cQuery := ChangeQuery(cQuery)
		aAliasCon := MPSysOpenQuery(cQuery)
		
		If !(aAliasCon)->(Eof()) 
			If !Empty((aAliasCon)->CN9_EMAIL) .Or. !Empty((aAliasCon)->CN9_EMAIL2)
				aAdd(aRet,AllTrim((aAliasCon)->CN9_EMAIL) + If(!Empty((aAliasCon)->CN9_EMAIL2),";" + AllTrim((aAliasCon)->CN9_EMAIL2),""))
				aAdd(aRet,AllTrim((aAliasCon)->CN9_XFORPG))
				lAchou := .T.
			Else
				lAchou := .F.
			EndIf
		Else
			lAchou := .F.
		EndIf

		(aAliasCon)->(dbCloseArea())

	EndIf
	//**************************************************************

	//Se não achou email na planilha nem no contrato
	//Busca no contrado considerando a filial da Nova Medição IMTEP 
	//**************************************************************
	If !lAchou

		cQuery := "	SELECT TOP 1 " + CRLF
		cQuery += "		CN9_EMAIL, CN9_EMAIL2, CN9_XFORPG " + CRLF
		cQuery += "	FROM " + RetSqlName("SD2") + " SD2 " + CRLF
		cQuery += "	INNER JOIN " + RetSqlName("SC5") + " SC5 ON " + CRLF
		cQuery += "			C5_FILIAL = '" + xFilial("SC5") + "' " + CRLF
		cQuery += "		AND C5_NUM = D2_PEDIDO " + CRLF
		cQuery += "		AND SC5.D_E_L_E_T_ = ' ' " + CRLF
		cQuery += "	INNER JOIN " + RetSqlName("CN9") + " CN9 ON " + CRLF
		cQuery += "			CN9_FILIAL = '" + cFilCtr + "' " + CRLF
		cQuery += "		AND CN9_NUMERO = C5_MDCONTR " + CRLF
		cQuery += "		AND CN9.D_E_L_E_T_ = ' ' " + CRLF
		cQuery += "	WHERE " + CRLF
		cQuery += "			D2_FILIAL = '" + xFilial("SD2") + "' " + CRLF
		cQuery += "		AND D2_SERIE =	'" + cSerie + "' " + CRLF
		cQuery += "		AND D2_DOC = '" + cDoc + "' " + CRLF
		cQuery += "		AND SD2.D_E_L_E_T_ = ' ' " + CRLF
		cQuery += "		ORDER BY CN9_REVISA DESC " + CRLF

		cQuery := ChangeQuery(cQuery)
		aAliasCon := MPSysOpenQuery(cQuery)
		
		If !(aAliasCon)->(Eof()) 
			If !Empty((aAliasCon)->CN9_EMAIL) .Or. !Empty((aAliasCon)->CN9_EMAIL2)
				aAdd(aRet,AllTrim((aAliasCon)->CN9_EMAIL) + If(!Empty((aAliasCon)->CN9_EMAIL2),";" + AllTrim((aAliasCon)->CN9_EMAIL2),""))
				aAdd(aRet,AllTrim((aAliasCon)->CN9_XFORPG))
				lAchou := .T.
			Else
				lAchou := .F.
			EndIf
		Else
			lAchou := .F.
		EndIf

		(aAliasCon)->(dbCloseArea())

	EndIf
	//**************************************************************

	If !lAchou
		cMsg := "Não existe contrato para o documento de saída série " + AllTrim(cSerie) + ", número " + AllTrim(cDoc) + "."
		Aviso("Envio de Fatura por E-mail",cMsg,{"Ok"},2)
		cMsg := cMsg + CRLF
		cMsg += "Cliente: " + AllTrim(cCliente)
		aAdd(aRet,cMsg)
		aAdd(aRet,"")
	EndIf
	
	

Return(aRet)

/*/{Protheus.doc} ENVMAIL
Função para enviar e-mail
@type function
@author Mario Faria
@since 22/03/2016
@version 1.0
@param cCodProc, character, Nome do Processo
@param cDescr, character, Descrição do processo
@param cAssunto, character, Assunto do Email
@param cMailTo, character, e-mail do destinatário
@param cArqHtml, character, Arquivo do corpo do e-mail
@param aAnexos, array, Array com os anexo
@param aDadMail, array, Array com o dados para o e-mail
@param cFrmPag, character, Forma de Pagamento
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/Static Function ENVMAIL(cCodProc,cDescr,cAssunto,cMailTo,cArqHtml,aAnexos,aDadMail,cFrmPag,cSerDoc,cNumDoc,cClie,cLoja,cNomCli,cNFSe)
	Local cServer		:= GETMV("MV_RELSERV")
	Local cAccount		:= GETMV("MV_RELACNT")
	Local cPassword		:= GETMV("MV_RELPSW")
	Local lAutentica	:= GETMV("MV_RELAUTH")
	Local nPorta		:= Nil	//465
	Local cMailTeste	:= Lower(SuperGetMv("IM_MAILTES",.F.,""))//UTILIZAR O PRREENCHIMENTO DESTE PARAMETRO SOMENTE PARA TESTE.
	Local cMailHid		:= Lower(SuperGetMv("IM_MAILHID",.F.,""))//UTILIZAR O PREENCHIMENTO DESTE PARAMETRO SOMENTE PARA CÓPIA OCULTA.
	local lOK			:= .T.

	//PREENCHE REMETENTE COM ENDEREÇO TESTE.
	If !Empty(cMailTeste)
		cMailTo := cMailTeste
	EndIf
	
	//Separa o endereço e a porta do servidor
	_nPos := AT(":",cServer)
	If _nPos > 0
		nPorta := Val(Substr(cServer,_nPos + 1,Len(Alltrim(cServer))))
		cServer := Substr(cServer,1,_nPos-1)
	Endif

	oMail := TMailManager():NEW()
	nRet := 0
	
	oMail:Init("", cServer, cAccount, cPassword,,nPorta)
	oMail:SetSMTPTimeout(60)
	nRet := oMail:SMTPConnect()
	
	If nRet != 0
		conout(oMail:GetErrorString(nRet))
		
		If (nRet == 52)
			_cMsg := "Conexão com SMTP Falhou. Código do erro: 52 - Verique com a T.I"
		ElseIf (nRet == 86)
			_cMsg := "Conexão com Servidor Falhou. Usuário ou Senha inválidos. Código do erro: 86"
		Else
			 _cMsg := "Código de erro ainda não definido. Código do erro: " + Alltrim(Str(nRet))
		EndIf
		  
		aAdd(aLog,	{;
						cSerDoc,;	//[01] - Serie/Prefixo
						cNumDoc,;	//[02] - Documento/Titulo
						"",;		//[03] - Parcela
						cClie,;		//[04] - Código Cliente
						cLoja,;		//[05] - Loja Cliente
						cNomCli,;	//[06] - Nome Cliente
						cNFSe,;		//[07] - Numero NFS-e
						"Erro ao conectar o e-mail - Verifique com a T.I - " + Alltrim(_cMsg) + " - " + oMail:GetErrorString(nRet) + ".";	//[08] - Mensagem
					})	
		Return()
	Endif
	
	If lAutentica
		nErro := oMail:SmtpAuth(cAccount, cPassword)	
		If nErro <> 0
			conout("ERROR:" + oMail:GetErrorString(nErro))
			//Memowrit("C:\LOGS_ENVIOS\Erro_"+SF2->F2_NFELETR+".SQL","Erro ao autenticar o e-mail: " + nErro)
			oMail:SMTPDisconnect()
			Return(.F.)
		Endif
	Endif
	
	//APÓS CONECTAR, CRIA OBJETO DA MENSAGEM.
	oMessage := TMailMessage():New()
	
	//MONTA MENSAGEM.
	cMsg := "<html> "
	cMsg += "<head> "
	cMsg += "		<meta http-equiv='Content-Type' content='text/html; charset=ISO-8859-1'> "
	cMsg += "		<meta name='GENERATOR' content='Microsoft FrontPage Express 2.0'> "
	cMsg += "		<title>Boleto</title> "
	cMsg += "	</head> "
	cMsg += "	<body> "
	cMsg += "		<table width='144' border='0' align='center' cellpadding='1' cellspacing='1'> "
//	cMsg += "			<tr> "
//	cMsg += "				<td width='100%' class='left-14'><div align='center'><img src='http://www.imtep.com.br/Imagens/imtep_templateemail_v4_topo.png' width='551' height='147' alt=''></div></td> "
//	cMsg += "			</tr> "
//	cMsg += "			<tr> "
///	cMsg += "				<td> "
//	cMsg += "					<font size='2' face='Arial' color='red'><b>%cMsg%</b></font><br><br> "
//	cMsg += "				</td> "
//	cMsg += "			</tr> "
	cMsg += "			<tr> "
	cMsg += "				<td> "
	cMsg += "					<p><font size='2' face='Arial'> "
	cMsg += "						Prezado Cliente,<br><br> "
//	cMsg += "						Clique <a href="+aDadMail[01]+">aqui</a> para imprimir a NFS-e<br><br> "
//	cMsg += "						%cBoleto%?</font> "
	cMsg += "						Selecione o endereço abaixo e cole em seu navegador para imprimir a NFS-e<br><br> "
	cMsg += "						"+aDadMail[01]+""	
	cMsg += "					</p> "
	cMsg += "					<p><font size='2' face='Arial'> "
	cMsg += "						Informamos que o relat&oacute;rio de fatura encontra-se dispon&iacute;vel no SOC. Caso voc&ecirc; n&atilde;o tenha acesso, entre em contato com: aldrey.costa&#64;imtep.com.br</font>"
	cMsg += "					</p> "
	cMsg += "					<p><font size='2' face='Arial'> "
	cMsg += "						Na hip&oacute;tese de n&atilde;o receber algum dos documentos, pedimos que entre em contato atrav&eacute;s do e-mail: contasareceber&#64;imtep.com.br</font> "
	cMsg += "					</p> "
	cMsg += "					<p><font size='2' face='Arial'> "
	cMsg += "						<b>Obs:</b> Importante que os endere&ccedil;os de e-mail cadastrados, estejam sempre atualizados. Essa atualiza&ccedil;&atilde;o pode ser feita atrav&eacute;s do e-mail: nucleodecadastro&#64;imtep.com.br</font> "
	cMsg += "					</p> "
	cMsg += "					<p><font size='2' face='Arial'> "
	cMsg += "						Cordialmente,</font> "
	cMsg += "					</p> "
	cMsg += "				</td> "
	cMsg += "			</tr> "
//	cMsg += "			<tr> "
//	cMsg += "			   <td width='100%' class='left-1'><div align='center'><img src='http://www.imtep.com.br/Imagens/imtep_templateemail_v4_rodape.png' width='552' height='144' alt=''></div></td> "
//	cMsg += "			</tr> "
	cMsg += "		</table> "
	cMsg += "	</body> "
	cMsg += "</html> "
	
	//LIMPA OBJETO.
	oMessage:Clear()
	
	//PREENCHE OBJETOS DE ENVIO.
	oMessage:cFrom              := cAccount
	oMessage:cTo                := cMailTo
	oMessage:cCc                := ""
	oMessage:cBcc               := cMailHid
	oMessage:cSubject 	        := cAssunto
	oMessage:cBody              := cMsg
	
	//Adiciona um attach
	For _nX := 1 To Len(aAnexos)
		If oMessage:AttachFile(aAnexos[_nX]) < 0
			Conout( "Erro ao carregar o arquivo: " + Alltrim(STR(_nX)))
			//Memowrit("C:\LOGS_ENVIOS\Erro_"+SF2->F2_NFELETR+".SQL","Erro ao carregar o arquivo: " + Alltrim(STR(_nX)))
		Else
			//TAG INFORMANDO O NOME DO ARQUIVO.
			oMessage:AddAtthTag( 'Content-Disposition: attachment; filename=' + Alltrim(STRTRAN(STRTRAN(aAnexos[_nX],"\Temp\"),"\SPOOL\")))
		EndIf
	Next _nX
	
	//ENVIA O E-MAIL
	_nRet := oMessage:Send( oMail )
	If _nRet != 0
		Conout( "Erro ao enviar o e-mail" )
		
		If (_nRet == 67)
			_cMsg := "A conta destino informada não existe. Código do erro: 67"
		ElseIf (_nRet == 52)
			_cMsg := "Conexão com SMTP Falhou. Código do erro: 52 - Verique com a T.I"
		Else
			_cMsg := "Código de erro ainda não definido. Código do erro: " + Alltrim(Str(_nRet))
		EndIf
			
		aAdd(aLog,	{;
						cSerDoc,;	//[01] - Serie/Prefixo
						cNumDoc,;	//[02] - Documento/Titulo
						"",;		//[03] - Parcela
						cClie,;		//[04] - Código Cliente
						cLoja,;		//[05] - Loja Cliente
						cNomCli,;	//[06] - Nome Cliente
						cNFSe,;		//[07] - Numero NFS-e
						"Erro ao enviar o e-mail - Verifique a situação - "+Alltrim(_cMsg)+".";	//[08] - Mensagem
					})
		Return(.F.)
	EndIf
	
	oMail:SmtpDisconnect()

Return(lOK)

/*/{Protheus.doc} TROCA
Função para inverter a seleção
@type function
@author Mario Faria
@since 14/03/2016
@version 1.0
@param nIt, numérico, (Descrição do parâmetro)
/*/Static Function TROCA(nIt)
	
	aListDoc[nIt,nPosMark] := !aListDoc[nIt,nPosMark]
	QTDSEL()

Return()

/*/{Protheus.doc} INVERTE
Função para inverter a marcação do MB
@type function
@author Mario Faria
@since 29/03/2016
@version 1.0
@param aVetor, array, (Descrição do parâmetro))
/*/Static Function INVERTE()

	Local nX 		:= 1
	Local lMarca	:= !aListDoc[1,nPosMark]
	
	For nX := 1 to Len(aListDoc)
		aListDoc[nX,nPosMark] := lMarca
	Next nX
	QTDSEL()

Return()

/*/{Protheus.doc} QTDSEL
Função para contar os selecionados
@type function
@author Mario Faria
@since 05/04/2016
/*/Static Function QTDSEL()
	
	Local nX	  := 0
	Local nQtdSel := 0
	
	For nX := 1 to Len(aListDoc)
		If aListDoc[nX,nPosMark]
			nQtdSel++
		EndIf
	Next nX
	
	nQtdReg	:= nQtdSel
	
	oQtdSel:SetText(cValToChar(nQtdSel))

Return()

/*/{Protheus.doc} AFIN01SH
Função para reprocessar Workflow, executada via schedule
@type function
@author Mario Faria
@since 27/04/2016
@version 1.0
@param aParam, array, Dados das filiais que irá reprocessar
/*/User Function AFIN01SH(aParam)

	PREPARE ENVIRONMENT EMPRESA aParam[1] FILIAL aParam[2]
	Conout("[" + DtoC(Date()) + " - "  + Time() + "] - [AFIN01SH] Reprocessamento WF - Grupo: " + AllTrim(SM0->M0_NOME) + " Empresa/Filial: " + AllTrim(SM0->M0_FILIAL) )
	WFSendMail()
	RESET ENVIRONMENT
	
	aParam := aSize(aParam,0)
	aParam := Nil

Return()

/*/{Protheus.doc} CriaSx1
Rotina para criação das perguntas
@type function
@author Mario Faria
@since 11/03/2016
@version 1.0
/*/Static Function CriaSx1()

	CheckSX1(cPerg,"01","Emissão De?"		,"Emissão De?"		,"Emissão De?"		,"mv_ch1","D",08,0,0,"G","",""		,"","","mv_par01")
	CheckSX1(cPerg,"02","Emissão Até?"	,"Emissão Até?"		,"Emissão Até?"		,"mv_ch2","D",08,0,0,"G","",""		,"","","mv_par02")
	CheckSX1(cPerg,"03","Série De?"		,"Série De?"		,"Série De?"		,"mv_ch3","C",03,0,0,"G","",""		,"","","mv_par03")
	CheckSX1(cPerg,"04","Série Até?"		,"Série Até?"		,"Série Até?"		,"mv_ch4","C",03,0,0,"G","",""		,"","","mv_par04")
	CheckSX1(cPerg,"05","Documento De?"	,"Documento De?"	,"Documento De?"	,"mv_ch5","C",09,0,0,"G","","SF2"	,"","","mv_par05")
	CheckSX1(cPerg,"06","Documento Até?"	,"Documento Até?"	,"Documento Até?"	,"mv_ch6","C",09,0,0,"G","","SF2"	,"","","mv_par06")
	CheckSX1(cPerg,"07","NFS-e De?"		,"NFS-e De?"		,"NFS-e De?"		,"mv_ch7","C",09,0,0,"G","","F2NFSE","","","mv_par07")
	CheckSX1(cPerg,"08","NFS-e Até?"		,"NFS-e Até?"		,"NFS-e Até?"		,"mv_ch8","C",09,0,0,"G","","F2NFSE","","","mv_par08")
	CheckSX1(cPerg,"09","Cliente De?"		,"Cliente De?"		,"Cliente De?"		,"mv_ch9","C",06,0,0,"G","","SA1"	,"","","mv_par09")
	CheckSX1(cPerg,"10","Loja De?"		,"Loja De?"			,"Loja De?"			,"mv_cha","C",02,0,0,"G","",""		,"","","mv_par10")
	CheckSX1(cPerg,"11","Cliente Até?"	,"Cliente Até?"		,"Cliente Até?"		,"mv_chb","C",06,0,0,"G","","SA1"	,"","","mv_par11")
	CheckSX1(cPerg,"12","Loja Até?"		,"Loja Até?"		,"Loja Até?"		,"mv_chc","C",02,0,0,"G","",""		,"","","mv_par12")
	CheckSX1(cPerg,"13","E-Mail?"			,"E-Mail?"			,"E-Mail?"			,"mv_chd","N",02,0,0,"C","",""		,"","","mv_par13",;
				"Enviados","Enviados","Enviados","",;
				"Não Enviados","Não Enviados","Não Enviados",;
				"Ambos","Ambos","Ambos")

Return()









