#INCLUDE "FWMVCDEF.CH"
#Include "RWMAKE.CH"
#Include "TOPCONN.CH"
#Include "Protheus.Ch"
#Include "VKEY.Ch"

#DEFINE HIS_DATA  	001
#DEFINE HIS_HORA  	002
#DEFINE HIS_INIC  	003
#DEFINE HIS_USER  	004
#DEFINE HIS_RECN  	005
#DEFINE HIS_TIPO  	006
#DEFINE HIS_DTIP  	007
#DEFINE HIS_IDNG  	008

#DEFINE SEL_MARCA  	001
#DEFINE SEL_PREFIXO	002
#DEFINE SEL_TITULO	003
#DEFINE SEL_PARCELA	004
#DEFINE SEL_TIPO	005
#DEFINE SEL_CODIGO	006
#DEFINE SEL_LOJA	007
#DEFINE SEL_NOME   	008
#DEFINE SEL_EMISSAO	009
#DEFINE SEL_VENCTO	010
#DEFINE SEL_VALOR 	011
#DEFINE SEL_REGISTRO 012
#DEFINE SEL_FILIAL  013

#DEFINE  DT_MARCA		001
#DEFINE  DT_LEGENDA		002
#DEFINE  DT_GRUPO		003
#DEFINE  DT_NOMEGRP		004
#DEFINE  DT_CODIGO		005
#DEFINE  DT_LOJA		006
#DEFINE  DT_CNPJ     	007
#DEFINE  DT_NOMECLI    	008
#DEFINE  DT_ULTCOM   	009
#DEFINE  DT_QTDCOM   	010
#DEFINE  DT_DDD			011
#DEFINE  DT_TEL			012
#DEFINE  DT_TEL2     	013
#DEFINE  DT_CONTATO		014
#DEFINE  DT_NREDUZ		015
#DEFINE  DT_MUN      	016
#DEFINE  DT_EMAIL		017
#DEFINE  DT_COMPL    	018
#DEFINE  DT_RECNO		019
#DEFINE  DT_FINAN		020
#DEFINE  DT_ORDEM		021
#DEFINE  DT_CLIVIP		022

#DEFINE  NG_STATUS		001
#DEFINE  NG_EMISS		002
#DEFINE  NG_IDNEG		003
#DEFINE  NG_NMOPE		004
#DEFINE  NG_DFORM		005
#DEFINE  NG_DRETO		006
#DEFINE  NG_HRETO		007
#DEFINE  NG_DCONT		008
#DEFINE  NG_HCONT		009
#DEFINE  NG_RCONT		010
#DEFINE  NG_OBSER		011
#DEFINE  NG_NTITU		012
#DEFINE  NG_TTNEG		013
#DEFINE  NG_TTREC		014
#DEFINE  NG_CLIEN		015
#DEFINE  NG_LOJA		016
#DEFINE	 NG_GRUPO		017
#DEFINE  NG_RECNO		018
#DEFINE	 NG_NOME		019
#DEFINE	 NG_CREDI		020

#DEFINE TIT_STATUS 		001
#DEFINE TIT_PREFIX 		002
#DEFINE TIT_TITULO 		003
#DEFINE TIT_PARCEL 		004
#DEFINE TIT_EMISSA 		005
#DEFINE TIT_VENCTO 		006
#DEFINE TIT_VALORR 		007
#DEFINE TIT_SALDOO 		008
#DEFINE TIT_LIQUID 		009
#DEFINE TIT_VENCNW 		010
#DEFINE TIT_HISTOR 		011
#DEFINE TIT_REGIST 		012
#DEFINE TIT_FILORI 		013
#DEFINE TIT_TIPTIT 		014

#DEFINE  OP_MARCA		001
#DEFINE  OP_GRUPO		002
#DEFINE  OP_NOMEGRP		003
#DEFINE  OP_CODIGO		004
#DEFINE  OP_LOJA		005
#DEFINE  OP_CNPJ     	006
#DEFINE  OP_NOMECLI    	007
#DEFINE  OP_ULTCOM   	008
#DEFINE  OP_QTDCOM   	009
#DEFINE  OP_DDD			010
#DEFINE  OP_TEL			011
#DEFINE  OP_TEL2     	012
#DEFINE  OP_CONTATO		013
#DEFINE  OP_NREDUZ		014
#DEFINE  OP_MUN      	015
#DEFINE  OP_EMAIL		016
#DEFINE  OP_COMPL    	017
#DEFINE  OP_RECNO		018
#DEFINE  OP_ORDEM		019
#DEFINE  OP_QTNEG		020
#DEFINE  OP_CLIVIP		021

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PnCob   บAutor ณFernando Vernierบ   Data ณ  Junho/2021	  บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Painel de Cobran็a										  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ fcommit()    ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PnCob()
Local aArea := GetArea()
Local cPerg := PadR("PNCOB",10)

ValidPerg(cPerg)
If !Pergunte(cPerg,.T.)
	Return
Endif

Processa({|| P_Cobranca(MV_PAR01,MV_PAR02) } ,"Aguarde Selecionando Clientes...")

RestArea(aArea)
Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ P_Cobranca   บAutor ณLuiz Albertoบ Data ณ  Junho/2021      บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Clientes e Grupo de Clientes com Pend๊ncia Financeira      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ fcommit()    ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function P_Cobranca(dVencIni,dVencFim)
Local aArea	:= GetArea()
Local oBotaoSai
Local lRet := .T.


PRIVATE oRcp5
Private oOk		 	:= LoadBitmap(GetResources(),"LBTIK")
Private oNo  	 	:= LoadBitmap(GetResources(),"LBNO")
Private oLegBranco  := LoadBitmap(GetResources(),"BR_BRANCO")
Private oLegVerde   := LoadBitmap(GetResources(),"BR_VERDE")
Private oLegLaranja := LoadBitmap(GetResources(),"BR_LARANJA")
Private oLegVermelho:= LoadBitmap(GetResources(),"BR_VERMELHO")
Private oLegAmarelo := LoadBitmap(GetResources(),"BR_AMARELO")
Private oLegVioleta := LoadBitmap(GetResources(),"BR_VIOLETA")
Private oLegRosa    := LoadBitmap(GetResources(),"BR_PINK")
Private oLegAzul    := LoadBitmap(GetResources(),"BR_AZUL")
Private oLegPreto   := LoadBitmap(GetResources(),"BR_PRETO")
Private oLegCinza   := LoadBitmap(GetResources(),"BR_CINZA")
Private oBotaoCnf
Private oSay1
Private oSay2
Private cButton := "QPushButton { background: #35ACCA; border: 1px solid #096A82;outline:0; border-radius: 5px; font: normal 12px Arial; padding: 6px;color: #ffffff;} QPushButton:pressed {background-color: #3AAECB;border-style: inset; border-color: #35ACCA; color: #ffffff; }"
Private cButSai := "QPushButton { background: #1900FF; border: 1px solid #096A82;outline:0; border-radius: 5px; font: normal 12px Arial; padding: 6px;color: #ffffff;} QPushButton:pressed {background-color: #3AAECB;border-style: inset; border-color: #35ACCA; color: #ffffff; }"
Private cButBox := "QPushButton { background: #FF6A00; border: 1px solid #096A82;outline:0; border-radius: 5px; font: normal 12px Arial; padding: 6px;color: #ffffff;} QPushButton:pressed {background-color: #3AAECB;border-style: inset; border-color: #35ACCA; color: #ffffff; }"
Private cButPre := "QPushButton { background: #B50505; border: 1px solid #096A82;outline:0; border-radius: 5px; font: normal 12px Arial; padding: 6px;color: #ffffff;} QPushButton:pressed {background-color: #3AAECB;border-style: inset; border-color: #35ACCA; color: #ffffff; }"
Private cButSal := "QPushButton { background: #05B531; border: 1px solid #096A82;outline:0; border-radius: 5px; font: normal 12px Arial; padding: 6px;color: #ffffff;} QPushButton:pressed {background-color: #3AAECB;border-style: inset; border-color: #35ACCA; color: #ffffff; }"
Private aCobCli 	:= {}
Private aNegocia	:= {}
Private aOperador	:= {}
Private aTitulos	:= {}
Private aGeral		:= {}
Private aTitGeral		:= {}
Private lMarca		:= .F.
Private oSay1
Private oSay2
Private cFilGrp 	:= Space(04)
Private cFilNom 	:= Space(40)
Private cFilNgr		:= Space(30)
Private cFilGr1 	:= Space(04)
Private cFilNo1 	:= Space(40)
Private cFilNg1		:= Space(30)
Private nTOrigi		:= 0.00
Private nTSaldo		:= 0.00
Private nTLiqui		:= 0.00
Private nGOrigi		:= 0.00
Private nGSaldo		:= 0.00
Private nGLiqui		:= 0.00
Private nNegocia	:= 0
Private dDtIni		:= dVencIni
Private dDtFim		:= dVencFim
Private nSelCol 	:= 0 
PRIVATE oFntLBox := TFont():New("Arial Narrow",,018,,.F.,,,,,.F.,.F.)

aNegocia := {}
AAdd(aNegocia,{'4',CtoD(''),'','','',CtoD(''),'',CtoD(''),'','','',0,0,0,'','','',0,'',0})

aGeral := {}
AAdd(aGeral  ,{'4',CtoD(''),'','','',CtoD(''),'',CtoD(''),'','','',0,0,0,'','','',0,'',0})

ChkFile("PW3")

cTipOpe	:=	'A'		// Normal

cTipOpe := Iif(__cUserId$GetNewPar("MV_XADMCI",'000000'),'A',cTipOpe)  // Admnistrador

aSize     := MsAdvSize() 
aObjects := {} 
AAdd( aObjects, {  60, 100, .t., .t. } )
	
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } 
aPosObj := MsObjSize( aInfo, aObjects ) 

DEFINE MSDIALOG oRcp5 TITLE "Painel de Cobran็a - " + Capital(AllTrim(SM0->M0_NOMECOM)) FROM aSize[7],00 To aSize[6],Min(1304,aSize[5]) COLORS 0, 16777215 PIXEL Style DS_MODALFRAME 
//oRcp5:lEscClose := .F. 

	@ 005, 002 FOLDER oFolder1 SIZE (oRcp5:NRIGHT/2)-05, (oRcp5:NHEIGHT/2)-20 OF oRcp5 ITEMS "Clientes e Grupos",'Carteira Operador(a)','Negocia็๕es Operador(a)','Negocia็๕es Gerais' COLORS 0, 16777215 PIXEL 

    @ 020, 005 LISTBOX oDtCobCli 	Fields HEADER '','','Titulo','Vip','Grupo','Descri็ใo Grupo','C๓digo','Loja','CNPJ','Razใo Social','DDD','Telefone (1)','Telefone (2)','Contato','Municipio','Email','Complemento' SIZE (oRcp5:NRIGHT/2)-15, (oRcp5:NHEIGHT/2)-120 OF oFolder1:aDialogs[1] FONT oFntLBox  PIXEL 

	oDtCobCli:bLDblClick := {|| fMarcaCli(oDtCobCli:nAt) }
	oDtCobCli:bHeaderClick := {|| fTrataCol(oDtCobCli:ColPos,1) }

    @ 020, 005 LISTBOX oDtOpera 	Fields HEADER '','','Negoc','Vip','Grupo','Descri็ใo Grupo','C๓digo','Loja','CNPJ','Razใo Social','DDD','Telefone (1)','Telefone (2)','Contato','Municipio','Email','Complemento' SIZE (oRcp5:NRIGHT/2)-15, (oRcp5:NHEIGHT/2)-120 OF oFolder1:aDialogs[2] FONT oFntLBox  PIXEL //ColSizes 50,50
    
	oDtOpera:bLDblClick := {|| fMarcaCart(oDtOpera:nAt) }
	oDtOpera:bHeaderClick := {|| fTrataCol(oDtOpera:ColPos,2) }

	@ 020, 005 LISTBOX oDtNegocia 	Fields HEADER 'Status','Dt.Negocia็ใo','Id Negocia็ใo','Operador Abertura','Forma Pagamento','Dt.Retorno','Hr.Retorno','Dt.Ult.Cont.','Hr Ult Cont.','Resumo Ult.Contato',;
														'Observa็๕es','No.Titulos','Total Negociado','Total Recebido','Total Credito' SIZE (oRcp5:NRIGHT/2)-15, (oRcp5:NHEIGHT/2)-236.5 OF oFolder1:aDialogs[3] FONT oFntLBox  PIXEL //ColSizes 50,50

	oDtNegocia:bChange := {|| Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo...")  }
	oDtNegocia:bHeaderClick := {|| fTrataCol(oDtNegocia:ColPos,3) }

	@ aSize[4]-160, 005 LISTBOX oDtTitulos 	Fields HEADER 'Status','Filial Origem','Pref','Titulo','Parc','Tipo','Emissใo','Vencimento','Vlr Original','Vlr Corrigido','Vlr Liquidado','Novo Vencto','Hist๓rico' SIZE 430,100 OF oFolder1:aDialogs[3] FONT oFntLBox  PIXEL //ColSizes 50,50

	@ 020, 005 LISTBOX oDtGeral 	Fields HEADER 'Status','Grupo/Cliente','Dt.Negocia็ใo','Id Negocia็ใo','Operador Abertura','Forma Pagamento','Dt.Retorno','Hr.Retorno','Dt.Ult.Cont.','Hr Ult Cont.','Resumo Ult.Contato',;
														'Observa็๕es','No.Titulos','Total Negociado','Total Recebido','Total Credito','Cliente','Loja','Grupo' SIZE (oRcp5:NRIGHT/2)-15, (oRcp5:NHEIGHT/2)-236.5 OF oFolder1:aDialogs[4] FONT oFntLBox  PIXEL //ColSizes 50,50

	@ aSize[4]-160, 005 LISTBOX oDtTitGeral 	Fields HEADER 'Status','Filial Origem','Pref','Titulo','Parc','Tipo','Emissใo','Vencimento','Vlr Original','Vlr Corrigido','Vlr Liquidado','Novo Vencto','Hist๓rico' SIZE 430,100 OF oFolder1:aDialogs[4] FONT oFntLBox  PIXEL //ColSizes 50,50

	oDtNegocia:bChange := {|| Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo...")  }
	oDtGeral:bChange := {|| Processa({|| U_RelGerTit(oDtGeral:nAt,@aTitGeral) } ,"Localizando Titulos da Negocia็ใo...")  }
	oDtGeral:bHeaderClick := {|| fTrataCol(oDtGeral:ColPos,4) }


	oDtCobCli:LADJUSTCOLSIZE := .T.
	oDtOpera:LADJUSTCOLSIZE := .T.
	oDtNegocia:LADJUSTCOLSIZE := .T.
	oDtGeral:LADJUSTCOLSIZE := .T.
	oDtTitulos:LADJUSTCOLSIZE := .T.
	oDtTitGeral:LADJUSTCOLSIZE := .T.

  	@ aSize[4]-70, 005 BUTTON oBotaoLe  PROMPT "Legenda"				ACTION (U_MstLeg(1)) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[1] 
	@ aSize[4]-70, 055 BUTTON oBotaoAt  PROMPT "Atender"				ACTION (fAtender(oDtCobCli:nAt,1),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador) } ,"Atualizando Listagem, Aguarde...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[1] 
    @ aSize[4]-70, 105 BUTTON oBotaoCnt PROMPT "Cons.Contatos"	 		ACTION (EdiCon(aCobCli[oDtCobCli:nAt,DT_CODIGO],aCobCli[oDtCobCli:nAt,DT_LOJA],1)) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[1] 
  	@ aSize[4]-70, 155 BUTTON oBotaoRef PROMPT "Refresh"				ACTION Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Refresh...") SIZE 050, 020 PIXEL OF oFolder1:aDialogs[1] 
  	@ aSize[4]-70, 205 BUTTON oBotaoRef PROMPT "Rel. Agenda"			ACTION (U_RelAge()) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[1] 
    @ aSize[4]-70, 255 BUTTON oBotaoSai PROMPT "&Sair"	 				ACTION (LibTel(),lRet:=.F.) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[1] 

  	@ aSize[4]-70, 005 BUTTON oBtnOP001  PROMPT "Legenda"				ACTION (U_MstLeg(2)) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[2] 
    @ aSize[4]-70, 055 BUTTON oBtnOP002  PROMPT "Pos.Financ."			ACTION (ConsFin(aOperador[oDtOpera:nAt,OP_CODIGO],aOperador[oDtOpera:nAt,OP_LOJA],1)) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[2] 
	@ aSize[4]-70, 105 BUTTON oBtnOP003  PROMPT "Hist๓rico"				ACTION (U_Histor(oDtOpera:nAt,1,0)) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[2] 
    @ aSize[4]-70, 255 BUTTON oBtnOP005  PROMPT "&Sair"	 				ACTION (LibTel(),lRet:=.F.) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[2] 

  	@ aSize[4]-190, 005 BUTTON oBtLgNego  PROMPT "Legenda"				ACTION (U_MstLeg(3)) 										SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3] 
	@ aSize[4]-190, 055 BUTTON oBtHsNego  PROMPT "Hist๓rico"			ACTION (U_Histor(oDtNegocia:nAt,2,nNegocia)) 					SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3] 
	@ aSize[4]-190, 105 BUTTON oBotaoRea  PROMPT "Agendamento"			ACTION (Reagen(aNegocia[oDtNegocia:nAt,NG_IDNEG],oDtNegocia:nAt,1),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) 								SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3] 
	@ aSize[4]-190, 155 BUTTON oBotaoHis  PROMPT "Status"				ACTION (SelStat(aNegocia[oDtNegocia:nAt,NG_IDNEG],oDtNegocia:nAt,1)) 								SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3] 
  	@ aSize[4]-190, 205 BUTTON oBtBuscar  PROMPT "Financeiro"			ACTION (Processa({|| fTitVenc(oDtOpera:nAt,oDtNegocia:nAt) } ,"Refresh..."),Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Titulos..."),Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo..."),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3]  
  	@ aSize[4]-190, 255 BUTTON oBtBuscar  PROMPT "Refaz Saldo"			ACTION (Processa({|| U_NegSaldo(aNegocia[oDtNegocia:nAt,NG_IDNEG]) } ,"Refresh..."),Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Titulos..."),Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo..."),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3]  
  	@ aSize[4]-190, 305 BUTTON oBtBuscar  PROMPT "Manut Negocia็ใo"		ACTION (Processa({|| MntNeg(aNegocia[oDtNegocia:nAt,NG_IDNEG]) } ,"Aguarde Carregando Negocia็ใo..."),Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Titulos..."),Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo..."),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3]  

    @ aSize[4]-190, 355 BUTTON oBotaoSai2 PROMPT "&Sair"	 			ACTION (LibTel(),lRet:=.F.) 								SIZE 050, 020 PIXEL OF oFolder1:aDialogs[3] 

  	@ aSize[4]-190, 005 BUTTON oBtLgNego  PROMPT "Legenda"				ACTION (U_MstLeg(3)) 										SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 
	@ aSize[4]-190, 055 BUTTON oBtHsNego  PROMPT "Hist๓rico"			ACTION (U_Histor(oDtGeral:nAt,3,aGeral[oDtGeral:nAt,NG_IDNEG])) 					SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 
	@ aSize[4]-190, 105 BUTTON oBotaoRea  PROMPT "Agendamento"			ACTION (Reagen(aGeral[oDtGeral:nAt,NG_IDNEG],oDtGeral:nAt,2),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) 								SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 
	@ aSize[4]-190, 155 BUTTON oBotaoHis  PROMPT "Status"				ACTION (SelStat(aGeral[oDtGeral:nAt,NG_IDNEG],oDtGeral:nAt,2)) 								SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 
  	@ aSize[4]-190, 205 BUTTON oBtBuscar  PROMPT "Manut Negocia็ใo"		ACTION (Processa({|| MntNeg(aGeral[oDtGeral:nAt,NG_IDNEG]) } ,"Aguarde Carregando Negocia็ใo..."),Processa({|| U_RelGerTit(oDtGeral:nAt,@aTitGeral,2) } ,"Localizando Titulos da Negocia็ใo..."),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4]  
  	@ aSize[4]-190, 255 BUTTON oBotaoRef  PROMPT "Rel. Negocia็๕es"		ACTION (U_RelNeg()) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 
  	@ aSize[4]-190, 305 BUTTON oBtBuscar  PROMPT "Financeiro"			ACTION (Processa({|| fTitVenc(oDtOpera:nAt,oDtNegocia:nAt,aGeral[oDtGeral:nAt,NG_IDNEG]) } ,"Refresh..."),Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Titulos..."),Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo..."),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4]  
  	@ aSize[4]-190, 355 BUTTON oBtBuscar  PROMPT "Refaz Saldo"			ACTION (Processa({|| U_NegSaldo(aGeral[oDtGeral:nAt,NG_IDNEG]) } ,"Refresh..."),Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Titulos..."),Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo..."),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4]  
  	@ aSize[4]-190, 405 BUTTON oBtBuscar  PROMPT "Troca Operador"		ACTION (U_TrcOpe(aGeral[oDtGeral:nAt,NG_IDNEG]),Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) 					SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 
  	@ aSize[4]-190, 455 BUTTON oBtBuscar  PROMPT "Filtros"				ACTION (Processa({|| FGeral(@aGeral,.T.) } ,"Filtrando Aguarde...")) SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 

    @ aSize[4]-190, 505 BUTTON oBotaoSai2 PROMPT "&Sair"	 			ACTION (LibTel(),lRet:=.F.) 								SIZE 050, 020 PIXEL OF oFolder1:aDialogs[4] 

    @ 007, 005 SAY oCliNeg PROMPT "" 		SIZE 200, 010 COLOR CLR_RED   PIXEL OF oFolder1:aDialogs[3]

    @ aSize[4]-190, 460 SAY oSay11 PROMPT "Total Geral Aberto: " 		SIZE 200, 010 COLOR CLR_BLACK   PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-175, 460 SAY oSay12 PROMPT "Total Geral Liquidado: " 	SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-160, 460 SAY oSay13 PROMPT "Total Geral Saldo: " 		SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[3]

    @ aSize[4]-190, 570 SAY oSay14 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK   PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-175, 570 SAY oSay15 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-160, 570 SAY oSay16 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[3]

    @ aSize[4]-160, 460 SAY oSay21 PROMPT "Total Geral Aberto: " 		SIZE 200, 010 COLOR CLR_BLACK   PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-145, 460 SAY oSay22 PROMPT "Total Geral Liquidado: " 	SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-130, 460 SAY oSay23 PROMPT "Total Geral Saldo: " 		SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[4]

    @ aSize[4]-160, 570 SAY oSay24 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK   PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-145, 570 SAY oSay25 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-130, 570 SAY oSay26 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[4]

    oCliNeg:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay11:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay12:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay13:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay14:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay15:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay16:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)

    oSay21:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay22:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay23:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay24:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay25:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)
    oSay26:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)

    @ aSize[4]-050, 005 SAY oSayZ1 PROMPT "Titulos Em Aberto: " 		SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-050, 185 SAY oSayZ2 PROMPT "Titulos Liquidados: " 		SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-050, 365 SAY oSayZ3 PROMPT "Saldo Total: " 				SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[3]

    @ aSize[4]-050, 085 SAY oSayY1 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK   PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-050, 245 SAY oSayY2 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[3]
    @ aSize[4]-050, 445 SAY oSayY3 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[3]

    @ aSize[4]-050, 005 SAY oSayW1 PROMPT "Titulos Em Aberto: " 		SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-050, 185 SAY oSayW2 PROMPT "Titulos Liquidados: " 		SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-050, 365 SAY oSayW3 PROMPT "Saldo Total: " 				SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[4]

    @ aSize[4]-050, 085 SAY oSayT1 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK   PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-050, 245 SAY oSayT2 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK  PIXEL OF oFolder1:aDialogs[4]
    @ aSize[4]-050, 445 SAY oSayT3 PROMPT TransForm(0,"@E 9,999,999,999.99") SIZE 200, 010 COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[4]

    oSayZ1:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayZ2:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayZ3:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayY1:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayY2:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayY3:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayW1:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayW2:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayW3:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayT1:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayT2:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
    oSayT3:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)

	Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")
	Processa({|| U_BsqTit(1,@aTitulos) } ,"Localizando Titulos da Negocia็ใo...") 
	Processa({|| U_RelGerTit(1,@aTitGeral,2) } ,"Localizando Titulos da Negocia็ใo...") 

	fLBoxRef()

	nOpc := 0

	oFolder1:nOption := 2
	oFolder1:Refresh()

	oFolder1:aDialogs[3]:lReadonly := .T.
	oFolder1:aDialogs[4]:lReadonly := (cTipOpe=='N')

	@ 007, 005 SAY 	oBsqGrup PROMPT "Grupo: "  		SIZE 200, 010 OF oFolder1:aDialogs[1] COLORS CLR_BLACK,CLR_WHITE PIXEL
	@ 007, 205 SAY 	oBsqNome PROMPT "Nome: "  		SIZE 200, 010 OF oFolder1:aDialogs[1] COLORS CLR_BLACK,CLR_WHITE PIXEL

    oBsqGrup:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oBsqNome:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)

	@ 007, 005 SAY 	oBsqGru1 PROMPT "Grupo: "  		SIZE 200, 010 OF oFolder1:aDialogs[4] COLORS CLR_BLACK,CLR_WHITE PIXEL
	@ 007, 205 SAY 	oBsqNom1 PROMPT "Nome: "  		SIZE 200, 010 OF oFolder1:aDialogs[4] COLORS CLR_BLACK,CLR_WHITE PIXEL

    oBsqGru1:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oBsqNom1:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)

	@ 006,040 MsGet oGetGrp Var cFilGrp F3 "SZ5" 				Valid (fFilGrp(cFilGrp,@cFilNgr) .And. Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) Size 050,010 PIXEL OF oFolder1:aDialogs[1] COLORS CLR_BLUE,CLR_WHITE PIXEL
	@ 006,100 MsGet oGetNGr Var cFilNgr Picture "@!" 			WHEN .F. Size 080,010 PIXEL OF oFolder1:aDialogs[1] COLORS CLR_BLUE,CLR_WHITE PIXEL
	@ 006,240 MsGet oGetNom Var cFilNom Picture "@!"  			Valid (Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) Size 100,010 PIXEL OF oFolder1:aDialogs[1] COLORS CLR_BLUE,CLR_WHITE PIXEL

	@ 006,040 MsGet oGetGr1 Var cFilGr1 F3 "SZ5" 				Valid (fFilGrp(cFilGr1,@cFilNg1) .And. Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) Size 050,010 PIXEL OF oFolder1:aDialogs[4] COLORS CLR_BLUE,CLR_WHITE PIXEL
	@ 006,100 MsGet oGetNG1 Var cFilNg1 Picture "@!" 			WHEN .F. Size 080,010 PIXEL OF oFolder1:aDialogs[4] COLORS CLR_BLUE,CLR_WHITE PIXEL
	@ 006,240 MsGet oGetNo1 Var cFilNo1 Picture "@!"  			Valid (Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.T.) } ,"Aguarde Selecionando Clientes e Grupo de Clientes...")) Size 100,010 PIXEL OF oFolder1:aDialogs[4] COLORS CLR_BLUE,CLR_WHITE PIXEL

	@ 007, 005 SAY 	oNomOper PROMPT __cUserId + " - " + UsrFullName(__cUserId) 		SIZE 300, 010 OF oFolder1:aDialogs[2] COLORS CLR_RED,CLR_WHITE PIXEL

    oGetGrp:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oGetNom:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oGetNGr:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oGetGr1:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oGetNo1:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oGetNG1:oFont := TFont():New('Arial',,14,,.T.,,,,.T.,.F.)
    oNomOper:oFont := TFont():New('Arial',,24,,.T.,,,,.T.,.F.)

	ACTIVATE MSDIALOG oRcp5 CENTERED 
	
	If nOpc == 1
	Endif

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ LibTel() บAutor  ณ Luiz Alberto      บ Data ณ  26/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Libera Marcacao de Cliente e Browse para Nova Marca็ใo
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function LibTel()

If MsgYesNo("Deseja Realmente Sair do Painel de Cobran็a ? ",OemToAnsi('ATENCAO'))
	Close(oRcp5)
	Return .F.
Endif
Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ MstLeg     บAutor  ณ Luiz Alberto V Alvesบ Data ณ  25/03/15บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Tela de Legenda dos Status do Ciclo                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MstLeg(nTipo)
Local aCorDesc

cTitulo := 'Legenda Financeiro'

If nTipo == 1	// Tela Clientes
	aCorDesc := {	{"BR_VERDE"   ," Vencidos em At้ 3 Dias" } ,; 
					{"BR_AMARELO" ," Vencidos em At้ 10 Dias" } ,; 
					{"BR_LARANJA" ," Vencidos em At้ 30 Dias" } ,; 
					{"BR_VERMELHO"," Vencidos em At้ 60 Dias"},;
					{"BR_PRETO"   ," Vencidos Mais 60 Dias"},;
					{"BR_BRANCO"  ," Titulo em Aberto"}}
ElseIf nTipo == 2
	aCorDesc := {	{"BR_AZUL"    ," Cliente Com Negocia็ใo Em Aberto" } ,; 
					{"BR_BRANCO"  ," Cliente Nใo Possui Negocia็ใo" } }
ElseIf nTipo == 3
	If GetNewPar("MV_XEMPCB",2)	== 1 // 1 fcommit()
		aCorDesc := {	{"BR_VERMELHO"  ," Liquidado" } ,; 
						{"BR_VIOLETA" 	," Juridico" } ,; 
						{"BR_PINK" 		," Cheque Cust๓dia" } ,; 
						{"BR_VERDE"		," Contactado"},;
						{"BR_PRETO"   	," Negativado"},;
						{"BR_AZUL"   	," Liquidado Parcial"},;
						{"BR_LARANJA"  	," Em Andamento"},;
						{"BR_BRANCO"  	," Negociado Aguardando"},;
						{"BR_CINZA"  	," Negocia็ใo Cancelado"}}
	ElseIf GetNewPar("MV_XEMPCB",2)	== 2 // 2 Grupo
		aCorDesc := {	{"BR_VERMELHO"  ," Liquidado" } ,; 
						{"BR_VIOLETA" 	," Cobran็a Extrajudicial" } ,; 
						{"BR_PINK" 		," Cobran็a Externalizada" } ,; 
						{"BR_VERDE"		," Contactado"},;
						{"BR_PRETO"   	," Cliente Negativado"},;
						{"BR_AZUL"   	," Liquidado Parcial"},;
						{"BR_LARANJA"  	," Cobran็a em Andamento"},;
						{"BR_BRANCO"  	," Decisใo Comit๊ Estrat้gico"},;
						{"BR_CINZA"  	," Negocia็ใo Cancelada"}}
	Endif
Endif
BrwLegenda(cTitulo, "Status", aCorDesc )

Return( .T. )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function RetLeg(nTipo,nPos)

DEFAULT nTipo := 1

If nTipo == 1
	dTitVen	:=	aCobCli[nPos,DT_FINAN]
ElseIf nTipo == 2
	cStatus := aNegocia[nPos,NG_STATUS]
ElseIf nTipo == 3
	cStatus := aGeral[nPos,NG_STATUS]
Endif

If nTipo == 1 
	If dTitVen >= (dDataBase-3)	// Esta para Vencer Mais de 15 Dias
		Return oLegVerde
	ElseIf dTitVen < (dDataBase-3) .And. dTitVen >= (dDataBase-10)	// Esta para Vencer nos Proximos 15 Dias
		Return oLegAmarelo
	ElseIf dTitVen < (dDataBase-10) .And. dTitVen >= (dDataBase-30)	// Esta para Vencer nos Proximos 15 Dias
		Return oLegLaranja
	ElseIf dTitVen < (dDataBase-30) .And. dTitVen >= (dDataBase-60)	// Esta para Vencer nos Proximos 15 Dias
		Return oLegVermelho
	ElseIf dTitVen < (dDataBase-60) // Esta para Vencer nos Proximos 15 Dias
		Return oLegPreto
	Else
		Return oLegBranco
	Endif
ElseIf nTipo == 2
	If cStatus == '1'		// Liquidado
		Return oLegVermelho
	ElseIf cStatus == '2'	// Juridico
		Return oLegVioleta
	ElseIf cStatus == '3'	// Cheque Custodia
		Return oLegRosa
	ElseIf cStatus == '4'	// Contactado
		Return oLegVerde
	ElseIf cStatus == '5'	// Negativado
		Return oLegPreto
	ElseIf cStatus == '6'	// Liquidado Parcial 
		Return oLegAzul
	ElseIf cStatus == '7'	// Andamento
		Return oLegLaranja
	ElseIf cStatus == '8'	// Negociado
		Return oLegBranco
	ElseIf cStatus == 'C'	// Cancelado
		Return oLegCinza
	ElseIf cStatus == 'E'	// Encerrado
		Return oLegAmarelo
	Endif
ElseIf nTipo == 3
	If cStatus == '1'		// Liquidado
		Return oLegVermelho
	ElseIf cStatus == '2'	// Juridico
		Return oLegVioleta
	ElseIf cStatus == '3'	// Cheque Custodia
		Return oLegRosa
	ElseIf cStatus == '4'	// Contactado
		Return oLegVerde
	ElseIf cStatus == '5'	// Negativado
		Return oLegPreto
	ElseIf cStatus == '6'	// Liquidado Parcial 
		Return oLegAzul
	ElseIf cStatus == '7'	// Andamento
		Return oLegLaranja
	ElseIf cStatus == '8'	// Negociado
		Return oLegBranco
	ElseIf cStatus == 'C'	// Cancelado
		Return oLegCinza
	ElseIf cStatus == 'E'	// Encerrado
		Return oLegAmarelo
	Endif
Endif


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fContato บAutor  ณ Luiz Alberto     Data ณ  07/07/2015  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function fContato(cCodigo,cLoja,nPos,lProspect)
Local aArea := GetArea()
Local oBotaoInc
Local oBotaoAlt
Local oBotaoSai
Local oBotaoVis
Local oBotaoAdd
Private aContat	:= {{'','','','','','','',0}}
Private oCntCli
Private oDlgCnt
Private cCadastro	:=	'Cadastro de Contatos'

DEFAULT cCodigo := Space(06)
DEFAULT cLoja := Space(02)
DEFAULT nPos := 0


INCLUI := .f.
ALTERA := .f.
lProspect := .f.
lConcorre := .f.
lOportu := .f.

SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))

aRotina := { { "Pesquisar","AxPesqui"	,0	, 1,0,.F.},;	//
             { "Visualizar","AxVisual"	,0	, 2,0,Nil},;	//
             { "Incluir", "AxInclui"	,0	, 3,0,Nil},;	//
             { "Alterar", "AxAltera"	,0	, 4,0,Nil},;	//
             { "Excluir", "AxExclui"	,0	, 5,3,Nil} }	//   

INCLUI := .F.
ALTERA := .T.

RegToMemory("SA1",.f.)
RegToMemory("SU5",.f.)

DEFINE MSDIALOG oDlgCnt TITLE "Contatos do Cliente: " + SA1->A1_COD +'/'+ SA1->A1_LOJA + ' - ' + Capital(AllTrim(SA1->A1_NOME)) FROM 000, 000  TO 300, 800 COLORS 0, 16777215 PIXEL 

    @ 010, 005 LISTBOX oCntCli Fields HEADER "Contato",'Cargo','DDD','Fone Cml','Fone Cml','Celular','Email' SIZE 395, 120 OF oDlgCnt PIXEL //ColSizes 50,50


    oCntCli:SetArray(aContat)
    oCntCli:bLine := {|| {		aContat[oCntCli:nAt,1],;
        						aContat[oCntCli:nAt,2],;
        						aContat[oCntCli:nAt,3],;
        						aContat[oCntCli:nAt,4],;
        						aContat[oCntCli:nAt,5],;
        						aContat[oCntCli:nAt,6],;
        						aContat[oCntCli:nAt,7]}}

	ProcCont(@aContat,cCodigo,cLoja,lProspect)



	nOpc := 0
	
    @ 135, 005 BUTTON oBotaoInc PROMPT "&Inclui" 			ACTION (INCLUI:=.t.,ALTERA:=.F.,IncCont(lProspect),ProcCont(@aContat,cCodigo,cLoja,lProspect),nOpc:=0) SIZE 050, 010 OF oDlgCnt PIXEL
    @ 135, 055 BUTTON oBotaoAlt PROMPT "&Altera" 			ACTION (INCLUI:=.F.,ALTERA:=.t.,SU5->(dbGoTo(aContat[oCntCli:nAt,8])),axAltera("SU5",SU5->(Recno()),4),ProcCont(@aContat,cCodigo,cLoja,lProspect),nOpc:=0) SIZE 050, 010 OF oDlgCnt PIXEL
    @ 135, 105 BUTTON oBotaoAlt PROMPT "&Excluir" 			ACTION (SU5->(dbGoTo(aContat[oCntCli:nAt,8])),ExcCont(cCodigo,cLoja,lProspect),ProcCont(@aContat,cCodigo,cLoja,lProspect),nOpc:=0) SIZE 050, 010 OF oDlgCnt PIXEL
    @ 135, 155 BUTTON oBotaoAlt PROMPT "&Pesquisa" 			ACTION (PsqCont(cCodigo,cLoja,lProspect),ProcCont(@aContat,cCodigo,cLoja,lProspect),nOpc:=0) SIZE 050, 010 OF oDlgCnt PIXEL
    @ 135, 205 BUTTON oBotaoAlt PROMPT "&Seleciona"			ACTION (SU5->(dbGoTo(aContat[oCntCli:nAt,8])),Close(oDlgCnt),nOpc:=0) SIZE 050, 010 OF oDlgCnt PIXEL
    @ 135, 255 BUTTON oBotaoSai PROMPT "&Sair"	 			ACTION (Close(oDlgCnt),nOpc:=0) SIZE 050, 010 OF oDlgCnt PIXEL
	
	ACTIVATE MSDIALOG oDlgCnt CENTERED
	
	If nOpc == 1
	Endif

//RestArea(aArea)
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcCont(aContat,cCodigo,cLoja,lProspect)

If Select("CHK1") <> 0
	CHK1->(dbCloseArea())
Endif

If !lProspect
	cQuery := 	 " SELECT U5_CONTAT, U5_DDD, U5_FCOM1, U5_FCOM2, U5_CELULAR, U5_EMAIL, ISNULL(UM.UM_DESC,'') UM_DESC, SU5.R_E_C_N_O_ U5_REG " + CRLF
	cQuery +=	 " FROM " + RetSqlName("AC8")+" AC8 " + CRLF
	cQuery +=	 " INNER JOIN " + RetSqlName("SU5")+" SU5 " + CRLF
	cQuery +=	 " ON U5_CODCONT = AC8.AC8_CODCON AND SU5.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " LEFT JOIN " + RetSqlName("SUM")+" UM " + CRLF
	cQuery +=	 " ON UM.UM_CARGO = SU5.U5_FUNCAO AND UM.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " WHERE AC8.AC8_ENTIDA = 'SA1' " + CRLF
	cQuery +=	 " AND AC8.AC8_CODENT = '" + cCodigo+cLoja+"' " + CRLF
	cQuery +=	 " AND AC8.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " ORDER BY U5_CONTAT " + CRLF
Else
	cQuery := 	 " SELECT U5_CONTAT, U5_DDD, U5_FCOM1, U5_FCOM2, U5_CELULAR, U5_EMAIL, ISNULL(UM.UM_DESC,'') UM_DESC, SU5.R_E_C_N_O_ U5_REG " + CRLF
	cQuery +=	 " FROM " + RetSqlName("AC8")+" AC8 " + CRLF
	cQuery +=	 " INNER JOIN " + RetSqlName("SU5")+" SU5 " + CRLF
	cQuery +=	 " ON U5_CODCONT = AC8.AC8_CODCON AND SU5.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " LEFT JOIN " + RetSqlName("SUM")+" UM " + CRLF
	cQuery +=	 " ON UM.UM_CARGO = SU5.U5_FUNCAO AND UM.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " WHERE AC8.AC8_ENTIDA = 'SUS' " + CRLF
	cQuery +=	 " AND AC8.AC8_CODENT = '" + cCodigo+cLoja+"' " + CRLF
	cQuery +=	 " AND AC8.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " ORDER BY U5_CONTAT " + CRLF
Endif	
TCQUERY cQuery NEW ALIAS "CHK1"

Count To nReg

CHK1->(dbGoTop())

dbSelectArea("CHK1")
dbGoTop()    
ProcRegua(nReg)     

If Empty(nReg)
	aContat := {{'','','','','','','',0}}
Else
	aContat := {}
Endif

While CHK1->(!Eof())
	IncProc("Aguarde Localizando Contatos do Cliente Posicionado ")
	
	AAdd(aContat,{  Capital(CHK1->U5_CONTAT),;
					Capital(CHK1->UM_DESC),;
					CHK1->U5_DDD,;
					CHK1->U5_FCOM1,;
					CHK1->U5_FCOM2,;
					CHK1->U5_CELULAR,;
					CHK1->U5_EMAIL,;
					CHK1->U5_REG})

	CHK1->(dbSkip(1))
Enddo
CHK1->(dbCloseArea())

aSort(aContat,,,{|x,y|,x[1] < y[1]})

oCntCli:SetArray(aContat)
oCntCli:bLine := {|| {		aContat[oCntCli:nAt,1],;
       						aContat[oCntCli:nAt,2],;
       						aContat[oCntCli:nAt,3],;
       						aContat[oCntCli:nAt,4],;
       						aContat[oCntCli:nAt,5],;
       						aContat[oCntCli:nAt,6],;
       						aContat[oCntCli:nAt,7]}}
oCntCli:Refresh()
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function IncCont(lProspect)

nOpc := axInclui("SU5",0,3)

If nOpc == 1
	If RecLock("AC8",.t.)
		AC8->AC8_FILIAL	:=	xFilial("AC8")
		AC8->AC8_ENTIDA	:=	Iif(!lProspect,"SA1",'SUS')
		AC8->AC8_CODENT	:=	SA1->A1_COD+SA1->A1_LOJA
		AC8->AC8_CODCON	:=	SU5->U5_CODCONT
		AC8->(MsUnlock())
	Endif
Endif

Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PsqCont(cCodigo,cLoja,lProspect)
Local aArea := GetArea()

lRet := ConPad1( ,,,'SU5',,,.F. )

If lRet
	cQuery := 	 " SELECT U5_CONTAT " + CRLF
	cQuery +=	 " FROM " + RetSqlName("AC8")+" AC8 " + CRLF
	cQuery +=	 " INNER JOIN " + RetSqlName("SU5")+" SU5 " + CRLF
	cQuery +=	 " ON U5_CODCONT = AC8.AC8_CODCON AND SU5.D_E_L_E_T_ = '' AND U5_CODCONT = '" + SU5->U5_CODCONT + "' " + CRLF
	cQuery +=	 " LEFT JOIN " + RetSqlName("SUM")+" UM " + CRLF
	cQuery +=	 " ON UM.UM_CARGO = SU5.U5_FUNCAO AND UM.D_E_L_E_T_ = '' " + CRLF
	If !lProspect3
		cQuery +=	 " WHERE AC8.AC8_ENTIDA = 'SA1' " + CRLF
	Else
		cQuery +=	 " WHERE AC8.AC8_ENTIDA = 'SUS' " + CRLF
	Endif
	cQuery +=	 " AND AC8.AC8_CODENT = '" + cCodigo+cLoja+"' " + CRLF
	cQuery +=	 " AND AC8.D_E_L_E_T_ = '' " + CRLF
	cQuery +=	 " ORDER BY U5_CONTAT " + CRLF
		
	TCQUERY cQuery NEW ALIAS "CHK1"
	
	If !Empty(CHK1->U5_CONTAT)
		CHK1->(dbCloseArea())
		RestArea(aArea)
		MsgStop("Aten็ใo Contato Jแ Pertence ao Cliente Selecionado !")
		Return .f.
	Endif
	
	CHK1->(dbCloseArea())

	If RecLock("AC8",.t.)
		AC8->AC8_FILIAL	:=	xFilial("AC8")
		AC8->AC8_ENTIDA	:=	Iif(!lProspect,"SA1",'SUS')
		AC8->AC8_CODENT	:=	cCodigo+cLoja
		AC8->AC8_CODCON	:=	SU5->U5_CODCONT
		AC8->(MsUnlock())
	Endif
Endif

RestArea(aArea)
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcCont(cCodigo,cLoja,lProspect)
Local aArea := GetArea()

If MsgNoYes("Deseja Realmente Excluir o Relacionamento com Este Contato ? ",OemToAnsi('ATENCAO'))
	If SUC->(dbSetOrder(6), DbSeek(xFilial("SUC")+SU5->U5_CODCONT)) .And. Empty(SUC->UC_DTENCER)
		MsgStop("Contato Possui Atendimento em Aberto - Numero: " + SUC->UC_CODIGO + " Nใo Pode Ser Excluido !","Aten็ใo")	
		Return .f.
	Endif

	If SUA->(dbSetOrder(11), DbSeek(xFilial("SUA")+SU5->U5_CODCONT)) .And. SUA->UA_CLIENTE+SUA->UA_LOJA == cCodigo+cLoja
		MsgStop("Contato Possui Or็amento - Numero: " + SUA->UA_NUM + " Nใo Pode Ser Excluido !","Aten็ใo")	
		Return .f.
	Endif

	If AC8->(dbSetOrder(1), dbSeek(xFilial("AC8")+SU5->U5_CODCONT+Iif(!lProspect,'SA1','SUS')+xFilial("AC8")+cCodigo+cLoja))
		If RecLock("AC8",.f.)
			AC8->(dbDelete())
			AC8->(MsUnlock())
		Endif
	Endif
Endif

RestArea(aArea)
Return .t.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrcCob(aCobCli,cFilGrp,cFilNom,aOperador,aGeral,aTitGeral,lGeral)
Local aArea := GetArea()

DEFAULT aCobCli := {}
DEFAULT lGeral  := .T.
DEFAULT aGeral  := {}
DEFAULT aTitGeral:= {}
	
If lGeral
	aCobCli := {}  

	// Processando Clientes Comuns

	cQuery := 	 "  SELECT DISTINCT ISNULL(Z5_GRUPO,'') Z5_GRUPO, ISNULL(Z5_NOME,'') Z5_NOME, A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, A1_DDD, A1_TEL, A1_TELEX, A1_COMPLEM, A1_CONTATO, " + CRLF
	cQuery +=	 " 		A1_EMAIL, " + CRLF
	cQuery +=	 " 		A1_VEND,  " + CRLF
	cQuery +=	 " 		A1_ULTCOM ,  " + CRLF
	cQuery +=	 " 		A1_NROCOM ,  " + CRLF
	cQuery +=	 " 		A1.R_E_C_N_O_ A1REG, " + CRLF
	cQuery +=	 " 		A1_CGC ,  " + CRLF
	If SA1->(FieldPos("A1_CLIVIP")) > 0
		cQuery +=	 " 		A1_CLIVIP ,  " + CRLF
	Endif
	cQuery +=	 " 		A1_MUN, " + CRLF
	cQuery +=	 " 		E1.TITULO " + CRLF
	cQuery +=	 " FROM " + RetSqlName("SA1") + " A1 (NOLOCK) " + CRLF
	cQuery += 	 " LEFT JOIN (SELECT E1_CLIENTE, E1_LOJA, MIN(E1_VENCREA) TITULO FROM " + RetSqlName("SE1") + " (NOLOCK) WHERE D_E_L_E_T_ = '' AND E1_FILIAL = '" + xFilial("SE1") + "' AND E1_SALDO > 0 AND E1_TIPO IN "+FormatIn(GetNewPar("MV_XCOBTIP",'NF;FT;RA;NCC'),";") + " GROUP BY E1_CLIENTE, E1_LOJA)  E1 " + CRLF
	cQuery += 	 " ON E1.E1_CLIENTE = A1.A1_COD AND E1.E1_LOJA = A1.A1_LOJA " + CRLF
	cQuery += 	 " LEFT JOIN " + RetSqlName("SZ5") + " Z5 (NOLOCK) " 
	cQuery += 	 " ON Z5.Z5_GRUPO = A1.A1_XGRUPO AND Z5.D_E_L_E_T_ = '' AND Z5.Z5_FILIAL = '" + xFilial("SZ5") + "' " + CRLF
	cQuery +=	 " WHERE   A1_FILIAL = '" + xFilial("SA1") + "' " + CRLF
	cQuery +=	 " AND A1.D_E_L_E_T_ = ''   " + CRLF
	cQuery +=	 " AND A1.A1_MSBLQL <> '1' "       + CRLF
	cQuery +=	 " AND E1.TITULO BETWEEN '" + DtoS(dDtIni) + "' AND '" + DtoS(dDtFim) + "' "       + CRLF
	If !Empty(cFilGrp)
		cQuery +=	 " AND Z5.Z5_GRUPO = '" + cFilGrp + "' "       + CRLF
	Endif
	If !Empty(cFilNom)
		cQuery +=	 " AND A1.A1_NOME LIKE '%" + AllTrim(cFilNom) + "%' "       + CRLF
	Endif
	cQuery +=	 " AND A1.A1_XOPENEG = '' " + CRLF
	cQuery +=	 " ORDER BY Z5_GRUPO, Z5_NOME, A1_COD, A1_LOJA  "  + CRLF

		
	TCQUERY cQuery NEW ALIAS "CHK1"

	TcSetField('CHK1','A1_ULTCOM','D')
	TcSetField('CHK1','TITULO','D')

	Count To nReg

	CHK1->(dbGoTop())

	dbSelectArea("CHK1")
	dbGoTop()    
	ProcRegua(nReg)

	nConta := 0
	While CHK1->(!Eof())
		IncProc("Clientes e Grupos " + AllTrim(Str(nConta))+' de '+AllTrim(Str(nReg)) + "... ")     
		
		SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+CHK1->A1_COD+CHK1->A1_LOJA))

		nAchou := 0

		If !Empty(CHK1->Z5_GRUPO)
			SA1->(dbSetOrder(14), dbSeek(xFilial("SA1")+CHK1->Z5_GRUPO))
			nAchou := Ascan(aCobCli,{|x| AllTrim(x[DT_GRUPO])==AllTriM(CHK1->Z5_GRUPO)})
		Endif
		
		++nConta

		//Iif(!Empty(aCobCli[oDtCobCli:nAt,DT_NOMEGRP]) .And. GetNewPar("MV_XNCGRP",.F.),
		
		If Empty(nAchou)
			AAdd(aCobCli,{'2',;
							oNo,;		// 1											
							CHK1->Z5_GRUPO,;                                      // 3
							CHK1->Z5_NOME,;                                      // 4
							SA1->A1_COD,;                                      // 3
							SA1->A1_LOJA,;                                     // 4
							Iif(Len(AllTrim(SA1->A1_CGC))<14,TransForm(SA1->A1_CGC,'@R 999.999.999-99'),TransForm(SA1->A1_CGC,'@R 99.999.999/9999-99')),;                                      // 5
							SA1->A1_NOME,;                                     // 6
							SA1->A1_ULTCOM,;                                   // 7
							SA1->A1_NROCOM,;                                   // 8
							SA1->A1_DDD,;                                       // 9
							SA1->A1_TEL,;                                       // 10
							SA1->A1_TELEX,;                                    // 11
							SA1->A1_CONTATO,;                                   // 12
							SA1->A1_NREDUZ,;                                   // 13
							SA1->A1_MUN,; 										// 14
							Lower(SA1->A1_EMAIL),;                              // 15
							SA1->A1_COMPLEM,;                                  // 16
							SA1->(Recno()),;
							CHK1->TITULO,;
							Iif(!Empty(CHK1->Z5_GRUPO),'1','2'),;
							IIF(SA1->(FieldPos("A1_CLIVIP")) > 0,CHK1->A1_CLIVIP,'')})										// 17

			dUltCom := CHK1->A1_ULTCOM
		Endif

		CHK1->(dbSkip(1))
	Enddo
	CHK1->(dbCloseArea())

	If Empty(nReg) .Or. Empty(nConta)
		aCobCli := {}
		AAdd(aCobCli,{'2',;
						oNo,;		// 1											
						'',;                                      // 3
						'',;                                      // 3
						'',;                                      // 3
						'',;                                     // 4
						'',;                                      // 5
						'',;                                     // 6
						CtoD(''),;                                   // 7
						0,;                                   // 8
						'',;                                       // 9
						'',;                                       // 10
						'',;                                    // 11
						'',;                                   // 12
						'',;                                   // 13
						'',; 										// 14
						'',;                              // 15
						'',;                                  // 16
						0,;
						CtoD(''),;
						'1',;
						''})										// 17

	Endif
	aSort(aCobCli,,,{|x,y|,x[DT_ORDEM]+x[DT_NOMECLI] < y[DT_ORDEM]+y[DT_NOMECLI]})
Endif

// Processando Carteira Operador

aOperador := {}

cQuery := 	 "  SELECT DISTINCT ISNULL(Z5_GRUPO,'') Z5_GRUPO, ISNULL(Z5_NOME,'') Z5_NOME, A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, A1_DDD, A1_TEL, A1_TELEX, A1_COMPLEM, A1_CONTATO, " + CRLF
cQuery +=	 " 		A1_EMAIL, " + CRLF
cQuery +=	 " 		A1_VEND,  " + CRLF
cQuery +=	 " 		A1_ULTCOM ,  " + CRLF
cQuery +=	 " 		A1_NROCOM ,  " + CRLF
cQuery +=	 " 		A1.R_E_C_N_O_ A1REG, " + CRLF
cQuery +=	 " 		A1_CGC ,  " + CRLF
If SA1->(FieldPos("A1_CLIVIP")) > 0
	cQuery +=	 " 		A1_CLIVIP ,  " + CRLF
Endif
cQuery +=	 " 		A1_MUN " + CRLF
cQuery +=	 " FROM " + RetSqlName("SA1") + " A1 (NOLOCK) " + CRLF
cQuery += 	 " LEFT JOIN " + RetSqlName("SZ5") + " Z5 (NOLOCK) " 
cQuery += 	 " ON Z5.Z5_GRUPO = A1.A1_XGRUPO AND Z5.D_E_L_E_T_ = '' AND Z5.Z5_FILIAL = '" + xFilial("SZ5") + "' " + CRLF
cQuery +=	 " WHERE   A1_FILIAL = '" + xFilial("SA1") + "' " + CRLF
cQuery +=	 " AND A1.D_E_L_E_T_ = ''   " + CRLF
cQuery +=	 " AND A1.A1_MSBLQL <> '1' "       + CRLF
If !Empty(cFilGrp)
	cQuery +=	 " AND Z5.Z5_GRUPO = '" + cFilGrp + "' "       + CRLF
Endif
If !Empty(cFilNom)
	cQuery +=	 " AND A1.A1_NOME LIKE '%" + AllTrim(cFilNom) + "%' "       + CRLF
Endif
cQuery +=	 " AND A1.A1_XOPENEG = '" + __cUserId + "' " + CRLF
cQuery +=	 " ORDER BY Z5_GRUPO, Z5_NOME, A1_COD, A1_LOJA  "  + CRLF

	
TCQUERY cQuery NEW ALIAS "CHK1"

TcSetField('CHK1','A1_ULTCOM','D')

Count To nReg

CHK1->(dbGoTop())

dbSelectArea("CHK1")
dbGoTop()    
ProcRegua(nReg)

nConta := 0
While CHK1->(!Eof())
	IncProc("Carteira Operador " + AllTrim(Str(nConta))+' de '+AllTrim(Str(nReg)) + "... ")     
	
	SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+CHK1->A1_COD+CHK1->A1_LOJA))

	nAchou := 0

	If !Empty(CHK1->Z5_GRUPO)
		SA1->(dbSetOrder(14), dbSeek(xFilial("SA1")+CHK1->Z5_GRUPO))
	
		nAchou := Ascan(aOperador,{|x| AllTrim(x[OP_GRUPO])==AllTriM(CHK1->Z5_GRUPO)})
	Endif
	
	++nConta
	
	If Empty(nAchou)

		cQuery :=	 " SELECT Count(*) QTNEG FROM " + RetSqlName("PW3") + " PW3 (NOLOCK) "  + CRLF
		cQuery +=	 " WHERE PW3_FILIAL = '" + xFilial("PW3") + "' "  + CRLF
		If !Empty(CHK1->Z5_GRUPO)
			cQuery +=	 " AND PW3_GRPCLI = '" + CHK1->Z5_GRUPO + "' "  + CRLF
		Else
			cQuery +=	 " AND PW3_CLIENT = '" + SA1->A1_COD + "' "  + CRLF
			cQuery +=	 " AND PW3_LOJA = '" + SA1->A1_LOJA + "' "  + CRLF
		Endif
		cQuery +=	 " AND PW3.D_E_L_E_T_ = '' "  + CRLF
			
		TCQUERY cQuery NEW ALIAS "CHK2"

		nQtNeg := CHK2->QTNEG

		CHK2->(dbCloseArea())

		AAdd(aOperador,{'2',;
						CHK1->Z5_GRUPO,;                                      // 1
						CHK1->Z5_NOME,;                                      // 2
						SA1->A1_COD,;                                      // 3
						SA1->A1_LOJA,;                                     // 4
						Iif(Len(AllTrim(SA1->A1_CGC))<14,TransForm(SA1->A1_CGC,'@R 999.999.999-99'),TransForm(SA1->A1_CGC,'@R 99.999.999/9999-99')),;                                      // 5
						SA1->A1_NOME,;                                     // 6
						SA1->A1_ULTCOM,;                                   // 7
						SA1->A1_NROCOM,;                                   // 8
						SA1->A1_DDD,;                                       // 9
						SA1->A1_TEL,;                                       // 10
						SA1->A1_TELEX,;                                    // 11
						SA1->A1_CONTATO,;                                   // 12
						SA1->A1_NREDUZ,;                                   // 13
						SA1->A1_MUN,; 										// 14
						Lower(SA1->A1_EMAIL),;                              // 15
						SA1->A1_COMPLEM,;                                  // 16
						SA1->(Recno()),;
						Iif(Empty(CHK1->Z5_GRUPO),'1','2'),;
						nQtNeg,;
						Iif(SA1->(FieldPos("A1_CLIVIP"))>0,CHK1->A1_CLIVIP,'')})					// 18

	Endif

	CHK1->(dbSkip(1))
Enddo
CHK1->(dbCloseArea())

If Empty(nReg) .Or. Empty(nConta)
	aOperador := {}
	AAdd(aOperador,{'2',;
					'',;                                      // 1
					'',;                                      // 2
					'',;                                      // 3
					'',;                                     // 4
					'',;                                      // 5
					'',;                                     // 6
					CtoD(''),;                                   // 7
					0,;                                   // 8
					'',;                                       // 9
					'',;                                       // 10
					'',;                                    // 11
					'',;                                   // 12
					'',;                                   // 13
					'',; 										// 14
					'',;                              // 15
					'',;                                  // 16
					0,;										// 17
					'1',;
					0,;
					''})										// 18

Endif
aSort(aOperador,,,{|x,y|,StrZero(x[OP_QTNEG],5) > StrZero(y[OP_QTNEG],5) })

//If cTipOpe$"A"
	fGeral(@aGeral,.F.)
//Endif

If Empty(Len(aGeral))
	aGeral := {}
	AAdd(aGeral,{'4',;
					CtoD(''),;
					'',;
					'',;
					'',;
					CtoD(''),;
					'',;
					CtoD(''),;
					'',;
					'',;
					'',;
					0,;
					0,;
					0,;
					'',;
					'',;
					'',;
					0,;
					'',;
					0})
Endif

oSay24:cCaption := TransForm(nGOrigi,'@E 999,999,999.99')
oSay25:cCaption := TransForm(nGLiqui,'@E 999,999,999.99')
oSay26:cCaption := TransForm(Round(nGOrigi-nGLiqui,2),'@E 999,999,999.99')


fLBoxRef(lGeral)
Return .t.                           



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fContato บAutor  ณ Luiz Alberto     Data ณ  07/07/2015  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function EdiCon(cCodigo,cLoja,nTipo)

U_FContato(cCodigo,cLoja)

Return .t.
                                                        

Static Function fRotina()
Local aArea := GetArea()
Local cTabRot := GetNewPar("MV_XTABRT","ZB")
Local aRots	:=	{}

cQuery := 	 " SELECT X5_DESCRI "  + CRLF
cQuery +=	 " FROM " + RetSqlName("SX5") + " SX5 (NOLOCK) " + CRLF
cQuery +=	 " WHERE SX5.D_E_L_E_T_ = '' " + CRLF
cQuery +=	 " AND SX5.X5_TABELA = '" + cTabRot + "' " + CRLF
cQuery +=	 " AND SX5.X5_FILIAL = '' " + CRLF
cQuery +=	 " ORDER BY X5_CHAVE " + CRLF

TCQUERY cQuery NEW ALIAS "CHK1"

Count To nReg

CHK1->(dbGoTop())

If Empty(nReg)
	MsgStop("Aten็ใo Nใo Existem Rotinas Cadastradas na Tabela (SX5) -> " + cTabRot + ", Verifique !")
	MsgStop("Padrใo de Cadastro, {'001','Relatorio Comissao','MATR540()'} ")
	CHK1->(dbCloseArea())
	Return .F.
Endif

While CHK1->(!Eof())
	AAdd(aRots,&(CHK1->X5_DESCRI))
	
	CHK1->(dbSkip(1))
Enddo

CHK1->(dbCloseArea())

DEFINE MSDIALOG oRcp6 TITLE "Rotinas Extras" FROM 000, 000  TO 300, 600 COLORS 0, 16777215 PIXEL 

    @ 010, 005 LISTBOX oOpcao Fields HEADER "Ordem",'Op็๕es' SIZE 295, 120 OF oRcp6 PIXEL //ColSizes 50,50

    oOpcao:SetArray(aRots)
    oOpcao:bLine := {|| {		aRots[oOpcao:nAt,1],;
        						aRots[oOpcao:nAt,2]}}

	oOpcao:bLDblClick := {|| Processa({|| fExec(aRots[oOpcao:nAt,3]) } ,"Aguarde Processando...") }

  	@ 135, 005 BUTTON oBotaoVis PROMPT "Executar"			ACTION Processa({|| fExec(aRots[oOpcao:nAt,3]) } ,"Aguarde Processando...") SIZE 050, 010 OF oRcp6 PIXEL
    @ 135, 055 BUTTON oBotaoSai PROMPT "&Sair"	 			ACTION (Close(oRcp6)) SIZE 050, 010 OF oRcp6 PIXEL
	
	ACTIVATE MSDIALOG oRcp6 CENTERED
	
RestArea(aArea)
Return .t.

/*---------------------------------------*
 | Func.: fExecuta                       |
 | Desc.: Executa a f๓rmula digitada     |
 *---------------------------------------*/
Static Function fExec(cRotina)
Local aArea    := GetArea()
Local cError   := ""
Local bError   := ErrorBlock({ |oError| cError := oError:Description})
 
//Se tiver conte๚do digitado
If ! Empty(cRotina)
//Inicio a utiliza็ใo da tentativa
	Begin Sequence
	&(cRotina)
	End Sequence
 
	//Restaurando bloco de erro do sistema
	ErrorBlock(bError)
	 
	//Se houve erro, serแ mostrado ao usuแrio
	If ! Empty(cError)
		MsgStop("Houve um erro na f๓rmula digitada: "+CRLF+CRLF+cError, "Aten็ใo")
	EndIf
EndIf
 
RestArea(aArea)
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	fLBoxRef(lGeral)
DEFAULT lGeral := .T.

If lGeral
	oDtCobCli:SetArray(aCobCli)
	oDtCobCli:bLine := {|| {	Iif(aCobCli[oDtCobCli:nAt,DT_MARCA]=='1',oOk,oNo),;
								U_RetLeg(1,oDtCobCli:nAt),;											
								aCobCli[oDtCobCli:nAt,DT_FINAN],;										//	16
								Iif(!Empty(aCobCli[oDtCobCli:nAt,DT_CLIVIP]),oLegVerde,oLegVermelho),;										// 	5
								aCobCli[oDtCobCli:nAt,DT_GRUPO],;										// 	5
								aCobCli[oDtCobCli:nAt,DT_NOMEGRP],;										// 	5
								aCobCli[oDtCobCli:nAt,DT_CODIGO],;										// 	5
								aCobCli[oDtCobCli:nAt,DT_LOJA],;										//	6
								aCobCli[oDtCobCli:nAt,DT_CNPJ],;										//	7
								aCobCli[oDtCobCli:nAt,DT_NOMECLI],;										//	8
								aCobCli[oDtCobCli:nAt,DT_DDD],;											//	18
								aCobCli[oDtCobCli:nAt,DT_TEL],;											//	19
								aCobCli[oDtCobCli:nAt,DT_TEL2],;										//	20
								aCobCli[oDtCobCli:nAt,DT_CONTATO],;										//	21
								aCobCli[oDtCobCli:nAt,DT_MUN],;											//	23
								aCobCli[oDtCobCli:nAt,DT_EMAIL],;										//	25
								aCobCli[oDtCobCli:nAt,DT_COMPL]}}	// 29

	oDtNegocia:SetArray(aNegocia)
	oDtNegocia:bLine := {|| {	U_RetLeg(2,oDtNegocia:nAt),;											// 0
								aNegocia[oDtNegocia:nAt,NG_EMISS],;										// 	2
								aNegocia[oDtNegocia:nAt,NG_IDNEG],;										// 	3
								aNegocia[oDtNegocia:nAt,NG_NMOPE],;										//	4
								aNegocia[oDtNegocia:nAt,NG_DFORM],;										//	5
								aNegocia[oDtNegocia:nAt,NG_DRETO],;										//	6
								aNegocia[oDtNegocia:nAt,NG_HRETO],;											//	7
								aNegocia[oDtNegocia:nAt,NG_DCONT],;											//	8
								aNegocia[oDtNegocia:nAt,NG_HCONT],;										//	9
								aNegocia[oDtNegocia:nAt,NG_RCONT],;										//	9
								aNegocia[oDtNegocia:nAt,NG_OBSER],;										//	10
								TransForm(aNegocia[oDtNegocia:nAt,NG_NTITU],'9,999'),;											//	11
								TransForm(aNegocia[oDtNegocia:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
								TransForm(aNegocia[oDtNegocia:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
								TransForm(aNegocia[oDtNegocia:nAt,NG_CREDI],'@E 9,999,999,999.99')}}	// 13

	oDtTitulos:SetArray(aTitulos)
	oDtTitulos:bLine := {|| {	Iif(aTitulos[oDtTitulos:nAt,TIT_STATUS]=='A',oLegVerde,Iif(aTitulos[oDtTitulos:nAt,TIT_STATUS]=='B',oLegAzul,oLegVermelho)),;											// 0
								aTitulos[oDtTitulos:nAt,TIT_FILORI],;										// 	2
								aTitulos[oDtTitulos:nAt,TIT_PREFIX],;										// 	2
								aTitulos[oDtTitulos:nAt,TIT_TITULO],;										// 	3
								aTitulos[oDtTitulos:nAt,TIT_PARCEL],;										//	4
								aTitulos[oDtTitulos:nAt,TIT_TIPTIT],;										//	4
								aTitulos[oDtTitulos:nAt,TIT_EMISSA],;										//	5
								aTitulos[oDtTitulos:nAt,TIT_VENCTO],;										//	6
								TransForm(aTitulos[oDtTitulos:nAt,TIT_VALORR],'@E 9,999,999,999.99'),;										//	12
								TransForm(aTitulos[oDtTitulos:nAt,TIT_SALDOO],'@E 9,999,999,999.99'),;										//	12
								TransForm(aTitulos[oDtTitulos:nAt,TIT_LIQUID],'@E 9,999,999,999.99'),;										//	12
								aTitulos[oDtTitulos:nAt,TIT_VENCNW],;											//	7
								aTitulos[oDtTitulos:nAt,TIT_HISTOR]}}	// 13

	oDtOpera:SetArray(aOperador)
	oDtOpera:bLine := {|| {		Iif(aOperador[oDtOpera:nAt,OP_MARCA]=='1',oOk,oNo),;
								Iif(aOperador[oDtOpera:nAt,OP_QTNEG]>0,oLegAzul,oLegBranco),;											// 0
								TransForm(aOperador[oDtOpera:nAt,OP_QTNEG],'9,999'),;										// 	1
								Iif(!Empty(aOperador[oDtOpera:nAt,OP_CLIVIP]),oLegVerde,oLegVermelho),;										// 	5
								aOperador[oDtOpera:nAt,OP_GRUPO],;										// 	1
								aOperador[oDtOpera:nAt,OP_NOMEGRP],;										// 	2
								aOperador[oDtOpera:nAt,OP_CODIGO],;										// 	3
								aOperador[oDtOpera:nAt,OP_LOJA],;										//	4
								aOperador[oDtOpera:nAt,OP_CNPJ],;										//	5
								aOperador[oDtOpera:nAt,OP_NOMECLI],;										//	6
								aOperador[oDtOpera:nAt,OP_DDD],;											//	7
								aOperador[oDtOpera:nAt,OP_TEL],;											//	8
								aOperador[oDtOpera:nAt,OP_TEL2],;										//	9
								aOperador[oDtOpera:nAt,OP_CONTATO],;										//	10
								aOperador[oDtOpera:nAt,OP_MUN],;											//	11
								aOperador[oDtOpera:nAt,OP_EMAIL],;										//	12
								aOperador[oDtOpera:nAt,OP_COMPL]}}	// 13

	oDtGeral:SetArray(aGeral)
	oDtGeral:bLine := {|| {	U_RetLeg(3,oDtGeral:nAt),;											// 0
								aGeral[oDtGeral:nAt,NG_NOME],;										// 	2
								aGeral[oDtGeral:nAt,NG_EMISS],;										// 	2
								aGeral[oDtGeral:nAt,NG_IDNEG],;										// 	3
								aGeral[oDtGeral:nAt,NG_NMOPE],;										//	4
								aGeral[oDtGeral:nAt,NG_DFORM],;										//	5
								aGeral[oDtGeral:nAt,NG_DRETO],;										//	6
								aGeral[oDtGeral:nAt,NG_HRETO],;											//	7
								aGeral[oDtGeral:nAt,NG_DCONT],;											//	8
								aGeral[oDtGeral:nAt,NG_HCONT],;										//	9
								aGeral[oDtGeral:nAt,NG_RCONT],;										//	9
								aGeral[oDtGeral:nAt,NG_OBSER],;										//	10
								TransForm(aGeral[oDtGeral:nAt,NG_NTITU],'9,999'),;											//	11
								TransForm(aGeral[oDtGeral:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
								TransForm(aGeral[oDtGeral:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
								TransForm(aGeral[oDtGeral:nAt,NG_CREDI],'@E 9,999,999,999.99'),;
								aGeral[oDtGeral:nAt,NG_CLIEN],;										//	10
								aGeral[oDtGeral:nAt,NG_LOJA],;										//	10
								aGeral[oDtGeral:nAt,NG_GRUPO]}}	// 13

	oDtTitGeral:SetArray(aTitGeral)
	oDtTitGeral:bLine := {|| {	Iif(aTitGeral[oDtTitGeral:nAt,TIT_STATUS]=='A',oLegVerde,Iif(aTitGeral[oDtTitGeral:nAt,TIT_STATUS]=='B',oLegAzul,oLegVermelho)),;											// 0
								aTitGeral[oDtTitGeral:nAt,TIT_FILORI],;										// 	2
								aTitGeral[oDtTitGeral:nAt,TIT_PREFIX],;										// 	2
								aTitGeral[oDtTitGeral:nAt,TIT_TITULO],;										// 	3
								aTitGeral[oDtTitGeral:nAt,TIT_PARCEL],;										//	4
								aTitGeral[oDtTitGeral:nAt,TIT_TIPTIT],;										//	4
								aTitGeral[oDtTitGeral:nAt,TIT_EMISSA],;										//	5
								aTitGeral[oDtTitGeral:nAt,TIT_VENCTO],;										//	6
								TransForm(aTitGeral[oDtTitGeral:nAt,TIT_VALORR],'@E 9,999,999,999.99'),;										//	12
								TransForm(aTitGeral[oDtTitGeral:nAt,TIT_SALDOO],'@E 9,999,999,999.99'),;										//	12
								TransForm(aTitGeral[oDtTitGeral:nAt,TIT_LIQUID],'@E 9,999,999,999.99'),;										//	12
								aTitGeral[oDtTitGeral:nAt,TIT_VENCNW],;											//	7
								aTitGeral[oDtTitGeral:nAt,TIT_HISTOR]}}	// 13
	oDtTitGeral:nAt := 1
	oDtTitGeral:Refresh()
	oDtTitulos:nAt := 1
	oDtTitulos:Refresh()
	oDtNegocia:nAt := 1
	oDtNegocia:Refresh()
	oDtGeral:nAt := 1
	oDtGeral:Refresh()
	oDtOpera:nAt := 1
	oDtOpera:Refresh()
	oDtCobCli:nAt := 1
	oDtCobCli:Refresh()
Else
	oDtOpera:SetArray(aOperador)
	oDtOpera:bLine := {|| {		Iif(aOperador[oDtOpera:nAt,OP_MARCA]=='1',oOk,oNo),;
								Iif(aOperador[oDtOpera:nAt,OP_QTNEG]>0,oLegAzul,oLegBranco),;											// 0
								TransForm(aOperador[oDtOpera:nAt,OP_QTNEG],'9,999'),;										// 	1
								Iif(!Empty(aOperador[oDtOpera:nAt,OP_CLIVIP]),oLegVerde,oLegVermelho),;										// 	5
								aOperador[oDtOpera:nAt,OP_GRUPO],;										// 	1
								aOperador[oDtOpera:nAt,OP_NOMEGRP],;										// 	2
								aOperador[oDtOpera:nAt,OP_CODIGO],;										// 	3
								aOperador[oDtOpera:nAt,OP_LOJA],;										//	4
								aOperador[oDtOpera:nAt,OP_CNPJ],;										//	5
								aOperador[oDtOpera:nAt,OP_NOMECLI],;										//	6
								aOperador[oDtOpera:nAt,OP_DDD],;											//	7
								aOperador[oDtOpera:nAt,OP_TEL],;											//	8
								aOperador[oDtOpera:nAt,OP_TEL2],;										//	9
								aOperador[oDtOpera:nAt,OP_CONTATO],;										//	10
								aOperador[oDtOpera:nAt,OP_MUN],;											//	11
								aOperador[oDtOpera:nAt,OP_EMAIL],;										//	12
								aOperador[oDtOpera:nAt,OP_COMPL]}}	// 13
	oDtOpera:Refresh()
Endif
Return .T.



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ConsFin   ณ Autor ณ Luiz Alberto        ณ Data ณ29.11.2014ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Consulta Situa็ใo Financeira do Cliente      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ Nenhum                                                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ConsFin(cCodigo,cLoja)
Local aArea := GetArea()  

If SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))

	cCadastro := 'Posi็ใo Financeira'
	aRotina	:= {{ "Pesquisar"  	,"AxPesqui"        	,0,1 },; 	// "Pesquisar"
				{ "Visualizar"	,"TK271CallCenter" 	,0,2 },; 	// "Visualizar"
				{ "Incluir"  	,"TK271CallCenter" 	,0,3 },; 	// "Incluir"
				{ "Legenda" 	,"U_MeLegen()"	   	,0,2 }} 	// "Imprime Or็amento"   						

	If !Pergunte("FIC010",.T.)
		RestArea(aArea)
		Return .T.
	Endif

	Fc010Con('SA1',SA1->(RECNO()),1)
Endif
RestArea(aArea)
Return .t.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fTelaMemoบAutor  ณ Felipe A. Melo       Data ณ  11/05/201  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Histor(nPos,nTipo,nNego,cPW3ID)
Local aArea := GetArea()
Local oBotaoSai
Local oBotaoVis
Local oBotaoAdd
Private aHistor	:= {{'','','','',0,'','',''}}
Private oHsCli
Private oRcp5

DEFAULT cPW3ID := ''

If !Empty(cPW3ID) 	// Consulta do Financeiro Direto
	PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cPW3ID))

	cCodigo	:=	PW3->PW3_CLIENT
	cLoja	:=	PW3->PW3_LOJA
	cGrupo  :=  PW3->PW3_GRPCLI
	cIdNeg	:=	PW3->PW3_IDNEG

Else
	If Empty(nPos)
		Return .f.
	Endif

	If nTipo == 1	// Operador
		cCodigo := aOperador[nPos,OP_CODIGO]
		cLoja   := aOperador[nPos,OP_LOJA]
		cGrupo  := aOperador[nPos,OP_GRUPO]
		cIdNeg  := ''
		nQtNeg  := aOperador[nPos,OP_QTNEG]
	ElseIf nTipo == 2	// Negociacao
		cCodigo := aOperador[nNego,OP_CODIGO]
		cLoja   := aOperador[nNego,OP_LOJA]
		cGrupo  := aOperador[nNego,OP_GRUPO]
		cIdNeg  := aNegocia[nPos,NG_IDNEG]
		nQtNeg	:= 1

		PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
	ElseIf nTipo == 3	// Tela Geral
		cCodigo := aGeral[nPos,NG_CLIEN]
		cLoja   := aGeral[nPos,NG_LOJA]
		cGrupo  := aGeral[nPos,NG_GRUPO]
		cIdNeg  := aGeral[nPos,NG_IDNEG]
		nQtNeg	:= 1
		PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
	Endif
Endif

If Empty(cGrupo)
	SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))
Else
	SA1->(dbSetOrder(14), dbSeek(xFilial("SA1")+cGrupo))
Endif

If SA1->(!Eof())

	If !Empty(SA1->A1_XGRUPO)
		cTitulo := 'Grupo: ' + SA1->A1_XGRUPO + ' - ' + Posicione("SZ5",1,xFilial("SZ5")+SA1->A1_XGRUPO,"Z5_NOME")
	Else
		cTitulo := 'Cliente: ' + SA1->A1_COD +'/'+ SA1->A1_LOJA + ' - ' + Capital(AllTrim(SA1->A1_NOME))
	Endif

	DEFINE MSDIALOG oRcp5 TITLE "Hist๓rico Liga็๕es " + cTitulo FROM 000, 000  TO 300, 800 COLORS 0, 16777215 PIXEL 

		@ 010, 005 LISTBOX oHsCli Fields HEADER "Data",'Hora','Id Negocia็ใo',"Hist๓rico Liga็๕es","Usuแrio","Descri็ใo" SIZE 395, 120 OF oRcp5 PIXEL //ColSizes 50,50

		oHsCli:SetArray(aHistor)
		oHsCli:bLine := {|| {		aHistor[oHsCli:nAt,HIS_DATA],;
									aHistor[oHsCli:nAt,HIS_HORA],;
									aHistor[oHsCli:nAt,HIS_IDNG],;
									aHistor[oHsCli:nAt,HIS_INIC],;
									aHistor[oHsCli:nAt,HIS_USER],;
									aHistor[oHsCli:nAt,HIS_DTIP]}}
		nOpc := 0
		MontaHistor(@aHistor,cIdNeg)

		
		@ 135, 005 BUTTON oBotaoVis PROMPT "Visualizar"			ACTION (AddHis(aHistor[oHsCli:nAt,5],.f.,cIdNeg)) SIZE 050, 010 OF oRcp5 PIXEL
		If Empty(cPW3ID)
			@ 135, 055 BUTTON oBotaoAdd PROMPT "Adicionar"			ACTION (AddHis(0,.t.,cIdNeg)) SIZE 050, 010 OF oRcp5 PIXEL
		Endif
		If !Empty(cIdNeg)
			@ 135, 105 BUTTON oBotaoHIG PROMPT "Hist.Geral"		ACTION (MontaHistor(@aHistor,'')) SIZE 050, 010 OF oRcp5 PIXEL
		Endif
		@ 135, 155 BUTTON oBotaoSai PROMPT "&Sair"	 			ACTION (Close(oRcp5),nOpc:=0) SIZE 050, 010 OF oRcp5 PIXEL
		
		ACTIVATE MSDIALOG oRcp5 CENTERED
		
		If nOpc == 1
		Endif

Endif

If Empty(cPW3ID)
	If nTipo  == 1		// aOperador
		Processa({|| PrcCob(@aCobCli,cFilGrp,cFilNom,@aOperador,@aGeral,@aTitGeral,.F.) } ,"Atualizando Carteira Operador, Aguarde...")
	ElseIf nTipo == 2	// aNegociacao
		aNegocia[nPos,NG_DRETO]	:= PW3->PW3_DTRET
		aNegocia[nPos,NG_HRETO]	:= PW3->PW3_HRRET
	ElseIf nTipo == 3	// aNegociacao
		aGeral[nPos,NG_DRETO]	:= PW3->PW3_DTRET
		aGeral[nPos,NG_HRETO]	:= PW3->PW3_HRRET
	Endif
	oDtNegocia:Refresh()
Endif
RestArea(aArea)
Return .t.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AddHis(nRecno,lAdd,cIdNeg)
Local nOpc := 0
Local cRet := ""
Local cMemo:= ""
Local oDlg1
Local oFont
Local aArea := GetArea()                  
Local dRetorno := CtoD('')
Local cHora := '00:00'
Local cTipo := '01'
Local aTipo := {}

PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))

// Monta Combobox do Tipo de Contato com Cliente

If SX5->(dbSetOrder(1), dbSeek(xFilial("SX5")+"KH"))
	While SX5->(!Eof()) .And. SX5->X5_FILIAL == xFilial("SX5") .And. SX5->X5_TABELA == 'KH'
		AAdd(aTipo,AllTrim(SX5->X5_CHAVE)+"="+AllTrim(SX5->X5_DESCRI))

		SX5->(dbSkip(1))
	Enddo
Endif

// Se For Visualizacao
If !lAdd                     
	PW2->(dbGoTo(nRecno))
	cMemo 	:=	PW2->PW2_HISTM
	cTipo	:=  PW2->PW2_TIPO
	aTipo   :=  {AllTrim(PW2->PW2_TIPO + '=' + PW2->PW2_DESTIP)}
	dRetorno:= 	Iif(!Empty(cIdNeg),PW3->PW3_DTRET,CtoD(''))
	cHora   := 	Iif(!Empty(cIdNeg),PW3->PW3_HRRET,'00:00')
Else
	cMemo := Space(10)
Endif

DEFINE FONT oFont NAME "Courier New" SIZE 7,14

@ 3,0 TO 340,550 DIALOG oDlg1 TITLE OemToAnsi("Hist๓rico Liga็๕es Cliente")
@ 5,5 Get cMemo MEMO OBJECT oMemo SIZE 267,120 WHEN lAdd
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont

@ 130, 005 SAY 	oGetData PROMPT "Dt Retorno: "  		SIZE 200, 010 OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL
@ 130, 140 SAY 	oGetHora PROMPT "Hr Retorno: "  		SIZE 200, 010 OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL
@ 153, 005 SAY 	oCmbTipo PROMPT "Tipo Contato: "  		SIZE 200, 010 OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL

@ 130,050 MsGet oDtReto Var dRetorno 	Picture '99/99/9999'	Valid(Empty(dRetorno) .Or. dRetorno >= Date()) 																			WHEN lAdd .And. (Empty(nQtNeg) .Or. !Empty(cIdNeg))	Size 050,010 PIXEL OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL
@ 130,190 MsGet oHrReto Var cHora 		Picture "99:99"			Valid(Val(Left(cHora,2))>=0 .And. Val(Left(cHora,2))<=23 .And. Val(Right(cHora,2))>=0 .And. Val(Right(cHora,2))<=59) 	WHEN lAdd .And. (Empty(nQtNeg) .Or. !Empty(cIdNeg))	Size 030,010 PIXEL OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL

@ 153,050 COMBOBOX cTipo ITEMS aTipo 	WHEN lAdd	Size 070,010 PIXEL OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL

oCmbTipo:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
oGetData:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
oGetHora:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
oDtReto:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
oHrReto:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)

@ 153,200 BMPBUTTON TYPE 1  ACTION ( nOpc := 1 , oDlg1:End() )
@ 153,240 BMPBUTTON TYPE 2  ACTION ( nOpc := 0 , oDlg1:End() )

ACTIVATE DIALOG oDlg1 CENTER

If nOpc==1 .And. !Empty(cMemo) .And. lAdd
	cHoraHist := Time()

	If RecLock("PW2",.t.)
		PW2->PW2_FILIAL	:=  xFilial("PW2")  
		PW2->PW2_GRUPO  :=  SA1->A1_XGRUPO
		PW2->PW2_CLIENT :=	Iif(Empty(SA1->A1_XGRUPO),SA1->A1_COD,'')
		PW2->PW2_LOJA	:=	Iif(Empty(SA1->A1_XGRUPO),SA1->A1_LOJA,'')
		PW2->PW2_DATA	:=	dDataBase
		PW2->PW2_HORA	:=	cHoraHist
		PW2->PW2_HISTM	:=	cMemo
		PW2->PW2_INICIO	:=  AllTrim(Left(cMemo,100))
		PW2->PW2_USER	:=	__cUserId
		PW2->PW2_NMUSER	:=	Capital(USRRETNAME(__cUserId))
		PW2->PW2_TIPO	:=	cTipo
		PW2->PW2_DESTIP	:=	Tabela("KH",cTipo)
		PW2->PW2_IDNEGO :=	cIdNeg
		PW2->(MsUnlock())
	Endif         

	// Atualiza Data de Retorno

	If !Empty(dRetorno) .And. !Empty(cIdNeg)
		If RecLock("PW3",.F.)
			PW3->PW3_DTULIG :=  dDataBase
			PW3->PW3_HRULIG :=  Time()
			PW3->PW3_RESHIS :=  AllTrim(Left(cMemo,100))
			PW3->PW3_DTRET	:=	dRetorno
			PW3->PW3_HRRET	:=	cHora
			PW3->(MsUnlock())
		Endif
	ElseIf !Empty(dRetorno) .And. Empty(cIdNeg) .And. Empty(nQtNeg)
//		If MsgYesNo("Cliente Nใo Possui Nenhuma Negocia็ใo, Serแ Criada Uma Negocia็ใo com a Data de Retorno Especificada, com Status de Contactado, Deseja Cria-la ?","Aten็ใo")

		cIdNeg := Right(GetSxeNum("PW3","PW3_IDNEG"),6)
		ConfirmSx8()

		If RecLock("PW3",.T.)
			PW3->PW3_FILIAL	:=	xFilial("PW3")
			PW3->PW3_IDNEG	:=	cIdNeg
			PW3->PW3_STAT 	:=	'4'
			PW3->PW3_EMISSA :=	dDataBase
			PW3->PW3_CODOPE	:=	__cUserId
			PW3->PW3_NOMOPE :=	Capital(UsrFullName(__cUserID))
			PW3->PW3_FORMA	:=	''
			PW3->PW3_FORDES :=	''
			PW3->PW3_DTRET	:=	dRetorno
			PW3->PW3_HRRET	:=	cHora
			PW3->PW3_CLIENT :=	Iif(Empty(SA1->A1_XGRUPO),SA1->A1_COD,'')
			PW3->PW3_LOJA	:=	Iif(Empty(SA1->A1_XGRUPO),SA1->A1_LOJA,'')
			PW3->PW3_GRPCLI :=	SA1->A1_XGRUPO
			PW3->(MsUnlock())
		Endif

		MsgInfo('Aten็ใo, Negocia็ใo ID: ' + cIdNeg + " Criada com Sucesso, Com Data de Retorno Agendada Para " + DtoC(dRetorno) + " as " + cHora + " !")

		cIdNeg := ''

//		Endif
	Endif

	aHistor	:=	{}
	MontaHistor(@aHistor,cIdNeg)
	oHsCli:SetArray(aHistor)
	oHsCli:bLine := {|| {		aHistor[oHsCli:nAt,HIS_DATA],;
								aHistor[oHsCli:nAt,HIS_HORA],;
								aHistor[oHsCli:nAt,HIS_IDNG],;
								aHistor[oHsCli:nAt,HIS_INIC],;
								aHistor[oHsCli:nAt,HIS_USER],;
								aHistor[oHsCli:nAt,HIS_DTIP]}}
	oHsCli:Refresh()
Else
	Return .f.
Endif
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelCiclo   บAutor ณLuiz Albertoบ Data ณ  Outubro/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Demonstra็ใo de Clientes em Data de Ciclo de Liga็ใo   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MontaHistor(aHistor,cIdNeg)
cQuery := 	 " SELECT PW2_DATA, PW2_HORA, PW2_INICIO, PW2_USER, PW2_NMUSER, PW2_TIPO, X5.X5_DESCRI TCONTATO, PW2.R_E_C_N_O_ RECNO, PW2.PW2_IDNEGO " + CRLF
cQuery +=	 " FROM " + RetSqlName("PW2") + " PW2 (NOLOCK), " + RetSqlName("SX5") + " X5 " + CRLF
cQuery +=	 " WHERE PW2_FILIAL = '" + xFilial("PW2") + "' " + CRLF
cQuery +=	 " AND X5.X5_FILIAL = '" + xFilial("SX5") + "' " + CRLF
cQuery +=	 " AND X5.X5_TABELA = 'KH' " + CRLF
cQuery +=	 " AND PW2.PW2_TIPO = X5.X5_CHAVE " + CRLF
cQuery +=	 " AND PW2.D_E_L_E_T_ = '' "       + CRLF
cQuery +=	 " AND X5.D_E_L_E_T_ = '' "       + CRLF
If !Empty(SA1->A1_XGRUPO)
	cQuery +=	 " AND PW2.PW2_GRUPO = '" + SA1->A1_XGRUPO + "' " + CRLF
Else
	cQuery +=	 " AND PW2.PW2_CLIENT = '" + SA1->A1_COD + "' " + CRLF
	cQuery +=	 " AND PW2.PW2_LOJA = '" + SA1->A1_LOJA + "' " + CRLF
Endif
If !Empty(cIdNeg)
	cQuery +=	 " AND PW2.PW2_IDNEGO = '" + cIdNeg + "' " + CRLF
Endif
cQuery +=	 " ORDER BY PW2_DATA+PW2_HORA DESC "      + CRLF
	
TCQUERY cQuery NEW ALIAS "CHK1"

TcSetField('CHK1','PW2_DATA','D')

Count To nReg

CHK1->(dbGoTop())

dbSelectArea("CHK1")
dbGoTop()    
ProcRegua(nReg)     

If Empty(nReg)
	aHistor	:= {{'','','','',0,'','',''}}
Else
	aHistor := {}
Endif

While CHK1->(!Eof())
	IncProc("Aguarde Localizando Hist๓rico do Cliente Posicionado ")
	
	AAdd(aHistor,{	DtoC(CHK1->PW2_DATA),;
					CHK1->PW2_HORA,;
					CHK1->PW2_INICIO,;
					CHK1->PW2_NMUSER,;
					CHK1->RECNO,;
					CHK1->PW2_TIPO,;
					CHK1->TCONTATO,;
					CHK1->PW2_IDNEGO})

	CHK1->(dbSkip(1))
Enddo
CHK1->(dbCloseArea())

oHsCli:SetArray(aHistor)
oHsCli:nAt := 1
oHsCli:bLine := {|| {		aHistor[oHsCli:nAt,HIS_DATA],;
							aHistor[oHsCli:nAt,HIS_HORA],;
							aHistor[oHsCli:nAt,HIS_IDNG],;
							aHistor[oHsCli:nAt,HIS_INIC],;
							aHistor[oHsCli:nAt,HIS_USER],;
							aHistor[oHsCli:nAt,HIS_DTIP]}}
oHsCli:Refresh()
Return .t.	

Static Function fFilGrp(cFilGrp)
Local aArea := GetArea()

If !Empty(cFilGrp)
	If !SZ5->(dbSetOrder(1), dbSeek(xFilial("SZ5")+cFilGrp))
		MsgStop("Aten็ใo Grupo Nใo Localizado, Verifique !!!")
		cFilNgr := Space(30)
		oGetNGr:Refresh()
		Return .F.
	Endif
Else
	cFilNgr := Space(30)
Endif

cFilNgr := SZ5->Z5_NOME

oGetNGr:Refresh()
RestArea(aArea)
Return .T.

User Function IteNeg(nPos, aNegocia, nTipo)
Local aArea := GetArea()

DEFAULT nTipo := 1
DEFAULT aGeral := {}

aNegocia := {}

If nPos > 0  // Negociacao por Operador x Cliente
	cCliente := aOperador[nPos,OP_CODIGO]
	cLoja    := aOperador[nPos,OP_LOJA]
	cGrupo   := aOperador[nPos,OP_GRUPO]

	nTOrigi		:= 0.00
	nTLiqui		:= 0.00
	
	aNegocia := {}
	
	cQuery := 	 " SELECT R_E_C_N_O_ REGPW3, * " + CRLF
	cQuery +=	 " FROM " + RetSqlName("PW3") + " PW3 (NOLOCK) " + CRLF
	cQuery +=	 " WHERE PW3.D_E_L_E_T_ = '' " + CRLF
	If Empty(cGrupo)
		cQuery +=	 " AND PW3.PW3_CLIENT = '" + cCliente + "' " + CRLF
		cQuery +=	 " AND PW3.PW3_LOJA = '" + cLoja + "' " + CRLF
	Else
		cQuery +=	 " AND PW3.PW3_GRPCLI = '" + cGrupo + "' " + CRLF
	Endif	
	cQuery+= " ORDER BY PW3_EMISSA DESC "
	
	TCQUERY cQuery NEW ALIAS "CHK1"
	
	TCSETFIELD( "CHK1","PW3_EMISSA","D")
	TCSETFIELD( "CHK1","PW3_DTRET","D")
	TCSETFIELD( "CHK1","PW3_DTULIG","D")

	While CHK1->(!Eof())
		AAdd(aNegocia,{CHK1->PW3_STAT,;
						CHK1->PW3_EMISSA,;
						CHK1->PW3_IDNEG,;
						CHK1->PW3_NOMOPE,;
						CHK1->PW3_FORDES,;
						CHK1->PW3_DTRET,;
						CHK1->PW3_HRRET,;
						CHK1->PW3_DTULIG,;
						CHK1->PW3_HRULIG,;
						CHK1->PW3_RESHIS,;
						CHK1->PW3_OBSER,;
						CHK1->PW3_NTITU,;
						CHK1->PW3_TOTNEG,;
						CHK1->PW3_TOTREC,;
						CHK1->PW3_CLIENT,;
						CHK1->PW3_LOJA,;
						CHK1->PW3_GRPCLI,;
						CHK1->REGPW3,;
						'',;
						CHK1->PW3_TOTPAR})
		
		If !CHK1->PW3_STAT $ 'C'
			nTOrigi		+=	CHK1->PW3_TOTNEG
			nTLiqui		+=	CHK1->PW3_TOTREC
		Endif
		
		CHK1->(dbSkip(1))
	Enddo
	
	CHK1->(dbCloseArea())
Endif

If Empty(Len(aNegocia))
	aNegocia := {}
	AAdd(aNegocia,{'4',;
					CtoD(''),;
					'',;
					'',;
					'',;
					CtoD(''),;
					'',;
					CtoD(''),;
					'',;
					'',;
					'',;
					0,;
					0,;
					0,;
					'',;
					'',;
					'',;
					0,;
					'',;
					0})
Endif

oDtNegocia:SetArray(aNegocia)
oDtNegocia:bLine := {|| {	U_RetLeg(2,oDtNegocia:nAt),;											// 0
		      				aNegocia[oDtNegocia:nAt,NG_EMISS],;										// 	2
		      				aNegocia[oDtNegocia:nAt,NG_IDNEG],;										// 	3
							aNegocia[oDtNegocia:nAt,NG_NMOPE],;										//	4
							aNegocia[oDtNegocia:nAt,NG_DFORM],;										//	5
							aNegocia[oDtNegocia:nAt,NG_DRETO],;										//	6
							aNegocia[oDtNegocia:nAt,NG_HRETO],;											//	7
							aNegocia[oDtNegocia:nAt,NG_DCONT],;											//	8
							aNegocia[oDtNegocia:nAt,NG_HCONT],;										//	9
							aNegocia[oDtNegocia:nAt,NG_RCONT],;										//	9
							aNegocia[oDtNegocia:nAt,NG_OBSER],;										//	10
							TransForm(aNegocia[oDtNegocia:nAt,NG_NTITU],'9,999'),;											//	11
							TransForm(aNegocia[oDtNegocia:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
							TransForm(aNegocia[oDtNegocia:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
							TransForm(aNegocia[oDtNegocia:nAt,NG_CREDI],'@E 9,999,999,999.99')}}	// 13
oDtNegocia:nAt := 1
oDtNegocia:Refresh()

oSay14:cCaption := TransForm(nTOrigi,'@E 999,999,999.99')
oSay15:cCaption := TransForm(nTLiqui,'@E 999,999,999.99')
oSay16:cCaption := TransForm(Round(nTOrigi-nTLiqui,2),'@E 999,999,999.99')

RestArea(aArea)
Return .t.



User Function BsqTit(nPos, aTitulos)
Local aArea := GetArea()

aTitulos := {}

nTJOri		:= 0.00
nTJLiq		:= 0.00
	
If nPos > 0 
	cIdNeg	 := aNegocia[nPos,NG_IDNEG]

	cQuery 	:= 	" SELECT R_E_C_N_O_ REGPW4, * " + CRLF
	cQuery 	+=	" FROM " + RetSqlName("PW4") + " PW4 (NOLOCK) " + CRLF
	cQuery 	+=	" WHERE PW4.D_E_L_E_T_ = '' " + CRLF
	cQuery 	+=	" AND PW4.PW4_IDNEG = '" + cIdNeg + "' " + CRLF
	cQuery	+= 	" ORDER BY PW4_PREFIX, PW4_NUM, PW4_PARCEL, PW4_TIPO "
	
	TCQUERY cQuery NEW ALIAS "CHK1"
	
	TCSETFIELD( "CHK1","PW4_EMISSA","D")
	TCSETFIELD( "CHK1","PW4_VENCRE","D")
	If PW4->(FieldPos("PW4_VENNEW")) > 0
		TCSETFIELD( "CHK1","PW4_VENNEW","D")
	Endif

	While CHK1->(!Eof())
		AAdd(aTitulos,{CHK1->PW4_STAT,;
						CHK1->PW4_PREFIX,;
						CHK1->PW4_NUM,;
						CHK1->PW4_PARCEL,;
						CHK1->PW4_EMISSA,;
						CHK1->PW4_VENCRE,;
						CHK1->PW4_VALOR,;
						CHK1->PW4_VLRCOR,;
						CHK1->PW4_VALLIQ,;
						Iif(PW4->(FieldPos("PW4_VENNEW")) > 0,CHK1->PW4_VENNEW,CHK1->PW4_VENCRE),;
						CHK1->PW4_HISTOR,;
						CHK1->REGPW4,;
						CHK1->PW4_FILORI,;
						CHK1->PW4_TIPO})
		
		nTJOri		+=	(CHK1->PW4_VALOR-CHK1->PW4_SALDO)+CHK1->PW4_VLRCOR
		nTJLiq		+=	CHK1->PW4_VALLIQ

		CHK1->(dbSkip(1))
	Enddo
	
	CHK1->(dbCloseArea())
Endif

If Empty(Len(aTitulos))
	aTitulos := {}
	AAdd(aTitulos,{'A',;
					'',;
					'',;
					'',;
					CtoD(''),;
					CtoD(''),;
					0,;
					0,;
					0,;
					CtoD(''),;
					'',;
					0,;
					'',;
					''})
Endif

oDtTitulos:SetArray(aTitulos)
oDtTitulos:bLine := {|| {	Iif(aTitulos[oDtTitulos:nAt,TIT_STATUS]=='A',oLegVerde,Iif(aTitulos[oDtTitulos:nAt,TIT_STATUS]=='B',oLegAzul,oLegVermelho)),;											// 0
		      				aTitulos[oDtTitulos:nAt,TIT_FILORI],;										// 	2
		      				aTitulos[oDtTitulos:nAt,TIT_PREFIX],;										// 	2
		      				aTitulos[oDtTitulos:nAt,TIT_TITULO],;										// 	3
							aTitulos[oDtTitulos:nAt,TIT_PARCEL],;										//	4
							aTitulos[oDtTitulos:nAt,TIT_TIPTIT],;										//	4
							aTitulos[oDtTitulos:nAt,TIT_EMISSA],;										//	5
							aTitulos[oDtTitulos:nAt,TIT_VENCTO],;										//	6
							TransForm(aTitulos[oDtTitulos:nAt,TIT_VALORR],'@E 9,999,999,999.99'),;										//	12
							TransForm(aTitulos[oDtTitulos:nAt,TIT_SALDOO],'@E 9,999,999,999.99'),;										//	12
							TransForm(aTitulos[oDtTitulos:nAt,TIT_LIQUID],'@E 9,999,999,999.99'),;										//	12
							aTitulos[oDtTitulos:nAt,TIT_VENCNW],;											//	7
							aTitulos[oDtTitulos:nAt,TIT_HISTOR]}}	// 13

oDtTitulos:nAt := 1
oDtTitulos:Refresh()
oSayY1:cCaption := TransForm(nTJOri,'@E 999,999,999.99')
oSayY2:cCaption := TransForm(nTJLiq,'@E 999,999,999.99')
oSayY3:cCaption := TransForm(Round(nTJOri-nTJLiq,2),'@E 999,999,999.99')

RestArea(aArea)
Return .t.

User Function RelGerTit(nPos, aTitGeral)
Local aArea := GetArea()

aTitGeral := {}

nTJGOri		:= 0.00
nTJGLiq		:= 0.00

If nPos > 0 
	cIdNeg	 := aGeral[nPos,NG_IDNEG]

	
	cQuery 	:= 	" SELECT R_E_C_N_O_ REGPW4, * " + CRLF
	cQuery 	+=	" FROM " + RetSqlName("PW4") + " PW4 (NOLOCK) " + CRLF
	cQuery 	+=	" WHERE PW4.D_E_L_E_T_ = '' " + CRLF
	cQuery 	+=	" AND PW4.PW4_IDNEG = '" + cIdNeg + "' " + CRLF
	cQuery	+= 	" ORDER BY PW4_PREFIX, PW4_NUM, PW4_PARCEL, PW4_TIPO "
	
	TCQUERY cQuery NEW ALIAS "CHK1"
	
	TCSETFIELD( "CHK1","PW4_EMISSA","D")
	TCSETFIELD( "CHK1","PW4_VENCRE","D")
	If PW4->(FieldPos("PW4_VENNEW")) > 0
		TCSETFIELD( "CHK1","PW4_VENNEW","D")
	Endif

	While CHK1->(!Eof())
		AAdd(aTitGeral,{CHK1->PW4_STAT,;
						CHK1->PW4_PREFIX,;
						CHK1->PW4_NUM,;
						CHK1->PW4_PARCEL,;
						CHK1->PW4_EMISSA,;
						CHK1->PW4_VENCRE,;
						CHK1->PW4_VALOR,;
						CHK1->PW4_VLRCOR,;
						CHK1->PW4_VALLIQ,;
						Iif(PW4->(FieldPos("PW4_VENNEW")) > 0,CHK1->PW4_VENNEW,CHK1->PW4_VENCRE),;
						CHK1->PW4_HISTOR,;
						CHK1->REGPW4,;
						CHK1->PW4_FILORI,;
						CHK1->PW4_TIPO})
		
		nTJGOri		+=	(CHK1->PW4_VALOR-CHK1->PW4_SALDO)+CHK1->PW4_VLRCOR
		nTJGLiq		+=	CHK1->PW4_VALLIQ

		CHK1->(dbSkip(1))
	Enddo
	
	CHK1->(dbCloseArea())
Endif

If Empty(Len(aTitGeral))
	aTitGeral := {}
	AAdd(aTitGeral,{'A',;
					'',;
					'',;
					'',;
					CtoD(''),;
					CtoD(''),;
					0,;
					0,;
					0,;
					CtoD(''),;
					'',;
					0,;
					'',;
					''})
Endif

oDtTitGeral:SetArray(aTitGeral)
oDtTitGeral:bLine := {|| {	Iif(aTitGeral[oDtTitGeral:nAt,TIT_STATUS]=='A',oLegVerde,Iif(aTitGeral[oDtTitGeral:nAt,TIT_STATUS]=='B',oLegAzul,oLegVermelho)),;											// 0
		      				aTitGeral[oDtTitGeral:nAt,TIT_FILORI],;										// 	2
		      				aTitGeral[oDtTitGeral:nAt,TIT_PREFIX],;										// 	2
		      				aTitGeral[oDtTitGeral:nAt,TIT_TITULO],;										// 	3
							aTitGeral[oDtTitGeral:nAt,TIT_PARCEL],;										//	4
							aTitGeral[oDtTitGeral:nAt,TIT_TIPTIT],;										//	4
							aTitGeral[oDtTitGeral:nAt,TIT_EMISSA],;										//	5
							aTitGeral[oDtTitGeral:nAt,TIT_VENCTO],;										//	6
							TransForm(aTitGeral[oDtTitGeral:nAt,TIT_VALORR],'@E 9,999,999,999.99'),;										//	12
							TransForm(aTitGeral[oDtTitGeral:nAt,TIT_SALDOO],'@E 9,999,999,999.99'),;										//	12
							TransForm(aTitGeral[oDtTitGeral:nAt,TIT_LIQUID],'@E 9,999,999,999.99'),;										//	12
							aTitGeral[oDtTitGeral:nAt,TIT_VENCNW],;											//	7
							aTitGeral[oDtTitGeral:nAt,TIT_HISTOR]}}	// 13

oDtTitGeral:nAt := 1
oDtTitGeral:Refresh()
oDtTitulos:nAt := 1
oDtTitulos:Refresh()
oSayT1:cCaption := TransForm(nTJGOri,'@E 999,999,999.99')
oSayT2:cCaption := TransForm(nTJGLiq,'@E 999,999,999.99')
oSayT3:cCaption := TransForm(Round(nTJGOri-nTJGLiq,2),'@E 999,999,999.99')


RestArea(aArea)
Return .t.


Static Function fTitVenc(nLstOper,nPos,cIdNeg)
Local aArea := GetArea()
Local lRet	:= .t.
Local oBotaoCnf 
Local oBtnFecha
Local oBotaoMar 
Local oBotaoDes 
Local oBotaoSef 
Local oTTC
Local    oFoi	 := LoadBitmap(GetResources(),"BR_AZUL")
Local    oYes	 := LoadBitmap(GetResources(),"BR_VERDE")
Local    oImprime:= LoadBitmap(GetResources(),"BR_LARANJA")
Local    oNo  	 := LoadBitmap(GetResources(),"BR_VERMELHO")
Local    oMarca  := LoadBitmap(GetResources(),"LBTIK")
Local    oDesma	 := LoadBitmap(GetResources(),"LBNO")
Local DADOS := TFont():New("Arial Narrow",,016,,.F.,,,,,.F.,.F.)
Local oTelTitVenc
Private oFinTit
Private aFinTit := {}
Private dDtVenc	:= CtoD('')
Private cCliente
Private cLoja
Private cGrupo

Private lEnd := .f.

DEFAULT cIdNeg := ''

If nPos > 0 .And. Empty(cIdNeg)
	If Empty(aNegocia[nPos,NG_IDNEG])
		cCliente 	:= aOperador[nLstOper,OP_CODIGO]
		cLoja		:= aOperador[nLstOper,OP_LOJA]
		cGrupo		:= aOperador[nLstOper,OP_GRUPO]
		cStatus     := '4'
		cIdNeg		:= ''
	Else
		cCliente := aNegocia[nPos,NG_CLIEN]
		cLoja    := aNegocia[nPos,NG_LOJA]
		cGrupo   := aNegocia[nPos,NG_GRUPO]
		cIdNeg	 := aNegocia[nPos,NG_IDNEG]
		cStatus  := aNegocia[nPos,NG_STATUS]
	Endif
ElseIf !Empty(cIdNeg)

	PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))

	cCliente := PW3->PW3_CLIENT
	cLoja    := PW3->PW3_LOJA
	cGrupo   := PW3->PW3_GRPCLI
	cIdNeg	 := PW3->PW3_IDNEG
	cStatus  := PW3->PW3_STAT
Endif

cQuery := 	 " SELECT * " + CRLF
cQuery +=	 " FROM " + RetSqlName("SE1") + " E1 (NOLOCK), " + RetSqlName("SA1") + " A1 (NOLOCK) " + CRLF
cQuery +=	 " WHERE E1.D_E_L_E_T_ = '' " + CRLF
cQuery +=	 " AND A1.D_E_L_E_T_ = '' " + CRLF
cQuery +=	 " AND A1.A1_FILIAL = '" + xFilial("SA1") + "' " + CRLF
//	cQuery +=	 " AND E1.E1_FILIAL = '" + xFilial("SE1") + "' " + CRLF
cQuery +=	 " AND A1.A1_COD = E1.E1_CLIENTE " + CRLF
cQuery +=	 " AND A1.A1_LOJA = E1.E1_LOJA " + CRLF
If Empty(cGrupo)
	cQuery +=	 " AND E1.E1_CLIENTE = '" + cCliente + "' " + CRLF
	cQuery +=	 " AND E1.E1_LOJA = '" + cLoja + "' " + CRLF
Else
	cQuery +=	 " AND A1.A1_XGRUPO = '" + cGrupo + "' " + CRLF
Endif	
cQuery +=	 " AND E1.E1_SALDO > 0 " + CRLF
cQuery +=	 " AND E1.E1_TIPO IN "+FormatIn(GetNewPar("MV_XCOBTIP",'NF;FT;RA;NCC'),";") + CRLF
cQuery +=	 " ORDER BY E1_PREFIXO, E1_NUM, E1_PARCELA "        + CRLF

TCQUERY cQuery NEW ALIAS "CHK1"
	
TcSetField('CHK1','E1_EMISSAO','D')
TcSetField('CHK1','E1_VENCREA','D')
	
Count To nReg
	
dbSelectArea("CHK1")
dbGoTop()
ProcRegua(nReg)

nTotal := 0	
While CHK1->(!Eof())
	IncProc("Aguarde Processando Titulos...a Receber")
		
	SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+CHK1->E1_CLIENTE+CHK1->E1_LOJA))
	If PW4->(dbSetOrder(2), dbSeek(xFilial("PW4")+CHK1->E1_PREFIXO+CHK1->E1_NUM+CHK1->E1_PARCELA+CHK1->E1_CLIENTE+CHK1->E1_LOJA+CHK1->E1_FILIAL))
		CHK1->(dbSkip(1));Loop
	Endif

	nSaldo := (CHK1->E1_SALDO-(CHK1->E1_IRRF+CHK1->E1_PIS+CHK1->E1_COFINS+CHK1->E1_CSLL+CHK1->E1_INSS))

	AAdd(aFinTit,{'',;
					CHK1->E1_PREFIXO,;
					CHK1->E1_NUM,;
					CHK1->E1_PARCELA,;
					CHK1->E1_TIPO,;
					CHK1->E1_CLIENTE,;
					CHK1->E1_LOJA,;
					SA1->A1_NREDUZ,;
					DtoC(CHK1->E1_EMISSAO),;
					DtoC(CHK1->E1_VENCREA),;
					nSaldo,;
					CHK1->R_E_C_N_O_,;
					CHK1->E1_FILIAL})
		
	nTotal += nSaldo
		
	CHK1->(dbSkip(1))
Enddo
CHK1->(dbCloseArea())
RestArea(aArea)
	
	
If Empty(Len(aFinTit))
	MsgStop("Aten็ใo Nenhum Titulo Localizado Pelo Filtro !")
	RestArea(aArea)
	Return .f.
Endif
	
lOk:=.f.

	If !Empty(SA1->A1_XGRUPO)
		cTitulo := 'Grupo: ' + SA1->A1_XGRUPO + ' - ' + Posicione("SZ5",1,xFilial("SZ5")+SA1->A1_XGRUPO,"Z5_NOME")
	Else
		cTitulo := 'Cliente: ' + SA1->A1_COD +'/'+ SA1->A1_LOJA + ' - ' + Capital(AllTrim(SA1->A1_NOME))
	Endif
	
	DEFINE MSDIALOG oTelTitVenc TITLE "Titulos em Aberto - " + cTitulo FROM 000, 000  TO 330, 1000 COLORS 0, 16777215 OF oMainWnd PIXEL
	
	@ 140, 305 SAY   oTotal PROMPT "Total Titulos: " + TransForm(nTotal,'@E 9,999,999,999.99')	SIZE 150, 020 OF oTelTitVenc COLORS CLR_GREEN,CLR_WHITE PIXEL
	
	oTotal:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)

	@ 140, 405 SAY   oQtde PROMPT "Qtde Titulos: " + TransForm(Len(aFinTit),'999,999')	SIZE 150, 020 OF oTelTitVenc COLORS CLR_RED,CLR_WHITE PIXEL
	
	oQtde:oFont := TFont():New('Arial',,18,,.T.,,,,.T.,.F.)

	@ 005, 005 LISTBOX oFinTit Fields HEADER '','','Filial','Prefixo',"Titulo",'Parcela','Tipo','Cliente','Emissใo',;
	"Vencimento",'Valor Titulo' SIZE 495, 130 OF oTelTitVenc PIXEL// ColSizes 50,50	//?FONT Dados 
	
	oFinTit:SetArray(aFinTit)
	oFinTit:bLine := {|| {	Iif(aFinTit[oFinTit:nAt,SEL_MARCA]=='1',oYes,oNo),;
							Iif(aFinTit[oFinTit:nAt,SEL_MARCA]$'1',oMarca,oDesma),;
							aFinTit[oFinTit:nAt,SEL_FILIAL],;
							aFinTit[oFinTit:nAt,SEL_PREFIXO],;
							aFinTit[oFinTit:nAt,SEL_TITULO],;
							aFinTit[oFinTit:nAt,SEL_PARCELA],;
							aFinTit[oFinTit:nAt,SEL_TIPO],;
							aFinTit[oFinTit:nAt,SEL_NOME],;
							aFinTit[oFinTit:nAt,SEL_EMISSAO],;
							aFinTit[oFinTit:nAt,SEL_VENCTO],;
							TransForm(aFinTit[oFinTit:nAt,SEL_VALOR],'@E 9,999,999,999.99')}}

	// Marca Notas
	oFinTit:bLDblClick := {|| dblCTits(oFinTit:nAt)}
	
	@ 140, 005 BUTTON oBotaoCnf PROMPT "&Confirmar"					ACTION (Processa( {|| U_NegTit(aFinTit,cIdNeg),oTelTitVenc:End()},OemtoAnsi("Aguarde o Processamento")),oTelTitVenc:End()) SIZE 060, 020 OF oTelTitVenc PIXEL
	@ 140, 075 BUTTON oBotaoMar PROMPT "&M Todas" 					ACTION Processa( {|| U_TMTodas()},"Aguarde Marcando Todos os Titulos") SIZE 060, 020 OF oTelTitVenc PIXEL
	@ 140, 145 BUTTON oBotaoDes PROMPT "&D Todas" 					ACTION Processa( {|| U_TDTodas()},"Aguarde Desmarcando Todos os Titulos") SIZE 060, 020 OF oTelTitVenc PIXEL 
	@ 140, 215 BUTTON oBtnFecha PROMPT "&Sair"	 					ACTION(lOk:=.f.,oTelTitVenc:End()) SIZE 60,020  OF oTelTitVenc PIXEL
	
	ACTIVATE MSDIALOG oTelTitVenc CENTERED 
	
	oDtNegocia:SetFocus()

RestArea(aArea)
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrcEnvNfe บAutor  ณ Luiz Alberto       บ Data ณ  20/11/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NegTit(aFinTit,cIdNeg)
Local aArea := GetArea()       
Local nI

Begin Transaction

If Empty(cIdNeg) 
	cIdNeg := Right(GetSxeNum("PW3","PW3_IDNEG"),6)
	ConfirmSx8()

	lNovo := .T.
Else
	PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))

	lNovo := .F.
	If cStatus $ '4*7'
		If !MSGYesNo("Aten็ใo, o Status da Negocia็ใo Id: " + cIdNeg + " ้ de Contactado ou Andamento, Deseja Inserir os Titulos Marcados Nessa Mesam Negocia็ใo [SIM] ou Uma Nova Negocia็ใo [NรO] ?")
			cIdNeg := Right(GetSxeNum("PW3","PW3_IDNEG"),6)
			ConfirmSx8()
			lNovo := .T.
		Endif
	Else
		cIdNeg := Right(GetSxeNum("PW3","PW3_IDNEG"),6)
		ConfirmSx8()

		lNovo := .T.
	Endif
Endif

If lNovo
	If RecLock("PW3",.T.)
		PW3->PW3_FILIAL	:=	xFilial("PW3")
		PW3->PW3_IDNEG	:=	cIdNeg
		PW3->PW3_STAT 	:=	'4'
		PW3->PW3_EMISSA :=	dDataBase
		PW3->PW3_CODOPE	:=	__cUserId
		PW3->PW3_NOMOPE :=	Capital(UsrFullName(__cUserID))
		PW3->PW3_FORMA	:=	''
		PW3->PW3_FORDES :=	''
		PW3->PW3_DTRET	:=	DataValida(dDataBase+7,.T.)
		PW3->PW3_HRRET	:=	'08:00'
		PW3->PW3_CLIENT :=	Iif(Empty(cGrupo),cCliente,'')
		PW3->PW3_LOJA	:=	Iif(Empty(cGrupo),cLoja,'')
		PW3->PW3_GRPCLI :=	cGrupo
		PW3->(MsUnlock())
	Endif
Endif
nTit := 0
nTotNeg := 0
nTotRec := 0

lMudou := .F.
ProcRegua(Len(aFinTit))
For nI := 1 To Len(aFinTit)
	IncProc("Guardando Titulo " + aFinTit[nI,SEL_TITULO]+"...")
	If aFinTit[nI,SEL_MARCA]=='1'

		SE1->(dbGoTo(aFinTit[nI,SEL_REGISTRO]))
		SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA))

		If PW4->(dbSetOrder(2), dbSeek(xFilial("PW4")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_FILIAL))
			Loop
		Endif

		dVcNeg := SE1->E1_VENCREA
		nSaldo := (SE1->E1_SALDO-(SE1->E1_IRRF+SE1->E1_PIS+SE1->E1_COFINS+SE1->E1_CSLL+SE1->E1_INSS))

		If RecLock("PW4",.T.)
			PW4->PW4_FILIAL	:=	xFilial("PW4")
			PW4->PW4_STAT	:=	'A'
			PW4->PW4_IDNEG	:=	cIdNeg
			PW4->PW4_PREFIX :=	SE1->E1_PREFIXO
			PW4->PW4_NUM	:=	SE1->E1_NUM
			PW4->PW4_PARCEL	:=	SE1->E1_PARCELA
			PW4->PW4_TIPO	:=	SE1->E1_TIPO
			PW4->PW4_EMISSA :=	SE1->E1_EMISSAO
			PW4->PW4_VENCTO	:=	SE1->E1_VENCTO
			PW4->PW4_VENCRE :=	SE1->E1_VENCREA
			If PW4->(FieldPos("PW4_VENNEW")) > 0	// Verifica se o Campo existe na Tabela
				PW4->PW4_VENNEW :=  SE1->E1_VENCREA	
			Endif
			PW4->PW4_VALOR	:=	SE1->E1_VALOR
			PW4->PW4_SALDO	:=	nSaldo
			PW4->PW4_VLRCOR	:=	nSaldo
			PW4->PW4_VALLIQ	:=	SE1->E1_VALLIQ
			PW4->PW4_HISTOR :=  SE1->E1_HIST
			PW4->PW4_SITUAC :=  SE1->E1_SITUACA
			PW4->PW4_CLIENT	:=	SE1->E1_CLIENTE
			PW4->PW4_LOJA	:=	SE1->E1_LOJA
			PW4->PW4_FILORI :=  aFinTit[nI,SEL_FILIAL]

			PW4->(MsUnlock())
		Endif

		// Marca Titulo como em Negociacao, Caso os Campos Existam

		If SE1->(FieldPos("E1_XRENEG")) > 0	// fcommit()
			If RecLock("SE1",.F.)
				SE1->E1_XRENEG := 'S'
				SE1->E1_XVCRENG :=	dVcNeg
	            SE1->E1_IDNEG 	:= cIdNeg
				SE1->(MsUnlock())
			Endif
		Endif

		If SE1->(FieldPos("E1_IDNEG")) > 0	// Grupo 3778
			If RecLock("SE1",.F.)
				SE1->E1_IDNEG 	:= cIdNeg
				SE1->E1_VCNEG	:= dVcNeg
				SE1->(MsUnlock())
			Endif
		Endif
	Endif
Next

nTotPar := 0.00

If PW4->(dbSetOrder(1), dbSeek(xFilial("PW4")+cIdNeg))
	While PW4->(!Eof()) .And. PW4->PW4_FILIAL == xFilial("PW4") .And. PW4->PW4_IDNEG == cIdNeg
		nTit++

		If !AllTrim(PW4->PW4_TIPO)$GetNewPar("CD_TIPPAR",'RA/NCC')
			nTotNeg += (PW4->PW4_VALOR-PW4->PW4_SALDO)+PW4->PW4_VLRCOR
			nTotRec += PW4->PW4_VALLIQ
		Else
			nTotPar += PW4->PW4_SALDO
		Endif

		PW4->(dbSkip(1))
	Enddo
Endif

// Atualiza Negociacao

If RecLock("PW3",.F.)
	PW3->PW3_NTITU	:=	nTit
	PW3->PW3_TOTNEG	:=	nTotNeg
	PW3->PW3_TOTREC :=  nTotRec
	If PW3->(FieldPos("PW3_TOTPAR")) > 0
		PW3->PW3_TOTPAR := nTotPar
	Endif
	PW3->(MsUnlock())
Endif

End Transaction

Processa({|| MntNeg(PW3->PW3_IDNEG) } ,"Aguarde Carregando Negocia็ใo...")
Processa({|| U_BsqTit(oDtNegocia:nAt,@aTitulos) } ,"Localizando Titulos da Negocia็ใo...")
oFinTit:Refresh()
RestArea(aArea)
Return .t.                                                                



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ DblClickณ Autor ณ Luiz Alberto        ณ Data ณ 06/12/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao Responsavel pelo Double Click Tela Rotas ณฑฑ
ฑฑณ          |                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TMTodas()
Local aArea := GetArea()
Local nPos

ProcRegua(Len(aFinTit))
For nPos := 1 To Len(aFinTit)
	IncProc("Processando Titulo " + aFinTit[nPos,SEL_TITULO]+"...")

	aFinTit[nPos,SEL_MARCA]:="1"
Next

oFinTit:Refresh()
Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ DblClickณ Autor ณ Luiz Alberto        ณ Data ณ 06/12/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao Responsavel pelo Double Click Tela Rotas ณฑฑ
ฑฑณ          |                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TDTodas()
Local aArea := GetArea()
Local nPos

ProcRegua(Len(aFinTit))
For nPos := 1 To Len(aFinTit)
	IncProc("Processando Titulo " + aFinTit[nPos,SEL_TITULO]+"...")
	If aFinTit[nPos,SEL_MARCA]$"1" 
		aFinTit[nPos,SEL_MARCA]:="2"
	Endif
Next

oFinTit:Refresh()
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ DblClickณ Autor ณ Luiz Alberto        ณ Data ณ 06/12/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao Responsavel pelo Double Click Tela Rotas ณฑฑ
ฑฑณ          |                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function dblCTits(nPos)
Local aArea := GetArea()

If aFinTit[nPos,SEL_MARCA]=="1" 
	aFinTit[nPos,SEL_MARCA]:="2"
Else
	aFinTit[nPos,SEL_MARCA]:="1"
Endif

oFinTit:Refresh()
Return .t.


Static Function fAtender(nPos)
Local aArea := GetArea()
Local nMarca

If nPos > 0
	If !MsgYesNo("Confirma o Atendimento ao Grupo/Cliente Posicionado ?","Aten็ใo")
		Return .F.
	Endif

	oCliNeg:cCaption := ""
	oCliNeg:Refresh()
	oFolder1:aDialogs[3]:lReadonly := .T.
	nNegocia := 0
	
	Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Carregando Negocia็๕es Aguarde...") 

	For nMarca := 1 To Len(aCobCli)
		If aCobCli[nMarca,DT_MARCA]<>'1'
			Loop
		Endif

		cCodigo := aCobCli[nMarca,DT_CODIGO]
		cLoja   := aCobCli[nMarca,DT_LOJA]
		cGrupo  := aCobCli[nMarca,DT_GRUPO]

		If Empty(cGrupo)
			SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))

			bEnd := {|| SA1->A1_FILIAL+SA1->A1_COD+SA1->A1_LOJA == xFilial("SA1")+cCodigo+cLoja }
		Else
			SA1->(dbSetOrder(14), dbSeek(xFilial("SA1")+cGrupo))

			bEnd := {|| SA1->A1_FILIAL+SA1->A1_XGRUPO == xFilial("SA1")+cGrupo }
		Endif

		While SA1->(!Eof()) .And. Eval(bEnd)
			If RecLock("SA1", .F.)
				SA1->A1_XOPENEG := __cUserId
				If SA1->(FieldPos("A1_XOPNOM")) > 0
					SA1->A1_XOPNOM  := UsrFullName(__cUserId)
				Endif
				SA1->(MsUnlock())
			Endif

			SA1->(dbSkip(1))
		Enddo
	Next
Endif
RestArea(aArea)
Return .T.

Static Function Reagen(cIdNeg,nPos,nTipo)
Local aArea := GetArea()

If !Empty(cIdNeg)
	If !PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
		Return Nil
	Endif

	cCodigo := PW3->PW3_CLIENT
	cLoja   := PW3->PW3_LOJA
	cGrupo  := PW3->PW3_GRPCLI
	cIdOper := PW3->PW3_CODOPE

	If Empty(cGrupo)
		SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))
	Else
		SA1->(dbSetOrder(14), dbSeek(xFilial("SA1")+cGrupo))
	Endif
	If SA1->(!Eof())

		If !Empty(SA1->A1_XGRUPO)
			cTitulo := 'Grupo: ' + SA1->A1_XGRUPO + ' - ' + Posicione("SZ5",1,xFilial("SZ5")+SA1->A1_XGRUPO,"Z5_NOME")
		Else
			cTitulo := 'Cliente: ' + SA1->A1_COD +'/'+ SA1->A1_LOJA + ' - ' + Capital(AllTrim(SA1->A1_NOME))
		Endif
	Endif

	dRetorno := PW3->PW3_DTRET
	cHora    := PW3->PW3_HRRET

	DEFINE FONT oFont NAME "Courier New" SIZE 7,14

	@ 3,0 TO 050,550 DIALOG oDlg1 TITLE OemToAnsi("Reagendamento Liga็๕es")

	@ 005, 005 SAY 	oGetData PROMPT "Dt Retorno: "  		SIZE 200, 010 OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL
	@ 005, 140 SAY 	oGetHora PROMPT "Hr Retorno: "  		SIZE 200, 010 OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL

	@ 005,050 MsGet oDtReto Var dRetorno 	Picture '99/99/9999'	Valid(Empty(dRetorno) .Or. dRetorno >= Date()) 																			Size 050,010 PIXEL OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL
	@ 005,190 MsGet oHrReto Var cHora 		Picture "99:99"			Valid(Val(Left(cHora,2))>=0 .And. Val(Left(cHora,2))<=23 .And. Val(Right(cHora,2))>=0 .And. Val(Right(cHora,2))<=59) 	Size 030,010 PIXEL OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL

	oGetData:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
	oGetHora:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
	oDtReto:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
	oHrReto:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)

	@ 005,240 BMPBUTTON TYPE 1  ACTION ( nOpc := 1 , oDlg1:End() )
	@ 005,280 BMPBUTTON TYPE 2  ACTION ( nOpc := 0 , oDlg1:End() )

	ACTIVATE DIALOG oDlg1 CENTER

	If nOpc==1 
		// Atualiza Data de Retorno

		If !Empty(dRetorno)
			If RecLock("PW3",.F.)
				PW3->PW3_DTRET	:=	dRetorno
				PW3->PW3_HRRET	:=	cHora
				PW3->(MsUnlock())
			Endif
			
			If nTipo == 1
				aNegocia[nPos,NG_DRETO]	:= PW3->PW3_DTRET
				aNegocia[nPos,NG_HRETO]	:= PW3->PW3_HRRET
			ElseIf nTipo == 2
				aGeral[nPos,NG_DRETO]	:= PW3->PW3_DTRET
				aGeral[nPos,NG_HRETO]	:= PW3->PW3_HRRET
			Endif
		Endif
	Endif
Endif

oDtNegocia:SetArray(aNegocia)
oDtNegocia:bLine := {|| {	U_RetLeg(2,oDtNegocia:nAt),;											// 0
							aNegocia[oDtNegocia:nAt,NG_EMISS],;										// 	2
							aNegocia[oDtNegocia:nAt,NG_IDNEG],;										// 	3
							aNegocia[oDtNegocia:nAt,NG_NMOPE],;										//	4
							aNegocia[oDtNegocia:nAt,NG_DFORM],;										//	5
							aNegocia[oDtNegocia:nAt,NG_DRETO],;										//	6
							aNegocia[oDtNegocia:nAt,NG_HRETO],;											//	7
							aNegocia[oDtNegocia:nAt,NG_DCONT],;											//	8
							aNegocia[oDtNegocia:nAt,NG_HCONT],;										//	9
							aNegocia[oDtNegocia:nAt,NG_RCONT],;										//	9
							aNegocia[oDtNegocia:nAt,NG_OBSER],;										//	10
							TransForm(aNegocia[oDtNegocia:nAt,NG_NTITU],'9,999'),;											//	11
							TransForm(aNegocia[oDtNegocia:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
							TransForm(aNegocia[oDtNegocia:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
							TransForm(aNegocia[oDtNegocia:nAt,NG_CREDI],'@E 9,999,999,999.99')}}	// 13
oDtNegocia:Refresh()

oDtGeral:SetArray(aGeral)
oDtGeral:bLine := {|| {	U_RetLeg(3,oDtGeral:nAt),;											// 0
							aGeral[oDtGeral:nAt,NG_NOME],;										// 	2
							aGeral[oDtGeral:nAt,NG_EMISS],;										// 	2
							aGeral[oDtGeral:nAt,NG_IDNEG],;										// 	3
							aGeral[oDtGeral:nAt,NG_NMOPE],;										//	4
							aGeral[oDtGeral:nAt,NG_DFORM],;										//	5
							aGeral[oDtGeral:nAt,NG_DRETO],;										//	6
							aGeral[oDtGeral:nAt,NG_HRETO],;											//	7
							aGeral[oDtGeral:nAt,NG_DCONT],;											//	8
							aGeral[oDtGeral:nAt,NG_HCONT],;										//	9
							aGeral[oDtGeral:nAt,NG_RCONT],;										//	9
							aGeral[oDtGeral:nAt,NG_OBSER],;										//	10
							TransForm(aGeral[oDtGeral:nAt,NG_NTITU],'9,999'),;											//	11
							TransForm(aGeral[oDtGeral:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
							TransForm(aGeral[oDtGeral:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
							TransForm(aGeral[oDtGeral:nAt,NG_CREDI],'@E 9,999,999,999.99'),;
							aGeral[oDtGeral:nAt,NG_CLIEN],;										//	10
							aGeral[oDtGeral:nAt,NG_LOJA],;										//	10
							aGeral[oDtGeral:nAt,NG_GRUPO]}}	// 13
oDtGeral:Refresh()
RestArea(aArea)
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SelOpc   บAutor ณLuiz Albertoบ Data ณ  Maio/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela Selecao Opcionais         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Metalacre                                      บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SelStat(cIdNeg,nPos,nTipo)
Local aArea := GetArea()
PRIVATE oRcp5
Private    oOk		 := LoadBitmap(GetResources(),"LBTIK")
Private    oNo  	 := LoadBitmap(GetResources(),"LBNO")
Private  oSinalNo    := LoadBitmap(GetResources(),"BR_VERMELHO")
Private  oSinalOk    := LoadBitmap(GetResources(),"BR_VERDE")
Private aStatus := {}
Private oBotaoCnf

DEFAULT nTipo := 1

If !Empty(cIdNeg)
	If !PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
		Return Nil
	Endif

	cAtual	:= PW3->PW3_STAT

	If cAtual $ 'C*E'
		MsgStop("Aten็ใo Negocia็๕es, Cancelas e/ou Encerradas, Nใo podem ter seus Status Modificados !")
		Return .F.
	Endif

	If GetNewPar("MV_XEMPCB",2)	== 1 // 1 fcommit()
		aStatus := {{oOk,Iif(cAtual$'1','1','2'),'1','Liquidado'},;
					{oOk,Iif(cAtual$'2','1','2'),'2','Juridico'},;
					{oOk,Iif(cAtual$'3','1','2'),'3','Cheque Custodia'},;
					{oOk,Iif(cAtual$'4','1','2'),'4','Contactado'},;
					{oOk,Iif(cAtual$'5','1','2'),'5','Negativado'},;
					{oOk,Iif(cAtual$'6','1','2'),'6','Liquidado Parcial'},;
					{oOk,Iif(cAtual$'7','1','2'),'7','Andamento'},;
					{oOk,Iif(cAtual$'8','1','2'),'8','Negociado Aguardando'},;
					{oOk,Iif(cAtual$'C','1','2'),'C','Cancelada'}}
	ElseIf GetNewPar("MV_XEMPCB",2)	== 2 // 2 Grupo
		aStatus := {{oOk,Iif(cAtual$'1','1','2'),'1','Liquidado'},;
					{oOk,Iif(cAtual$'2','1','2'),'2','Cobran็a Extrajudicial'},;
					{oOk,Iif(cAtual$'3','1','2'),'3','Cobran็a Externalizada'},;
					{oOk,Iif(cAtual$'4','1','2'),'4','Contactado'},;
					{oOk,Iif(cAtual$'5','1','2'),'5','Cliente Negativado'},;
					{oOk,Iif(cAtual$'6','1','2'),'6','Liquidado Parcial'},;
					{oOk,Iif(cAtual$'7','1','2'),'7','Cobran็a em Andamento'},;
					{oOk,Iif(cAtual$'8','1','2'),'8','Decisใo Comit๊ Estrat้gico'},;
					{oOk,Iif(cAtual$'C','1','2'),'C','Cancelada'}}
	Endif
	DEFINE MSDIALOG oRcp5 TITLE "Sele็ใo Status" FROM 000, 000  TO 350, 720 COLORS 0, 16777215 PIXEL Style DS_MODALFRAME 
	oRcp5:lEscClose := .F. //Nใo permite sair ao usuario se precionar o ESC

    @ 010, 005 LISTBOX oStatus Fields HEADER '','',"C๓d.","Status" SIZE 340, 140 OF oRcp5 PIXEL //ColSizes 50,50

    oStatus:SetArray(aStatus)
    oStatus:bLine := {|| {	Iif(aStatus[oStatus:nAt,2]=="1",oSinalOk,oSinalNo),;
    							Iif(aStatus[oStatus:nAt,2]=="1",oOk,oNo),;
        						aStatus[oStatus:nAt,3],;
      							aStatus[oStatus:nAt,4]}}

	oStatus:bLDblClick := {||DblClick(oStatus:nAt)}

	nOpc := 0
	
  	@ 160, 005 BUTTON oBotaoCnf PROMPT "&Confirma" 			ACTION (Close(oRcp5),nOpc:=1) SIZE 080, 010 OF oRcp5 PIXEL
    @ 160, 105 BUTTON oBotaoSai PROMPT "&Cancelar" 			ACTION (Close(oRcp5),nOpc:=0) SIZE 080, 010 OF oRcp5 PIXEL
	
	ACTIVATE MSDIALOG oRcp5 CENTERED //ON INIT EnchoiceBar(oRcp,{||If(oGet:Tud_oOk(),_nOpca:=1,_nOpca:=0)},{||oRcp:End()})
	
	If nOpc == 1
		Begin Transaction
		For nI := 1 To Len(aStatus)
			If aStatus[nI,2] == '1'
				// Se o Status for Cancelamento ou encerramento, Abre Janela para preencher motivo
				cMotTxt := ''
				If aStatus[nI,3]$'C'
					cMotTxt := fTelaMemo("MOTIVO DE CANCELAMENTO DA NEGOCIAวรO")
				ElseIf aStatus[nI,3]$'E'
					cMotTxt := fTelaMemo("MOTIVO DE ENCERRAMENTO DA NEGOCIAวรO")
				Endif

				If aStatus[nI,3]$'C*E' .And. Empty(cMotTxt)
					Return .F.
				Endif

				If RecLock("PW3",.F.)
					PW3->PW3_STAT	:=	aStatus[nI,3]
					If aStatus[nI,3]$'C'
						PW3->PW3_DTCANC := dDataBase
						PW3->PW3_HRCANC	:= Time()
						PW3->PW3_TXTCAN := cMotTxt
					ElseIf aStatus[nI,3]$"E"
						PW3->PW3_DTENC := dDataBase
						PW3->PW3_HRENC	:= Time()
						PW3->PW3_TXTENC := cMotTxt
					Endif
					PW3->(MsUnlock())
				Endif

				If nTipo == 1 // Negociacao especifica
					aNegocia[nPos,NG_STATUS]	:=	aStatus[nI,3]
				ElseIf nTipo == 2 // Negociacao geral
					aGeral[nPos,NG_STATUS]	:=	aStatus[nI,3]
				Endif

				// Registra Mudan็a de Status da Negociacao

				If RecLock("PW2",.t.)
					PW2->PW2_FILIAL	:=  xFilial("PW2")  
					PW2->PW2_GRUPO  :=  PW3->PW3_GRPCLI
					PW2->PW2_CLIENT :=	Iif(Empty(PW3->PW3_GRPCLI),PW3->PW3_CLIENT,'')
					PW2->PW2_LOJA	:=	Iif(Empty(PW3->PW3_GRPCLI),PW3->PW3_LOJA,'')
					PW2->PW2_DATA	:=	dDataBase
					PW2->PW2_HORA	:=	Time()
					PW2->PW2_HISTM	:=	"Atualiza็ใo de Status: " + aStatus[nI,4] + CRLF + cMotTxt
					PW2->PW2_INICIO	:=  "Atualiza็ใo de Status: " + aStatus[nI,4]
					PW2->PW2_USER	:=	__cUserId
					PW2->PW2_NMUSER	:=	Capital(USRRETNAME(__cUserId))
					PW2->PW2_TIPO	:=	'99'
					PW2->PW2_DESTIP	:=	Tabela("KH",'99')
					PW2->PW2_IDNEGO :=	cIdNeg
					PW2->(MsUnlock())
				Endif         
				
				If aStatus[nI,3]$'C'	// Se For Cancelamento, Entใo Libera os Titulos do Financeiro Para Nova Negociacao
					If SE1->(FieldPos("E1_XRENEG")) > 0 // fcommit()
						If PW4->(dbSetOrder(1), dbSeek(xFilial("PW4")+PW3->PW3_IDNEG))
							While PW4->(!Eof()) .And. PW4->PW4_FILIAL == xFilial("PW4") .And. PW4->PW4_IDNEG == PW3->PW3_IDNEG

								// Atualiza Titulo no Financeiro

								If SE1->(dbSetOrder(2), dbSeek(xFilial("SE1")+PW4->PW4_CLIENT+PW4->PW4_LOJA+PW4->PW4_PREFIX+PW4->PW4_NUM+PW4->PW4_PARCEL))
									If RecLock("SE1",.F.)
										SE1->E1_XRENEG  := 'N'
										SE1->E1_XVCRENG := CtoD('')
										SE1->E1_IDNEG 	:= ''
										SE1->(MsUnlock())
									Endif
								Endif

								PW4->(dbSkip(1))
							Enddo
						Endif
					Endif

					If SE1->(FieldPos("E1_IDNEG")) > 0	// Grupo 3778
						If PW4->(dbSetOrder(1), dbSeek(xFilial("PW4")+PW3->PW3_IDNEG))
							While PW4->(!Eof()) .And. PW4->PW4_FILIAL == xFilial("PW4") .And. PW4->PW4_IDNEG == PW3->PW3_IDNEG

								// Atualiza Titulo no Financeiro

								If SE1->(dbSetOrder(2), dbSeek(xFilial("SE1")+PW4->PW4_CLIENT+PW4->PW4_LOJA+PW4->PW4_PREFIX+PW4->PW4_NUM+PW4->PW4_PARCEL+PW4->PW4_TIPO))
									If RecLock("SE1",.F.)
										SE1->E1_IDNEG 	:= ''
										SE1->E1_VCNEG	:= CtoD('')
										SE1->(MsUnlock())
									Endif
								Endif

								PW4->(dbSkip(1))
							Enddo
						Endif
					Endif
				Endif
				Exit
			Endif
		Next 
		End Transaction
		oDtNegocia:SetArray(aNegocia)
		oDtNegocia:bLine := {|| {	U_RetLeg(2,oDtNegocia:nAt),;											// 0
									aNegocia[oDtNegocia:nAt,NG_EMISS],;										// 	2
									aNegocia[oDtNegocia:nAt,NG_IDNEG],;										// 	3
									aNegocia[oDtNegocia:nAt,NG_NMOPE],;										//	4
									aNegocia[oDtNegocia:nAt,NG_DFORM],;										//	5
									aNegocia[oDtNegocia:nAt,NG_DRETO],;										//	6
									aNegocia[oDtNegocia:nAt,NG_HRETO],;											//	7
									aNegocia[oDtNegocia:nAt,NG_DCONT],;											//	8
									aNegocia[oDtNegocia:nAt,NG_HCONT],;										//	9
									aNegocia[oDtNegocia:nAt,NG_RCONT],;										//	9
									aNegocia[oDtNegocia:nAt,NG_OBSER],;										//	10
									TransForm(aNegocia[oDtNegocia:nAt,NG_NTITU],'9,999'),;											//	11
									TransForm(aNegocia[oDtNegocia:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
									TransForm(aNegocia[oDtNegocia:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
									TransForm(aNegocia[oDtNegocia:nAt,NG_CREDI],'@E 9,999,999,999.99')}}	// 13
		oDtNegocia:Refresh()

		oDtGeral:SetArray(aGeral)
		oDtGeral:bLine := {|| {	U_RetLeg(3,oDtGeral:nAt),;											// 0
									aGeral[oDtGeral:nAt,NG_NOME],;										// 	2
									aGeral[oDtGeral:nAt,NG_EMISS],;										// 	2
									aGeral[oDtGeral:nAt,NG_IDNEG],;										// 	3
									aGeral[oDtGeral:nAt,NG_NMOPE],;										//	4
									aGeral[oDtGeral:nAt,NG_DFORM],;										//	5
									aGeral[oDtGeral:nAt,NG_DRETO],;										//	6
									aGeral[oDtGeral:nAt,NG_HRETO],;											//	7
									aGeral[oDtGeral:nAt,NG_DCONT],;											//	8
									aGeral[oDtGeral:nAt,NG_HCONT],;										//	9
									aGeral[oDtGeral:nAt,NG_RCONT],;										//	9
									aGeral[oDtGeral:nAt,NG_OBSER],;										//	10
									TransForm(aGeral[oDtGeral:nAt,NG_NTITU],'9,999'),;											//	11
									TransForm(aGeral[oDtGeral:nAt,NG_TTNEG],'@E 9,999,999,999.99'),;										//	12
									TransForm(aGeral[oDtGeral:nAt,NG_TTREC],'@E 9,999,999,999.99'),;
									TransForm(aGeral[oDtGeral:nAt,NG_CREDI],'@E 9,999,999,999.99'),;
									aGeral[oDtGeral:nAt,NG_CLIEN],;										//	10
									aGeral[oDtGeral:nAt,NG_LOJA],;										//	10
									aGeral[oDtGeral:nAt,NG_GRUPO]}}	// 13
		oDtGeral:Refresh()

	Endif
Endif
RestArea(aArea)
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ DblClickณ Autor ณ Luiz Alberto        ณ Data ณ 06/12/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao Responsavel pelo Double Click Tela Rotas ณฑฑ
ฑฑณ          |                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function dblClick(nPos)
Local aArea := GetArea()

If aStatus[nPos,2]=="1"
	aStatus[nPos,2]:="2"
	oBotaoCnf:Disable()
Else

	aStatus[nPos,2]:="1"
	oBotaoCnf:Enable()
	For nI := 1 To Len(aStatus)
		If nI <> nPos
			aStatus[nI,2] := '2'
		Endif
	Next
Endif 
oStatus:Refresh()
oRcp5:Refresh()
Return .t.
	


Static Function vReneg(nPos)
Local aArea := GetArea()

If nPos > 0
	PW4->(dbGoTo(aNegocia[nPos,NG_RECNO]))

	dVcNeg	:= aNegocia[nPos,NG_VRENE]

	DEFINE FONT oFont NAME "Courier New" SIZE 7,14

	@ 3,0 TO 050,550 DIALOG oDlg1 TITLE OemToAnsi("Data Negocia็ใo - Filial/Titulo: " + PW4->PW4_FILORI + ' - ' + PW4->PW4_PREFIX + PW4->PW4_NUM)

	@ 005, 005 SAY 	oGetData PROMPT "Dt Negociada: "  		SIZE 200, 010 OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL
	
	@ 005,050 MsGet oDtReto Var dVcNeg 	Picture '99/99/9999'	Valid(Empty(dVcNeg) .Or. dVcNeg >= Date()) 																			Size 050,010 PIXEL OF oDlg1 COLORS CLR_BLUE,CLR_WHITE PIXEL

	oGetData:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)
	oDtReto:oFont := TFont():New('Arial',,16,,.T.,,,,.T.,.F.)

	@ 005,200 BMPBUTTON TYPE 1  ACTION ( nOpc := 1 , oDlg1:End() )
	@ 005,240 BMPBUTTON TYPE 2  ACTION ( nOpc := 0 , oDlg1:End() )

	ACTIVATE DIALOG oDlg1 CENTER

	If nOpc==1 
		// Atualiza Data de Retorno

		If !Empty(dVcNeg)
			If RecLock("PW4",.F.)
				PW4->PW4_VCRENG	:=	dVcNeg
				PW4->(MsUnlock())
			Endif

			// Atualiza Titulo no Financeiro

			If SE1->(dbSetOrder(2), dbSeek(xFilial("SE1")+PW4->PW4_CLIENT+PW4->PW4_LOJA+PW4->PW4_PREFIX+PW4->PW4_NUM+PW4->PW4_PARCEL+PW4->PW4_TIPO))
				If RecLock("SE1",.F.)
					SE1->E1_XRENEG := 'S'
					SE1->E1_XVCRENG :=	dVcNeg
					SE1->(MsUnlock())
				Endif
			Endif
		Endif
	Endif
Endif
RestArea(aArea)
Return .T.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ DblClickณ Autor ณ Luiz Alberto        ณ Data ณ 06/12/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao Responsavel pelo Double Click Tela Rotas ณฑฑ
ฑฑณ          |                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fMarcaCli(nPos)
Local aArea := GetArea()

If aCobCli[nPos,DT_MARCA]=="1"
	aCobCli[nPos,DT_MARCA]:="2"
Else
	aCobCli[nPos,DT_MARCA]:="1"
Endif 

oDtCobCli:Refresh()
Return .t.      




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ DblClickณ Autor ณ Luiz Alberto        ณ Data ณ 06/12/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao Responsavel pelo Double Click Tela Rotas ณฑฑ
ฑฑณ          |                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fMarcaCart(nPos)
Local aArea := GetArea()
Local nI
Local nPos

If aOperador[nPos,OP_MARCA]=="1"
	aOperador[nPos,OP_MARCA]:="2"

	//oBtnOP002:Disable()

	oCliNeg:cCaption := ""
	oFolder1:aDialogs[3]:lReadonly := .T.

Else
	//oBtnOP002:Enable()

	aOperador[nPos,OP_MARCA]:="1"

	nNegocia := nPos

	oFolder1:nOption := 3
	oFolder1:Refresh()
	oFolder1:aDialogs[3]:lReadonly := .F.
	For nI := 1 To Len(aOperador)
		If nI <> nPos
			aOperador[nI,OP_MARCA] := '2'
		Endif
	Next

	oCliNeg:cCaption := AllTrim(aOperador[nPos,OP_NOMEGRP])+aOperador[nPos,OP_NOMECLI]

	Processa({|| U_IteNeg(nNegocia,@aNegocia) } ,"Carregando Negocia็๕es Aguarde...") 
	Processa({|| U_BsqTit(1,@aTitulos) } ,"Localizando Titulos da Negocia็ใo...") 

	oDtNegocia:SetFocus()
Endif 

oCliNeg:Refresh()
oBtnOP002:Refresh()
oDtOpera:Refresh()
Return .t.      




Static Function MntNeg(cIdNeg)
Local aArea        := GetArea()
Local cTitulo      := "Manuten็ใo Negocia็ใo"
Local cPrograma    := "MntCob"
Local nOperation   := MODEL_OPERATION_INSERT
private cCadastro := "Negocia็ใo"
private INCLUI  := .F.
private ALTERA  := .T.

SetFunname("MntCob" )

If Empty(cIdNeg)
	RestArea(aArea)
	Return Nil
Endif

nOperation := MODEL_OPERATION_UPDATE

dbSelectArea("PW3")
PW3->(dbSetOrder(1))

If !PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
	RestArea(aArea)
	Return Nil
Endif

oModel := FWLoadModel("MntCob")
oModel:SetOperation(nOperation)
oModel:Activate(.F.)

nRet     := FWExecView( cTitulo , cPrograma, nOperation, , {|| .T. } ,, , ,  , , , oModel )
oModel:DeActivate()

If nRet == 0
	//MsgAlert('<font color="#FF0000"><h2>Negocia็ใo Nบ ' +ZZY->ZZY_NUM +'</h2></font>','<b><h3>Aten็ใo ..!</h3></b>')
EndIf

RestArea(aArea)
Return ( oModel )



User Function NegSaldo(cIdNeg)
Local aArea := GetArea()
Local nTit	:= 0
Local nTotNeg := 0.00
Local nTotRec := 0.00

If PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
	Begin Transaction
	// N. Titulos e Totais

	nTotPar := 0.00

	If PW4->(dbSetOrder(1), dbSeek(xFilial("PW4")+cIdNeg))
		While PW4->(!Eof()) .And. PW4->PW4_FILIAL == xFilial("PW4") .And. PW4->PW4_IDNEG == cIdNeg
			nTit++

			xFilAnt := cFilAnt
			cFilAnt := PW4->PW4_FILORI

			If SE1->(dbSetOrder(2), dbSeek(xFilial("SE1")+PW4->PW4_CLIENT+PW4->PW4_LOJA+PW4->PW4_PREFIX+PW4->PW4_NUM+PW4->PW4_PARCEL+PW4->PW4_TIPO))
				nSaldo := (SE1->E1_SALDO-(SE1->E1_IRRF+SE1->E1_PIS+SE1->E1_COFINS+SE1->E1_CSLL+SE1->E1_INSS))

				If RecLock("PW4",.F.)
					PW4->PW4_SALDO := nSaldo
					PW4->PW4_VALOR := SE1->E1_VALOR
					PW4->PW4_VLRCOR:= SE1->E1_VALOR
					PW4->PW4_VALLIQ:= SE1->E1_VALLIQ
					PW4->(MsUnlock())
				Endif
			Endif
			cFilAnt := xFilAnt

			If !AllTrim(PW4->PW4_TIPO)$GetNewPar("CD_TIPPAR",'RA/NCC')
				nTotNeg += (PW4->PW4_VALOR-PW4->PW4_SALDO)+PW4->PW4_VLRCOR
				nTotRec += PW4->PW4_VALLIQ
			Else
				nTotPar += PW4->PW4_SALDO
			Endif

			PW4->(dbSkip(1))
		Enddo
	Endif

	// Atualiza Negociacao

	If RecLock("PW3",.F.)
		PW3->PW3_NTITU	:=	nTit
		PW3->PW3_TOTNEG	:=	nTotNeg
		PW3->PW3_TOTREC :=  nTotRec
		If PW3->(FieldPos("PW3_TOTPAR")) > 0
			PW3->PW3_TOTPAR := nTotPar
		Endif
		PW3->(MsUnlock())
	Endif

	End Transaction
Endif

RestArea(aArea)
Return .T.





User Function VwNeg(cIdNeg)
Local aArea        := GetArea()
Local cTitulo      := "Visualiza็ใo de Negocia็ใo"
Local cPrograma    := "MntCob"
Local nOperation   := MODEL_OPERATION_INSERT
private cCadastro := "Negocia็ใo"
private INCLUI  := .F.
private ALTERA  := .T.

SetFunname("MntCob" )

If !PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
	MsgStop("Negocia็ใo ID: " + cIdNeg + " Nใo Localizada, Verifique !!! ")
	RestArea(aArea)
Endif

nOperation := MODEL_OPERATION_VIEW

dbSelectArea("PW3")
PW3->(dbSetOrder(1))

oModel := FWLoadModel("MntCob")
oModel:SetOperation(nOperation)
oModel:Activate(.F.)

nRet     := FWExecView( cTitulo , cPrograma, nOperation, , {|| .T. } ,, , ,  , , , oModel )
oModel:DeActivate()

If nRet == 0
	//MsgAlert('<font color="#FF0000"><h2>Negocia็ใo Nบ ' +ZZY->ZZY_NUM +'</h2></font>','<b><h3>Aten็ใo ..!</h3></b>')
EndIf

RestArea(aArea)
Return ( oModel )




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fTelaMemoบAutor  ณ Felipe A. Melo       Data ณ  11/05/201  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fTelaMemo(cMotivo)
Local nOpc := 0
Local cRet := ""
Local cMemo:= ""
Local oDlg1
Local oFont

cMemo :=MemoRead("")

DEFINE FONT oFont NAME "Courier New" SIZE 7,14

@ 3,0 TO 340,550 DIALOG oDlg1 TITLE OemToAnsi(cMotivo)
@ 5,5 Get cMemo MEMO OBJECT oMemo SIZE 267,145
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont
@ 153,240 BMPBUTTON TYPE 1  ACTION ( nOpc := 1 , oDlg1:End() )
ACTIVATE DIALOG oDlg1 CENTER

If !Empty(cMemo)

	cRet += Chr(13)+Chr(10)+"Data: "+DtoC(Date())
	cRet += Chr(13)+Chr(10)+"Hora: "+Time()
	cRet += Chr(13)+Chr(10)+"Rotina: " + cMotivo
	cRet += Chr(13)+Chr(10)+"Usuแrio: "+UsrRetName(__cUserID)
	cRet += Chr(13)+Chr(10)+"===================================
	cRet += Chr(13)+Chr(10)+IIf(Empty(AllTrim(cMemo)),"Motivo nใo informado pelo usuแrio.",cMemo)
	cRet += Chr(13)+Chr(10)+"===================================
Else
	MsgStop("Aten็ใo ้ Obrigat๓rio o Preenchimento do Motivo, Rotina Cancelada !")
Endif
Return(cRet)



Static Function ValidPerg(cPerg)

DbSelectArea("SX1")
SX1->(DbSetOrder(1))

cPerg := PADR(cPerg,10)

If !SX1->(DbSeek(cPerg+'01'))
	RecLock("SX1",.T.)
	SX1->X1_GRUPO   := cPerg
	SX1->X1_ORDEM   := '01'
	SX1->X1_PERGUNT := 'Vencimento de'
	SX1->X1_VARIAVL := 'mv_ch1'
	SX1->X1_VAR01   := 'mv_par01'
	SX1->X1_GSC     := 'G'
	SX1->X1_TIPO    := 'D'
	SX1->X1_TAMANHO := 8
	SX1->(MsUnlock())
EndIf

If !SX1->(DbSeek(cPerg+'02'))
	RecLock("SX1",.T.)
	SX1->X1_GRUPO   := cPerg
	SX1->X1_ORDEM   := '02'
	SX1->X1_PERGUNT := 'Vencimento at้'
	SX1->X1_VARIAVL := 'mv_ch2'
	SX1->X1_VAR01   := 'mv_par02'
	SX1->X1_GSC     := 'G'
	SX1->X1_TIPO    := 'D'
	SX1->X1_TAMANHO := 8
	SX1->(MsUnlock())
EndIf

Return()


/*
???????????????????????????????????????
???????????????????????????????????????
? ?????????????????????????????????????
??rograma  ?fTrataCol?utor  ?Luiz Alberto     ?Data ? 10/04/2013 ??
???????????????????????????????????????
??esc.     ?                                                           ??
??         ?                                                           ??
???????????????????????????????????????
??so       ?                                                           ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
*/
Static Function fTrataCol(nCol,nJanela)
Local x        := 1
                                                                                                            
Default nCol      := 5
DEFAULT nJanela	  := 1

If nJanela == 1 .Or. nJanela == 2
	If nCol <= 2
		MsgStop("Aten็ใo, Para Ordena็ใo por Coluna, Primeiro Clique Na Coluna Desejada e Logo Ap๓s Clique No Tํtulo da Coluna !")
		Return .T.
	Endif
Endif

If nJanela == 1 // Clientes
	If nCol == 10 // Razao Social
		nCol := DT_NOMECLI
	ElseIf nCol == 3 // Titulo
		nCol := DT_FINAN
	ElseIf nCol == 4 // Vip
		nCol := DT_CLIVIP
	ElseIf nCol == 5 // Grupo
		nCol := DT_GRUPO
	ElseIf nCol == 6 // Descri็ใo Grupo
		nCol := DT_NOMEGRP
	ElseIf nCol == 7 // C๓digo
		nCol := DT_CODIGO
	ElseIf nCol == 8 // Loja
		nCol := DT_LOJA
	ElseIf nCol == 9 // CNPJ
		nCol := DT_CNPJ
	ElseIf nCol == 11 // DDD
		nCol := DT_DDD
	ElseIf nCol == 12 // Telefone
		nCol := DT_TEL
	ElseIf nCol == 13 // Telefone 2
		nCol := DT_TEL2
	ElseIf nCol == 14 // Contato
		nCol := DT_CONTATO
	ElseIf nCol == 15 // Municipio
		nCol := DT_MUN
	ElseIf nCol == 16 // Email
		nCol := DT_EMAIL
	ElseIf nCol == 17 // Complemento
		nCol := DT_COMPL
	Endif
    // '','','Titulo','Vip','Grupo','Descri็ใo Grupo','C๓digo','Loja','CNPJ','Razใo Social','DDD','Telefone (1)','Telefone (2)','Contato','Municipio','Email','Complemento' SIZE (oRcp5:NRIGHT/2)-15, (oRcp5:NHEIGHT/2)-120 OF oFolder1:aDialogs[1] PIXEL //ColSizes 50,50

	If nSelCol <> nCol
		aSort(aCobCli,,,{|x,y|,x[nCol] < y[nCol]})
	Else
		aSort(aCobCli,,,{|x,y|,x[nCol] > y[nCol]})
		nCol := 1
	Endif
	oDtCobCli:Refresh()
ElseIf nJanela == 2 // Janela Operador
    // '','','Negoc','Vip','Grupo','Descri็ใo Grupo','C๓digo','Loja','CNPJ','Razใo Social','DDD','Telefone (1)','Telefone (2)','Contato','Municipio','Email','Complemento' SIZE (oRcp5:NRIGHT/2)-15, (oRcp5:NHEIGHT/2)-120 OF oFolder1:aDialogs[2] PIXEL //ColSizes 50,50
	If nCol == 3 // Qtde Negociacoes
		nCol := OP_QTNEG
	ElseIf nCol == 4 // Vip
		nCol := OP_CLIVIP
	ElseIf nCol == 5 // Grupo
		nCol := OP_GRUPO
	ElseIf nCol == 6 // Descri็ใo Grupo
		nCol := OP_NOMEGRP
	ElseIf nCol == 7 // C๓digo
		nCol := OP_CODIGO
	ElseIf nCol == 8 // Loja
		nCol := OP_LOJA
	ElseIf nCol == 9 // CNPJ
		nCol := OP_CNPJ
	ElseIf nCol == 11 // DDD
		nCol := OP_DDD
	ElseIf nCol == 12 // Telefone
		nCol := OP_TEL
	ElseIf nCol == 13 // Telefone 2
		nCol := OP_TEL2
	ElseIf nCol == 14 // Contato
		nCol := OP_CONTATO
	ElseIf nCol == 15 // Municipio
		nCol := OP_MUN
	ElseIf nCol == 16 // Email
		nCol := OP_EMAIL
	ElseIf nCol == 17 // Complemento
		nCol := OP_COMPL
	Endif

	If nSelCol <> nCol
		aSort(aOperador,,,{|x,y|,x[nCol] < y[nCol]})
	Else
		aSort(aOperador,,,{|x,y|,x[nCol] > y[nCol]})
		nCol := 1
	Endif
	oDtOpera:Refresh()
ElseIf nJanela == 3 // Negociacoes Operador
	If nCol == 1 // Status
		nCol := NG_STATUS
	ElseIf nCol == 2 // Grupo
		nCol := OP_CNG_NOMELIVIP
	ElseIf nCol == 3 // Data Negociacao
		nCol := NG_EMISS
	ElseIf nCol == 4 // Id Negociacao
		nCol := NG_IDNEG
	ElseIf nCol == 5 // Operador
		nCol := NG_NMOPE
	ElseIf nCol == 6 // Forma Pagametno
		nCol := NG_DFORM
	ElseIf nCol == 7 // Retorno
		nCol := NG_DRETO
	ElseIf nCol == 8 // Hr Retorno
		nCol := NG_HRETO
	ElseIf nCol == 9 // Ultimo Contato
		nCol := NG_DCONT
	ElseIf nCol == 10 // Hr Ultimo Contato
		nCol := NG_HCONT
	ElseIf nCol == 11 // Resumo Ult contato
		nCol := NG_RCONT
	ElseIf nCol == 12 // Observacao
		nCol := NG_OBSER
	ElseIf nCol == 13 // N Titulos
		nCol := NG_NTITU
	ElseIf nCol == 14 // Total Negociado
		nCol := NG_TTNEG
	ElseIf nCol == 15 // Total Recebido
		nCol := NG_TTREC
	ElseIf nCol == 16 // Total Recebido
		nCol := NG_CREDI
	ElseIf nCol == 17 // Cliente
		nCol := NG_CLIEN
	ElseIf nCol == 18 // Loja
		nCol := NG_LOJA
	ElseIf nCol == 19 // Grupo
		nCol := NG_GRUPO
	Endif

	If nSelCol <> nCol
		aSort(aNegocia,,,{|x,y|,x[nCol] < y[nCol]})
	Else
		aSort(aNegocia,,,{|x,y|,x[nCol] > y[nCol]})
		nCol := 1
	Endif
	oDtNegocia:Refresh()
ElseIf nJanela == 4 // Negociacoes Gerais
	If nCol == 1 // Status
		nCol := NG_STATUS
	ElseIf nCol == 2 // Grupo
		nCol := OP_CNG_NOMELIVIP
	ElseIf nCol == 3 // Data Negociacao
		nCol := NG_EMISS
	ElseIf nCol == 4 // Id Negociacao
		nCol := NG_IDNEG
	ElseIf nCol == 5 // Operador
		nCol := NG_NMOPE
	ElseIf nCol == 6 // Forma Pagametno
		nCol := NG_DFORM
	ElseIf nCol == 7 // Retorno
		nCol := NG_DRETO
	ElseIf nCol == 8 // Hr Retorno
		nCol := NG_HRETO
	ElseIf nCol == 9 // Ultimo Contato
		nCol := NG_DCONT
	ElseIf nCol == 10 // Hr Ultimo Contato
		nCol := NG_HCONT
	ElseIf nCol == 11 // Resumo Ult contato
		nCol := NG_RCONT
	ElseIf nCol == 12 // Observacao
		nCol := NG_OBSER
	ElseIf nCol == 13 // N Titulos
		nCol := NG_NTITU
	ElseIf nCol == 14 // Total Negociado
		nCol := NG_TTNEG
	ElseIf nCol == 15 // Total Recebido
		nCol := NG_TTREC
	ElseIf nCol == 16 // Total Recebido
		nCol := NG_CREDI
	ElseIf nCol == 17 // Cliente
		nCol := NG_CLIEN
	ElseIf nCol == 18 // Loja
		nCol := NG_LOJA
	ElseIf nCol == 19 // Grupo
		nCol := NG_GRUPO
	Endif

	If nSelCol <> nCol
		aSort(aGeral,,,{|x,y|,x[nCol] < y[nCol]})
	Else
		aSort(aGeral,,,{|x,y|,x[nCol] > y[nCol]})
		nCol := 1
	Endif
	oDtGeral:Refresh()
Endif


	
nSelCol := nCol


Return


User Function TrcOpe(cIdNeg)
Local aArea := GetArea()
Local aPergs   := {}
Local cOpera   := Space(TamSX3('A1_XOPENEG')[01])
 
aAdd(aPergs, {1, "Novo Operador(a)",  cOpera,  "", ".T.", "USR", ".T.", 06,  .F.})
 
If ParamBox(aPergs, "Informe Novo(a) Operador(a)")
	If !Empty(MV_PAR01)
		If PW3->(dbSetOrder(1), dbSeek(xFilial("PW3")+cIdNeg))
			If RecLock("PW3",.F.)
				PW3->PW3_CODOPE := MV_PAR01
				PW3->PW3_NOMOPE := UsrFullName(MV_PAR01)
				PW3->(MsUnlock())
			Endif

			// Atualiza os Clientes do Operador Antigo para o Novo

			cCodigo := PW3->PW3_CLIENT
			cLoja   := PW3->PW3_LOJA
			cGrupo  := PW3->PW3_GRPCLI

			If Empty(cGrupo)
				SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+cCodigo+cLoja))

				bEnd := {|| SA1->A1_FILIAL+SA1->A1_COD+SA1->A1_LOJA == xFilial("SA1")+cCodigo+cLoja }
			Else
				SA1->(dbSetOrder(14), dbSeek(xFilial("SA1")+cGrupo))

				bEnd := {|| SA1->A1_FILIAL+SA1->A1_XGRUPO == xFilial("SA1")+cGrupo }
			Endif

			While SA1->(!Eof()) .And. Eval(bEnd)
				If RecLock("SA1", .F.)
					SA1->A1_XOPENEG := PW3->PW3_CODOPE
					If SA1->(FieldPos("A1_XOPNOM")) > 0
						SA1->A1_XOPNOM  := PW3->PW3_NOMOPE
					Endif
					SA1->(MsUnlock())
				Endif

				SA1->(dbSkip(1))
			Enddo
		Endif

		MsgInfo("Operador(a) Substituido(a) Com Sucesso !")
	Endif
EndIf
RestArea(aArea)
Return .T.


Static Function fGeral(aGeral,lPergunte)
Local aArea := GetArea()
Local cPerg := PadR("FGERAL",10)

ValidPerg2(cPerg)
If !lPergunte
	Pergunte(cPerg,.f.)

	MV_PAR01 := ''	
	MV_PAR02 := 'ZZ'
	MV_PAR03 := ''
	MV_PAR04 := ''
	MV_PAR05 := 'ZZ'
	MV_PAR06 := 'ZZ'
	MV_PAR07 := PadR('12345678C',20)
	MV_PAR08 := ''
	MV_PAR09 := CTOD('')
	MV_PAR10 := CTOD('31/12/2050')
	MV_PAR11 := ''
	MV_PAR12 := CTOD('')
	MV_PAR13 := CTOD('31/12/2050')
	MV_PAR14 := 0.00
	MV_PAR15 := 999999999
	MV_PAR16 := 0.00
	MV_PAR17 := 999999999
Else
	If !Pergunte(cPerg,lPergunte)
		Return .F.
	Endif
Endif

aGeral := {}

nGOrigi		:=	0.00
nGLiqui		:=	0.00

cQuery := 	 " SELECT R_E_C_N_O_ REGPW3, * " + CRLF
cQuery +=	 " FROM " + RetSqlName("PW3") + " PW3 (NOLOCK) " + CRLF
cQuery +=	 " WHERE PW3.D_E_L_E_T_ = '' " + CRLF
cQuery +=	 " AND PW3.PW3_GRPCLI BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "       + CRLF
cQuery +=	 " AND PW3.PW3_CLIENT BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR05 + "' "       + CRLF
cQuery +=	 " AND PW3.PW3_LOJA BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR06 + "' "       + CRLF
cQuery +=	 " AND CHARINDEX(PW3_STAT,'" + AllTrim(MV_PAR07) + "') > 0 " + CRLF
If !Empty(cFilGr1)
	cQuery +=	 " AND PW3.PW3_GRPCLI = '" + cFilGr1 + "' "       + CRLF
Endif
If !Empty(MV_PAR08)
	cQuery +=	 " AND PW3.PW3_CODOPE = '" + MV_PAR08 + "' "       + CRLF
Endif
cQuery +=	 " AND PW3.PW3_EMISSA BETWEEN '" + DtoS(MV_PAR09) + "' AND '" + DtoS(MV_PAR10) + "' "       + CRLF
If !Empty(MV_PAR11)
	cQuery +=	 " AND PW3.PW3_FORMA = '" + MV_PAR11 + "' "       + CRLF
Endif
cQuery +=	 " AND PW3.PW3_DTRET BETWEEN '" + DtoS(MV_PAR12) + "' AND '" + DtoS(MV_PAR13) + "' "       + CRLF
cQuery +=	 " AND PW3.PW3_TOTNEG BETWEEN " + Str(MV_PAR14,12,2) + " AND " + Str(MV_PAR15,12,2) + " "       + CRLF
cQuery +=	 " AND PW3.PW3_TOTREC BETWEEN " + Str(MV_PAR16,12,2) + " AND " + Str(MV_PAR17,12,2) + " "       + CRLF
cQuery += 	 " ORDER BY PW3_EMISSA DESC "

TCQUERY cQuery NEW ALIAS "CHK1"

TCSETFIELD( "CHK1","PW3_EMISSA","D")
TCSETFIELD( "CHK1","PW3_DTRET","D")
TCSETFIELD( "CHK1","PW3_DTULIG","D")

While CHK1->(!Eof())
	If Empty(CHK1->PW3_GRPCLI)
		SA1->(dbSetOrder(1), dbSeek(xFilial("SA1")+CHK1->PW3_CLIENT+CHK1->PW3_LOJA))

		cGrpCli := SA1->A1_NOME
	Else
		SZ5->(dbSetOrder(1), dbSeek(xFilial("SZ5")+CHK1->PW3_GRPCLI))

		cGrpCli := SZ5->Z5_NOME
	Endif

	If !Empty(cFilNo1)
		If !AllTrim(cFilNo1)$cGrpCli
			CHK1->(dbSkip(1));Loop
		Endif
	Endif

	AAdd(aGeral,{CHK1->PW3_STAT,;
					CHK1->PW3_EMISSA,;
					CHK1->PW3_IDNEG,;
					CHK1->PW3_NOMOPE,;
					CHK1->PW3_FORDES,;
					CHK1->PW3_DTRET,;
					CHK1->PW3_HRRET,;
					CHK1->PW3_DTULIG,;
					CHK1->PW3_HRULIG,;
					CHK1->PW3_RESHIS,;
					CHK1->PW3_OBSER,;
					CHK1->PW3_NTITU,;
					CHK1->PW3_TOTNEG,;
					CHK1->PW3_TOTREC,;
					CHK1->PW3_CLIENT,;
					CHK1->PW3_LOJA,;
					CHK1->PW3_GRPCLI,;
					CHK1->REGPW3,;
					cGrpCli,;
					CHK1->PW3_TOTPAR})
	
	If !CHK1->PW3_STAT $ 'C'
		nGOrigi		+=	CHK1->PW3_TOTNEG
		nGLiqui		+=	CHK1->PW3_TOTREC
	Endif

	CHK1->(dbSkip(1))
Enddo

CHK1->(dbCloseArea())

If Empty(Len(aGeral))
	aGeral := {}
	AAdd(aGeral,{'4',;
					CtoD(''),;
					'',;
					'',;
					'',;
					CtoD(''),;
					'',;
					CtoD(''),;
					'',;
					'',;
					'',;
					0,;
					0,;
					0,;
					'',;
					'',;
					'',;
					0,;
					'',;
					0})
Endif

oSay24:cCaption := TransForm(nGOrigi,'@E 999,999,999.99')
oSay25:cCaption := TransForm(nGLiqui,'@E 999,999,999.99')
oSay26:cCaption := TransForm(Round(nGOrigi-nGLiqui,2),'@E 999,999,999.99')


fLBoxRef(.T.)
RestArea(aArea)
Return .T.



*-----------------------------------------------------*
Static Function ValidPerg2(cPerg)
*-----------------------------------------------------*
Local _sAlias := Alias()
Local aRegs := {}
Local i:= 0
Local j:= 0
	
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
//          Grupo/Ordem/Pergunta/                                           Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Grupo de                     ?","?","?","mv_ch1","C",TamSX3('Z5_GRUPO')[1]	,0,0,"G",""				,"Mv_Par01","","","","","","SZ5",''})
aAdd(aRegs,{cPerg,"02","Grupo Ate                    ?","?","?","mv_ch2","C",TamSX3('Z5_GRUPO')[1]	,0,0,"G",""				,"Mv_Par02","","","","","","SZ5",''})
aAdd(aRegs,{cPerg,"03","Cliente De                   ?","?","?","mv_ch3","C",TamSX3('A1_COD')[1]	,0,0,"G",""				,"Mv_Par03","","","","","","SA1",''})
aAdd(aRegs,{cPerg,"04","Loja De                      ?","?","?","mv_ch4","C",TamSX3('A1_LOJA')[1]	,0,0,"G",""				,"Mv_Par04","","","","","","",''})
aAdd(aRegs,{cPerg,"05","Cliente Ate                  ?","?","?","mv_ch5","C",TamSX3('A1_COD')[1]	,0,0,"G",""				,"Mv_Par05","","","","","","SA1",''})
aAdd(aRegs,{cPerg,"06","Loja Ate                     ?","?","?","mv_ch6","C",TamSX3('A1_LOJA')[1]	,0,0,"G",""				,"Mv_Par06","","","","","","",''})
aAdd(aRegs,{cPerg,'07','Status                       ?','?','?','mv_ch7','C',20						,0,0,'C','U_STFILTRO()' ,'Mv_Par07','','','','','','',''})
aAdd(aRegs,{cPerg,"08","Operador(a)                  ?","?","?","mv_ch8","C",TamSX3('A1_XOPENEG')[1],0,0,"G",""				,"Mv_Par08","","","","","","USR",''})
aAdd(aRegs,{cPerg,"09","Data Negociacao De           ?","?","?","mv_ch9","D",TamSX3('E1_VENCREA')[1],0,0,"G",""				,"Mv_Par09","","","","","","",''})
aAdd(aRegs,{cPerg,"10","Data Negociacao Ate          ?","?","?","mv_chA","D",TamSX3('E1_VENCREA')[1],0,0,"G",""				,"Mv_Par10","","","","","","",''})
aAdd(aRegs,{cPerg,"11","Forma de Pagamento           ?","?","?","mv_chB","C",TamSX3('PW3_FORMA')[1]	,0,0,"G",""				,"Mv_Par11","","","","","","KI",''})
aAdd(aRegs,{cPerg,"12","Data Retorno De              ?","?","?","mv_chC","D",TamSX3('E1_VENCREA')[1],0,0,"G",""				,"Mv_Par12","","","","","","",''})
aAdd(aRegs,{cPerg,"13","Data Retorno Ate             ?","?","?","mv_chD","D",TamSX3('E1_VENCREA')[1],0,0,"G",""				,"Mv_Par13","","","","","","",''})
aAdd(aRegs,{cPerg,"14","Total Negociado De           ?","?","?","mv_chE","N",TamSX3('D2_TOTAL')[1]	,2,0,"G",""				,"Mv_Par14","","","","","","",'@E 999,999,999.99'})
aAdd(aRegs,{cPerg,"15","Total Negociado Ate          ?","?","?","mv_chF","N",TamSX3('D2_TOTAL')[1]	,2,0,"G",""				,"Mv_Par15","","","","","","",'@E 999,999,999.99'})
aAdd(aRegs,{cPerg,"16","Total Recebido De            ?","?","?","mv_chG","N",TamSX3('D2_TOTAL')[1]	,2,0,"G",""				,"Mv_Par16","","","","","","",'@E 999,999,999.99'})
aAdd(aRegs,{cPerg,"17","Total Recebido Ate           ?","?","?","mv_chH","N",TamSX3('D2_TOTAL')[1]	,2,0,"G",""				,"Mv_Par17","","","","","","",'@E 999,999,999.99'})

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





/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณfReqEPI   ณ Autor ณ Marcelo Silveira      ณ Data ณ13/10/2006ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณSelecionar Requisitos do EPI                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ fReqEPI()                                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Generico 												  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿/*/
User Function StFiltro()

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
                '2 - Cobran็a Extrajunidical' ,; //"Foi observada a periodicidade de troca definida pelos programas ambientais, comprovada mediante recibo assinado pelo usuario em epoca propria."
                '3 - Cobran็a Exeternalizada',;
                '4 - Contactado',;
                '5 - Cliente Negativado',;
                '6 - Liquidado Parcial',;
                '7 - Cobran็a em Andamento',;
                '8 - Decisใo Comit๊ Estrat้gico',;
                'C - Cancelado'} //"Foi observada a higienizacao."
Endif

MvParDef:= "12345678C"
cTitulo := 'Selecione os Status Desejados para o Filtro' //"Atendimento aos requisitos pelos EPIS informados"

IF f_Opcoes(@MvPar,cTitulo,aReq,MvParDef,12,49,.F.)  // Chama funcao f_Opcoes
	&MvRet := mvpar
EndIF                           

dbSelectArea(cAlias) // Retorna Alias

Return( .T. )
