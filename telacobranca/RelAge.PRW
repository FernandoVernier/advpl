#INCLUDE "Fileio.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"              
#INCLUDE "rwmake.CH"              
#include 'topconn.ch'    
#include "msgraphi.ch"
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ RelTPPN  ³ AUTOR ³ Fernando Vernier     ³ DATA ³ 16/08/21  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Relatorio de Agenda do Operador      					  ³±±
±±³          ³ 			                                                  ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³PROGRAMADOR    ³ DATA   ³ MOTIVO DA ALTERACAO		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³               ³        ³                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RelAge()
Local oReport
Private cPerg 	:= PADR('RELAGE',10) 
Private cNome   := 'Relatório de Agenda Operador(a)'
	
AjustaSX1(cPerg)

If !Pergunte(cPerg,.T.) 
    Return .T.
Endif

oReport := ReportDef() 
oReport:PrintDialog() 
	
Return 
    
 
Static Function ReportDef() 

	oReport := TReport():New('RelAgeOp',cNome,cPerg,{|oReport| ReportPrint(oReport)},"Relatorio de Agendamento de Operadores")
	oReport:SetLandscape()      
	oReport:SetTotalInLine(.F.) // Impressao do total geral das colunas somadas
	oReport:LPARAMPAGE := .T.	// Pagina de Parametros Impressao

	oSection:= TRSection():New(oReport, "Cabecalho", {"PW3"}, , .F., .T.)
	TRCell():New(oSection,"PW3_IDNEG"	      	,"TRBTNF",GetSx3Cache("PW3_IDNEG"   ,"X3_TITULO"),PesqPict("PW3","PW3_IDNEG")	, TamSX3("PW3_IDNEG")[1])
	TRCell():New(oSection,"cStatus"	      		,"TRBTNF","Status "                 ,''                                         , 20)
	TRCell():New(oSection,"PW3_EMISSA"	      	,"TRBTNF",GetSx3Cache("PW3_EMISSA"  ,"X3_TITULO"),PesqPict("PW3","PW3_EMISSA")	, 12)
	TRCell():New(oSection,"PW3_CODOPE"	      	,"TRBTNF",GetSx3Cache("PW3_CODOPE"	,"X3_TITULO"),PesqPict("PW3","PW3_CODOPE")	, TamSX3("PW3_CODOPE")[1])
	TRCell():New(oSection,"PW3_NOMOPE"	     	,"TRBTNF",GetSx3Cache("PW3_NOMOPE"  ,"X3_TITULO"),PesqPict("PW3","PW3_NOMOPE")  , 15)
	TRCell():New(oSection,"cCliente"	      	,"TRBTNF",'Grupo/Cliente'						 ,'@!'	, 30)
	TRCell():New(oSection,"PW3_TOTNEG"	     	,"TRBTNF",GetSx3Cache("PW3_TOTNEG" ,"X3_TITULO") ,PesqPict("PW3","PW3_TOTNEG")	, 12)
	TRCell():New(oSection,"PW3_TOTREC"	     	,"TRBTNF",GetSx3Cache("PW3_TOTREC" ,"X3_TITULO") ,PesqPict("PW3","PW3_TOTNEG")	, 12)
	TRCell():New(oSection,"nSaldo"	     	    ,"TRBTNF","Saldo"                                ,PesqPict("PW3","PW3_TOTNEG")	, 12)
	TRCell():New(oSection,"PW3_DTRET"	      	,"TRBTNF",GetSx3Cache("PW3_DTRET"  ,"X3_TITULO") ,PesqPict("PW3","PW3_DTRET")	, 12)
	TRCell():New(oSection,"PW3_HRRET"	      	,"TRBTNF",GetSx3Cache("PW3_HRRET"  ,"X3_TITULO") ,PesqPict("PW3","PW3_HRRET")	, TamSX3("PW3_HRRET")[1])
    If MV_PAR05 == 1
        TRCell():New(oSection,"cHistorico"         ,"",'Historico da Negociação',,60,.F.,,,.T.,,,,.T.)  //"Historico" 19
    Endif

	oBreak1 := TRBreak():New(oSection,oSection:Cell("PW3_CODOPE"),"Agenda Operador: ")

	TRFunction():New(oSection:Cell("PW3_IDNEG"),NIL,"COUNT",oBreak1 ,,'9999999',,.F.,.F.)
	TRFunction():New(oSection:Cell("PW3_TOTNEG"),NIL,"SUM",oBreak1)
	TRFunction():New(oSection:Cell("PW3_TOTREC"),NIL,"SUM",oBreak1)
	TRFunction():New(oSection:Cell("nSaldo"),NIL,"SUM",oBreak1)

    oSection:SetTotalInLine(.F.)
Return(oReport)
 
Static Function ReportPrint(oReport)
	Local oSection := oReport:Section(1)
	Local cQuery    := ""		
	Local cNcm      := ""   
	Local lPrim 	:= .T.	

	//Monto minha consulta conforme parametros passado

	cQuery +="  SELECT 	* " + CRLF
	cQuery +=" 	FROM " + RetSqlName("PW3") + " PW3 (NOLOCK) " + CRLF
	cQuery +=" 	WHERE PW3.D_E_L_E_T_ = ' ' " + CRLF
	cQuery +="  AND PW3.PW3_DTRET BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "' " + CRLF
	cQuery +="  AND PW3.PW3_CODOPE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' " + CRLF
	cQuery +="  AND PW3.PW3_STAT NOT IN('C','E') " + CRLF
	cQuery +="  AND PW3_FILIAL = '" + xFilial("PW3") + "' " + CRLF
	cQuery +=" 	ORDER BY PW3_CODOPE, PW3_DTRET, PW3_HRRET " + CRLF

	//Se o alias estiver aberto, irei fechar, isso ajuda a evitar
	IF Select("TRBTNF") <> 0
		DbSelectArea("TRBTNF")
		DbCloseArea()
	ENDIF
	
	//crio o novo alias
	TCQUERY cQuery NEW ALIAS "TRBTNF"	
	
	dbSelectArea("TRBTNF")

	TcSetField("TRBTNF",'PW3_EMISSA','D')
	TcSetField("TRBTNF",'PW3_DTRET','D')

	Count To nReg
	
	TRBTNF->(dbGoTop())
	
	oReport:SetMeter(nReg)	   
	
	//inicializo a primeira seção
	oSection:Init()
 
	//Irei percorrer todos os meus registros
	While TRBTNF->(!Eof())
		
		If oReport:Cancel()
			Exit
		EndIf
	
		oReport:IncMeter()
					
		IncProc("Aguarde Processando...")  
		
		PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+TRBTNF->PW3_IDNEG))

        cStatus := 'Contactado'
		
        If GetNewPar("MV_XEMPCB",2)	== 1 // 1 fcommit()
            If TRBTNF->PW3_STAT == '1'
                cStatus   :=  'Liquidado'
            ElseIf TRBTNF->PW3_STAT == '2'
                cStatus   :=  'Juridico'
            ElseIf TRBTNF->PW3_STAT == '3'
                cStatus   :=  'Cheque Custodia'
            ElseIf TRBTNF->PW3_STAT == '4'
                cStatus   :=  'Contactado'
            ElseIf TRBTNF->PW3_STAT == '5'
                cStatus   :=  'Negativado'
            ElseIf TRBTNF->PW3_STAT == '6'
                cStatus   :=  'Liquidado Parcial'
            ElseIf TRBTNF->PW3_STAT == '7'
                cStatus   :=  'Andamento'
            ElseIf TRBTNF->PW3_STAT == '8'
                cStatus   :=  'Negociado Aguardando'
            ElseIf TRBTNF->PW3_STAT == 'C'
                cStatus   :=  'Cancelada'
            ElseIf TRBTNF->PW3_STAT == 'E'
                cStatus   :=  'Encerrada'
            Endif
        ElseIf GetNewPar("MV_XEMPCB",2)	== 2 // 2 Grupo
            If TRBTNF->PW3_STAT == '1'
                cStatus   :=  'Liquidado'
            ElseIf TRBTNF->PW3_STAT == '2'
                cStatus   :=  'Cobrança Extrajunidical'
            ElseIf TRBTNF->PW3_STAT == '3'
                cStatus   :=  'Cobrança Exeternalizada'
            ElseIf TRBTNF->PW3_STAT == '4'
                cStatus   :=  'Contactado'
            ElseIf TRBTNF->PW3_STAT == '5'
                cStatus   :=  'Cliente Negativado'
            ElseIf TRBTNF->PW3_STAT == '6'
                cStatus   :=  'Liquidado Parcial'
            ElseIf TRBTNF->PW3_STAT == '7'
                cStatus   :=  'Cobrança em Andamento'
            ElseIf TRBTNF->PW3_STAT == '8'
                cStatus   :=  'Decisão Comitê Estratégico'
            ElseIf TRBTNF->PW3_STAT == 'C'
                cStatus   :=  'Cancelada'
            ElseIf TRBTNF->PW3_STAT == 'E'
                cStatus   :=  'Encerrada'
            Endif
        Endif
        
        cCodigo := TRBTNF->PW3_CLIENT
        cLoja   := TRBTNF->PW3_LOJA
        cGrupo  := TRBTNF->PW3_GRPCLI

        If Empty(cGrupo)
            SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))

            cCliente := SA1->A1_NOME
        Else
            SZ5->(dbSetOrder(1), dbSeek(xFilial("SZ5")+cGrupo))

            cCliente := SZ5->Z5_NOME
        Endif

        If MV_PAR05 == 1
            cHistorico := ''
            If PW2->(dbSetOrder(1), dbSeek(xFilial("PW2")+cGrupo+cCodigo+cLoja))
                While PW2->(!Eof()) .And. PW2->PW2_FILIAL == xFilial("PW2") .And. PW2->(PW2_GRUPO+PW2_CLIENT+PW2_LOJA) == (cGrupo+cCodigo+cLoja)
                    If PW2->PW2_IDNEGO == TRBTNF->PW3_IDNEG
                        cHistorico += '=> ' + DtoC(PW2->PW2_DATA) + ' em ' + PW2->PW2_HORA + ' -> ' + PW2->PW2_HISTM + CRLF
                    Endif

                    PW2->(dbSkip(1))
                Enddo
            Endif
        Endif

		//imprimo a primeira seção				

        oSection:Cell("PW3_IDNEG"):SetValue(TRBTNF->PW3_IDNEG)
        oSection:Cell("cStatus"):SetValue(cStatus)
        oSection:Cell("PW3_EMISSA"):SetValue(TRBTNF->PW3_EMISSA)
        oSection:Cell("PW3_CODOPE"):SetValue(TRBTNF->PW3_CODOPE)
        oSection:Cell("PW3_NOMOPE"):SetValue(TRBTNF->PW3_NOMOPE)
        oSection:Cell("cCliente"):SetValue(cCliente)
        oSection:Cell("PW3_TOTNEG"):SetValue(TRBTNF->PW3_TOTNEG)
        oSection:Cell("PW3_TOTREC"):SetValue(TRBTNF->PW3_TOTREC)
        oSection:Cell("nSaldo"):SetValue(Round(TRBTNF->PW3_TOTNEG-TRBTNF->PW3_TOTREC,2))
        oSection:Cell("PW3_DTRET"):SetValue(TRBTNF->PW3_DTRET)
        oSection:Cell("PW3_HRRET"):SetValue(TRBTNF->PW3_HRRET)
//        oSection:Cell("PW3_OBSER"):SetValue(TRBTNF->PW3_OBSER)
        If MV_PAR05 == 1
            oSection:Cell("cHistorico"):SetValue(cHistorico)
        Endif

		oSection:Printline()        

		TRBTNF->(dbSkip(1))
	Enddo

	//finalizo a primeira seção
	oSection:Finish()             
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AjustaSX1ºAutor ³Luiz Alberto V Alvesº Data ³  22/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajusta o SX1 - Arquivo de Perguntas..                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Funcao Principal                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDATA      ³ ANALISTA ³ MOTIVO                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³          ³                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AjustaSX1(cPerg)
Local	aRegs   := {},;
		_sAlias := Alias(),;
		nX

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Campos a serem grav. no SX1³
		//³aRegs[nx][01] - X1_GRUPO   ³
		//³aRegs[nx][02] - X1_ORDEM   ³
		//³aRegs[nx][03] - X1_PERGUNTE³
		//³aRegs[nx][04] - X1_PERSPA  ³
		//³aRegs[nx][05] - X1_PERENG  ³
		//³aRegs[nx][06] - X1_VARIAVL ³
		//³aRegs[nx][07] - X1_TIPO    ³
		//³aRegs[nx][08] - X1_TAMANHO ³
		//³aRegs[nx][09] - X1_DECIMAL ³
		//³aRegs[nx][10] - X1_PRESEL  ³
		//³aRegs[nx][11] - X1_GSC     ³
		//³aRegs[nx][12] - X1_VALID   ³
		//³aRegs[nx][13] - X1_VAR01   ³
		//³aRegs[nx][14] - X1_DEF01   ³
		//³aRegs[nx][15] - X1_DEF02   ³
		//³aRegs[nx][16] - X1_DEF03   ³
		//³aRegs[nx][17] - X1_DEF04   ³
		//³aRegs[nx][18] - X1_DEF05   ³
		//³aRegs[nx][19] - X1_F3      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Cria uma array, contendo todos os valores...³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aAdd(aRegs,{cPerg,'01','Data De            ?','','','mv_ch1','D', 08,0,0,'G',''						,'mv_par01','','','','','','',''})
		aAdd(aRegs,{cPerg,'02','Data Ate           ?','','','mv_ch2','D', 08,0,0,'G',''						,'mv_par02','','','','','','',''})
		aAdd(aRegs,{cPerg,'03','Operador De        ?','','','mv_ch3','C', 06,0,0,'G',''						,'mv_par03','','','','','','USR ',''})
		aAdd(aRegs,{cPerg,'04','Operador Ate       ?','','','mv_ch4','C', 06,0,0,'G',''						,'mv_par04','','','','','','USR ',''})
		aAdd(aRegs,{cPerg,'05','Imprime Historico  ?','','','mv_ch5','N', 01,0,0,'C',''						,'mv_par05','Sim','Nao','','','','',''})

		DbSelectArea('SX1')
		SX1->(DbSetOrder(1))

		For nX:=1 to Len(aRegs)
			If	( ! SX1->(DbSeek(aRegs[nx][01]+aRegs[nx][02])) )
				If	RecLock('SX1',.T.)
					Replace SX1->X1_GRUPO  		With aRegs[nx][01]
					Replace SX1->X1_ORDEM   	With aRegs[nx][02]
					Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
					Replace SX1->X1_PERSPA		With aRegs[nx][04]
					Replace SX1->X1_PERENG		With aRegs[nx][05]
					Replace SX1->X1_VARIAVL		With aRegs[nx][06]
					Replace SX1->X1_TIPO		With aRegs[nx][07]
					Replace SX1->X1_TAMANHO		With aRegs[nx][08]
					Replace SX1->X1_DECIMAL		With aRegs[nx][09]
					Replace SX1->X1_PRESEL		With aRegs[nx][10]
					Replace SX1->X1_GSC			With aRegs[nx][11]
					Replace SX1->X1_VALID		With aRegs[nx][12]
					Replace SX1->X1_VAR01		With aRegs[nx][13]
					Replace SX1->X1_DEF01		With aRegs[nx][14]
					Replace SX1->X1_DEF02		With aRegs[nx][15]
					Replace SX1->X1_DEF03		With aRegs[nx][16]
					Replace SX1->X1_DEF04		With aRegs[nx][17]
					Replace SX1->X1_DEF05		With aRegs[nx][18]
					Replace SX1->X1_F3   		With aRegs[nx][19]
					Replace SX1->X1_PICTURE		With aRegs[nx][20]
					SX1->(MsUnlock())
				Else
					Help('',1,'REGNOIS')
				EndIf	
			Endif
		Next nX

Return
