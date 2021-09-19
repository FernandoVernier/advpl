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
±±³FUNCAO    ³ RelKits  ³ AUTOR ³ Fernando Vernier     ³ DATA ³ 16/08/21  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Relatorio de Negociações                					  ³±±
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
User Function RelNeg()
Local oReport
Private cPerg 	:= PADR('RNEG',10) 
Private cNome   := 'Relatório de Negociações'
	
AjustaSX1(cPerg)

If !Pergunte(cPerg,.T.) 
    Return .T.
Endif

oReport := ReportDef() 
oReport:PrintDialog() 
	
Return 
    
 
Static Function ReportDef() 

	oReport := TReport():New('RelNegs',cNome,cPerg,{|oReport| ReportPrint(oReport)},"Relatorio de Negociações")
	oReport:SetLandscape()      
	oReport:SetTotalInLine(.F.) // Impressao do total geral das colunas somadas
	oReport:LPARAMPAGE := .T.	// Pagina de Parametros Impressao

	oSection1:= TRSection():New(oReport, "Negociação", {"PW3"}, , .F., .T.)
	TRCell():New(oSection1,"PW3_IDNEG"	      	,"TRBTNF",GetSx3Cache("PW3_IDNEG"   ,"X3_TITULO"),PesqPict("PW3","PW3_IDNEG")	, TamSX3("PW3_IDNEG")[1])
	TRCell():New(oSection1,"cStatus"	      	,"TRBTNF","Status "                 ,''                                         , 20)
	TRCell():New(oSection1,"PW3_EMISSA"	      	,"TRBTNF",GetSx3Cache("PW3_EMISSA"  ,"X3_TITULO"),'99/99/9999'	                , 12)
	TRCell():New(oSection1,"PW3_CODOPE"	      	,"TRBTNF",GetSx3Cache("PW3_CODOPE"	,"X3_TITULO"),PesqPict("PW3","PW3_CODOPE")	, TamSX3("PW3_CODOPE")[1])
	TRCell():New(oSection1,"PW3_NOMOPE"	     	,"TRBTNF",GetSx3Cache("PW3_NOMOPE"  ,"X3_TITULO"),PesqPict("PW3","PW3_NOMOPE")  , 15)
	TRCell():New(oSection1,"cCliente"	      	,"TRBTNF",'Grupo/Cliente'						 ,'@!'	                        , 30)
	TRCell():New(oSection1,"PW3_DTRET"	      	,"TRBTNF",GetSx3Cache("PW3_DTRET"  ,"X3_TITULO") ,'99/99/9999'	                , 12)
	TRCell():New(oSection1,"PW3_HRRET"	      	,"TRBTNF",GetSx3Cache("PW3_HRRET"  ,"X3_TITULO") ,PesqPict("PW3","PW3_HRRET")	, TamSX3("PW3_HRRET")[1])
	TRCell():New(oSection1,"PW3_NTITU"	     	,"TRBTNF",GetSx3Cache("PW3_NTITU"  ,"X3_TITULO") ,PesqPict("PW3","PW3_NTITU")   , TamSX3("PW3_NTITU")[1])
	TRCell():New(oSection1,"PW3_TOTNEG"	     	,"TRBTNF",GetSx3Cache("PW3_TOTNEG" ,"X3_TITULO") ,PesqPict("PW3","PW3_TOTNEG")	, 12)
	TRCell():New(oSection1,"PW3_TOTREC"	     	,"TRBTNF",GetSx3Cache("PW3_TOTREC" ,"X3_TITULO") ,PesqPict("PW3","PW3_TOTNEG")	, 12)
	TRCell():New(oSection1,"PW3_VENCTO"	     	,"TRBTNF",GetSx3Cache("PW3_VENCTO" ,"X3_TITULO") ,'99/99/9999'	                , 12)
    TRCell():New(oSection1,"PW3_OBSER"          ,"TRBTNF",GetSx3Cache("PW3_OBSER"  ,"X3_TITULO") ,,80,.F.,,,.T.,,,,.T.)  
	
	oSection2:= TRSection():New(oReport, "Titulos", {"PW4"}, NIL, .F., .T.)
	TRCell():New(oSection2,"PW4_FILORI"	,"PW4",GetSx3Cache("PW4_FILORI"	,"X3_TITULO"),PesqPict("PW4","PW4_FILORI")	, TamSX3("PW4_FILORI")[1])
	TRCell():New(oSection2,"PW4_STAT"	,"PW4",GetSx3Cache("PW4_STAT" 	,"X3_TITULO"),PesqPict("PW4","PW4_STAT")	, TamSX3("PW4_STAT")[1])
	TRCell():New(oSection2,"PW4_PREFIX"	,"PW4",GetSx3Cache("PW4_PREFIX" ,"X3_TITULO"),PesqPict("PW4","PW4_PREFIX")	, TamSX3("PW4_PREFIX")[1])
	TRCell():New(oSection2,"PW4_NUM"	,"PW4",GetSx3Cache("PW4_NUM" 	,"X3_TITULO"),PesqPict("PW4","PW4_NUM")	    , TamSX3("PW4_NUM")[1])
	TRCell():New(oSection2,"PW4_PARCEL"	,"PW4",GetSx3Cache("PW4_PARCEL" ,"X3_TITULO"),PesqPict("PW4","PW4_PARCEL")	, TamSX3("PW4_PARCEL")[1])
	TRCell():New(oSection2,"PW4_TIPO"	,"PW4",GetSx3Cache("PW4_TIPO" 	,"X3_TITULO"),PesqPict("PW4","PW4_TIPO")	, 02)
	TRCell():New(oSection2,"PW4_EMISSA"	,"PW4",GetSx3Cache("PW4_EMISSA" ,"X3_TITULO"),'99/99/9999'              	, 12)
	TRCell():New(oSection2,"PW4_VENCTO"	,"PW4",GetSx3Cache("PW4_VENCTO"	,"X3_TITULO"),'99/99/9999'              	, 12)
	TRCell():New(oSection2,"PW4_VENCRE"	,"PW4",GetSx3Cache("PW4_VENCRE"	,"X3_TITULO"),'99/99/9999'	                , 12)
	TRCell():New(oSection2,"PW4_VENNEW"	,"PW4",GetSx3Cache("PW4_VENNEW"	,"X3_TITULO"),'99/99/9999'	                , 12)
	TRCell():New(oSection2,"PW4_VALOR"	,"PW4",GetSx3Cache("PW4_VALOR"	,"X3_TITULO"),PesqPict("PW4","PW4_VALOR")	, TamSX3("PW4_VALOR")[1])
	TRCell():New(oSection2,"PW4_VLRCOR"	,"PW4",GetSx3Cache("PW4_VLRCOR"	,"X3_TITULO"),PesqPict("PW4","PW4_VLRCOR")	, TamSX3("PW4_VLRCOR")[1])
	TRCell():New(oSection2,"PW4_VALLIQ"	,"PW4",GetSx3Cache("PW4_VALLIQ"	,"X3_TITULO"),PesqPict("PW4","PW4_VALLIQ")	, TamSX3("PW4_VALLIQ")[1])
	TRCell():New(oSection2,"PW4_SALDO"	,"PW4",GetSx3Cache("PW4_SALDO"	,"X3_TITULO"),PesqPict("PW4","PW4_SALDO")	, TamSX3("PW4_SALDO")[1])
	TRCell():New(oSection2,"PW4_HISTOR"	,"PW4",GetSx3Cache("PW4_HISTOR"	,"X3_TITULO"),PesqPict("PW4","PW4_HISTOR")	, TamSX3("PW4_HISTOR")[1])

	oSection3:= TRSection():New(oReport, "Historico", {"PW2"}, NIL, .F., .T.)
	TRCell():New(oSection3,"PW2_DATA"	,"PW2",GetSx3Cache("PW2_DATA"  	,"X3_TITULO"),'99/99/9999'	, 12)
	TRCell():New(oSection3,"PW2_HORA"	,"PW2",GetSx3Cache("PW2_HORA"  	,"X3_TITULO"),''	        , TamSX3("PW2_HORA")[1])
	TRCell():New(oSection3,"PW2_DESTIP"	,"PW2",GetSx3Cache("PW2_DESTIP"  ,"X3_TITULO"),''	        , TamSX3("PW2_DESTIP")[1])
	TRCell():New(oSection3,"PW2_NMUSER"	,"PW2",GetSx3Cache("PW2_NMUSER"  ,"X3_TITULO"),''	        , TamSX3("PW2_NMUSER")[1])
	TRCell():New(oSection3,"cHistorico"	,"",GetSx3Cache("PW2_HISTM"  	,"X3_TITULO"),''	        , 100)

	oBreak1 := TRBreak():New(oSection1,oSection1:Cell("PW3_IDNEG"),"Totais Negociação")
	
	TRFunction():New(oSection2:Cell("PW4_VALOR")  ,NIL,"SUM",oBreak1)
	TRFunction():New(oSection2:Cell("PW4_VLRCOR")  ,NIL,"SUM",oBreak1)
	TRFunction():New(oSection2:Cell("PW4_VALLIQ")  ,NIL,"SUM",oBreak1)
	TRFunction():New(oSection2:Cell("PW4_SALDO")  ,NIL,"SUM",oBreak1)

    oSection2:SetTotalInLine(.F.)
	
Return(oReport)
 
Static Function ReportPrint(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)	 
	Local oSection3 := oReport:Section(3)	 
	Local cQuery    := ""		
	Local cNcm      := ""   
	Local lPrim 	:= .T.	

	//Monto minha consulta conforme parametros passado

	cQuery +=" SELECT 	* " + CRLF
	cQuery +=" FROM " + RetSqlName("PW3") + " PW3 (NOLOCK) " + CRLF
	cQuery +=" WHERE PW3.D_E_L_E_T_ = ' ' " + CRLF
	cQuery +=" AND PW3_EMISSA BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "' " + CRLF
	cQuery +=" AND PW3_IDNEG BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' " + CRLF
	cQuery +=" AND PW3_CODOPE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' " + CRLF
	cQuery +=" AND CHARINDEX(PW3_STAT,'" + AllTrim(MV_PAR07) + "') > 0 " + CRLF
	cQuery +=" AND PW3_FILIAL = '" + xFilial("PW3") + "' " + CRLF
	cQuery +=" ORDER BY PW3.PW3_IDNEG " 

	//Se o alias estiver aberto, irei fechar, isso ajuda a evitar
	IF Select("TRBTNF") <> 0
		DbSelectArea("TRBTNF")
		DbCloseArea()
	ENDIF
	
	//crio o novo alias
	TCQUERY cQuery NEW ALIAS "TRBTNF"	
	
	TcSetField("TRBTNF",'PW3_EMISSA','D')
	TcSetField("TRBTNF",'PW3_DTRET','D')
	TcSetField("TRBTNF",'PW3_VENCTO','D')

	dbSelectArea("TRBTNF")

	Count To nReg
	
	TRBTNF->(dbGoTop())
	
	oReport:SetMeter(nReg)	
 
	//Irei percorrer todos os meus registros
	While TRBTNF->(!Eof())
		
		If oReport:Cancel()
			Exit
		EndIf
	
		//inicializo a primeira seção
		oSection1:Init()
 
		oReport:IncMeter()
					
		IncProc("Processando Negociacao No.: "+TRBTNF->PW3_IDNEG)
		
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


        oSection1:Cell("PW3_IDNEG"):SetValue(TRBTNF->PW3_IDNEG)
        oSection1:Cell("cStatus"):SetValue(cStatus)
        oSection1:Cell("PW3_EMISSA"):SetValue(TRBTNF->PW3_EMISSA)
        oSection1:Cell("PW3_CODOPE"):SetValue(TRBTNF->PW3_CODOPE)
        oSection1:Cell("PW3_NOMOPE"):SetValue(TRBTNF->PW3_NOMOPE)
        oSection1:Cell("cCliente"):SetValue(cCliente)
        oSection1:Cell("PW3_DTRET"):SetValue(TRBTNF->PW3_DTRET)
        oSection1:Cell("PW3_HRRET"):SetValue(TRBTNF->PW3_HRRET)
        oSection1:Cell("PW3_TOTNEG"):SetValue(TRBTNF->PW3_TOTNEG)
        oSection1:Cell("PW3_TOTREC"):SetValue(TRBTNF->PW3_TOTREC)
        oSection1:Cell("PW3_VENCTO"):SetValue(TRBTNF->PW3_VENCTO)
        oSection1:Cell("PW3_OBSER"):SetValue(TRBTNF->PW3_OBSER)
		oSection1:Printline()        
		
		cIdNeg     := TRBTNF->PW3_IDNEG
        cGrupo     := TRBTNF->PW3_GRPCLI
        cCodigo    := TRBTNF->PW3_CLIENT
        cLoja      := TRBTNF->PW3_LOJA
        
        If PW4->(dbSetOrder(1), dbSeek(xFilial("PW4")+cIdNeg))
		    While PW4->(!Eof()) .And. PW4->PW4_FILIAL == xFilial("PW4") .And. PW4->PW4_IDNEG == cIdNeg
            
                //inicializo a segunda seção
                oSection2:init()

                oSection2:Cell("PW4_FILORI"):SetValue(PW4->PW4_FILORI)
                oSection2:Cell("PW4_STAT"):SetValue(PW4->PW4_STAT)
                oSection2:Cell("PW4_PREFIX"):SetValue(PW4->PW4_PREFIX)
                oSection2:Cell("PW4_NUM"):SetValue(PW4->PW4_NUM)
                oSection2:Cell("PW4_PARCEL"):SetValue(PW4->PW4_PARCEL)
                oSection2:Cell("PW4_TIPO"):SetValue(PW4->PW4_TIPO)
                oSection2:Cell("PW4_EMISSA"):SetValue(PW4->PW4_EMISSA)
                oSection2:Cell("PW4_VENCTO"):SetValue(PW4->PW4_VENCTO)
                oSection2:Cell("PW4_VENCRE"):SetValue(PW4->PW4_VENCRE)
                oSection2:Cell("PW4_VENNEW"):SetValue(PW4->PW4_VENNEW)
                oSection2:Cell("PW4_VALOR"):SetValue(PW4->PW4_VALOR)
                oSection2:Cell("PW4_VLRCOR"):SetValue((PW4->PW4_VALOR-PW4->PW4_SALDO)+PW4->PW4_VLRCOR)
                oSection2:Cell("PW4_VALLIQ"):SetValue(PW4->PW4_VALLIQ)
                oSection2:Cell("PW4_SALDO"):SetValue(((PW4->PW4_VALOR-PW4->PW4_SALDO)+PW4->PW4_VLRCOR)-PW4->PW4_VALLIQ)
                oSection2:Cell("PW4_HISTOR"):SetValue(PW4->PW4_HISTOR)

                oSection2:Printline()
            
                PW4->(dbSkip(1))
            Enddo
        Endif

        If PW2->(dbSetOrder(1), dbSeek(xFilial("PW2")+cGrupo+cCodigo+cLoja))
            //inicializo a segunda seção
            oSection3:init()
            While PW2->(!Eof()) .And. PW2->PW2_FILIAL == xFilial("PW2") .And. PW2->(PW2_GRUPO+PW2_CLIENT+PW2_LOJA) == (cGrupo+cCodigo+cLoja)
                cHistorico := ''
                If Iif(MV_PAR08==1,PW2->PW2_IDNEGO == cIdNeg,.T.)
                    cHistorico += '=> ' + DtoC(PW2->PW2_DATA) + ' em ' + PW2->PW2_HORA + ' -> ' + PW2->PW2_HISTM + CRLF

                    oSection3:Cell("PW2_DATA"):SetValue(PW2->PW2_DATA)
                    oSection3:Cell("PW2_HORA"):SetValue(PW2->PW2_HORA)
                    oSection3:Cell("PW2_DESTIP"):SetValue(PW2->PW2_DESTIP)
                    oSection3:Cell("PW2_NMUSER"):SetValue(PW2->PW2_NMUSER)
                    oSection3:Cell("cHistorico"):SetValue(cHistorico)				

                    oSection3:Printline()
                Endif

                PW2->(dbSkip(1))
            Enddo
        Endif

 		//imprimo uma linha para separar uma NCM de outra
 		oReport:ThinLine()
 		//finalizo a primeira seção
		oSection3:Finish()
 		//finalizo a segunda seção para que seja reiniciada para o proximo registro
 		oSection2:Finish()
 		//finalizo a segunda seção para que seja reiniciada para o proximo registro
 		oSection1:Finish()

        TRBTNF->(dbSkip(1))
	Enddo
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
		aAdd(aRegs,{cPerg,'01','Data Negociação De ?','','','mv_ch1','D', 08,0,0,'G',''						        ,'mv_par01','','','','','',''})
		aAdd(aRegs,{cPerg,'02','Data Negociação Ate?','','','mv_ch2','D', 08,0,0,'G',''						        ,'mv_par02','','','','','',''})
		aAdd(aRegs,{cPerg,'03','Id Negociação De   ?','','','mv_ch3','C', TamSX3("PW3_IDNEG")[1],0,0,'G',''		    ,'mv_par03','','','','','',''})
		aAdd(aRegs,{cPerg,'04','Id Negociação Ate  ?','','','mv_ch4','C', TamSX3("PW3_IDNEG")[1],0,0,'G',''		    ,'mv_par04','','','','','',''})
		aAdd(aRegs,{cPerg,'05','Operador(a) De     ?','','','mv_ch5','C', TamSX3("PW3_CODOPE")[1],0,0,'G',''	    ,'mv_par05','','','','','','USR'})
		aAdd(aRegs,{cPerg,'06','Operador(a) Ate    ?','','','mv_ch6','C', TamSX3("PW3_CODOPE")[1],0,0,'G',''	    ,'mv_par06','','','','','','USR'})
		aAdd(aRegs,{cPerg,'07','Status             ?','','','mv_ch7','C', 20,0,0,'C','U_FSTAT()'                    ,'mv_par07','','','','','',''})
		aAdd(aRegs,{cPerg,'08','Historico          ?','','','mv_ch7','C', 20,0,0,'C',''			                    ,'mv_par07','Negociacao','Geral','','','',''})

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
					SX1->(MsUnlock())
				Else
					Help('',1,'REGNOIS')
				EndIf	
			Endif
		Next nX

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fReqEPI   ³ Autor ³ Marcelo Silveira      ³ Data ³13/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Selecionar Requisitos do EPI                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ fReqEPI()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function fStat()

Local cTitulo:=""
Local MvPar
Local MvParDef:="" 
Local i := 1

Private aReq:={}

cAlias := Alias()               // Salva Alias Anterior
MvPar:=&(Alltrim(ReadVar()))   // Carrega Nome da Variavel do Get em Questao
mvRet:=Alltrim(ReadVar())      // Iguala Nome da Variavel ao Nome variavel de Retorno

If GetNewPar("MV_XEMPCB",2)	== 1 // 1 fcommit()
    aReq := {	'1 - Liquidado' ,; //"Foi observado o prazo de validade, conforme Certificado de Aprovacao-CA do MTE."
                '2 - Juridico' ,; //"Foi observada a periodicidade de troca definida pelos programas ambientais, comprovada mediante recibo assinado pelo usuario em epoca propria."
                '3 - Cheque Custodia',;
                '4 - Contactado',;
                '5 - Negativado',;
                '6 - Liquidado Parcial',;
                '7 - Andamento',;
                '8 - Negociado Aguardando',;
                'C - Cancelado'} //"Foi observada a higienizacao."
ElseIf GetNewPar("MV_XEMPCB",2)	== 2 // 2 Grupo
    aReq := {	'1 - Liquidado' ,; //"Foi observado o prazo de validade, conforme Certificado de Aprovacao-CA do MTE."
                '2 - Cobrança Extrajunidical' ,; //"Foi observada a periodicidade de troca definida pelos programas ambientais, comprovada mediante recibo assinado pelo usuario em epoca propria."
                '3 - Cobrança Exeternalizada',;
                '4 - Contactado',;
                '5 - Cliente Negativado',;
                '6 - Liquidado Parcial',;
                '7 - Cobrança em Andamento',;
                '8 - Decisão Comitê Estratégico',;
                'C - Cancelado'} //"Foi observada a higienizacao."
Endif

MvParDef:= "12345678C"
cTitulo := 'Selecione os Status Desejados para o Filtro' //"Atendimento aos requisitos pelos EPIS informados"

IF f_Opcoes(@MvPar,cTitulo,aReq,MvParDef,12,49,.F.)  // Chama funcao f_Opcoes
	&MvRet := mvpar
EndIF                           

dbSelectArea(cAlias) // Retorna Alias

Return( .T. )
