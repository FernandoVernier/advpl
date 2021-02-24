#Include 'Protheus.ch'
#Include 'TopConn.ch'

#DEFINE	ATI1_NEWITEM	001
#DEFINE	ATI1_FILIAL		002
#DEFINE	ATI1_GRUPO		003
#DEFINE	ATI1_CLASSIF	004
#DEFINE	ATI1_CODBEM		005
#DEFINE	ATI1_ITEBEM		006
#DEFINE	ATI1_DTAQUIS	007
#DEFINE	ATI1_DESCRIC	008
#DEFINE	ATI1_FOTO		009
#DEFINE	ATI1_QUANTID	010
#DEFINE	ATI1_PATRIMO	011
#DEFINE	ATI1_OBS		012
#DEFINE	ATI1_DTBAIXA	013
#DEFINE	ATI1_NUMCHAPA	014
#DEFINE	ATI1_VCTAPOL	015
#DEFINE	ATI1_NUMAPOL	016
#DEFINE	ATI1_CODCIA		017
#DEFINE	ATI1_CODFORN	018
#DEFINE	ATI1_LOJFORN	019
#DEFINE	ATI1_CIASEG		020
#DEFINE	ATI1_TIPSEG		021
#DEFINE	ATI1_ENDEREC	022
#DEFINE	ATI1_SERIENF	023
#DEFINE	ATI1_NOTAFIS	024

#DEFINE	ATI3_NEWITEM	001
#DEFINE	ATI3_FILIAL		002
#DEFINE	ATI3_CODBEM		003
#DEFINE	ATI3_ITEBEM		004
#DEFINE	ATI3_TIPBEM		005
#DEFINE	ATI3_OCOBAI		006
#DEFINE	ATI3_HISBEM		007
#DEFINE	ATI3_CTBBEM		008
#DEFINE	ATI3_CUSBEM		009
#DEFINE	ATI3_CTDEPR		010
#DEFINE	ATI3_CCUSTO		011
#DEFINE	ATI3_CCDEPR		012
#DEFINE	ATI3_CTADEP		013
#DEFINE	ATI3_CONCOR		014
#DEFINE	ATI3_NUMLCT		015
#DEFINE	ATI3_DATLCT		016
#DEFINE	ATI3_DATDEP		017
#DEFINE	ATI3_DATEXA		018
#DEFINE	ATI3_VORIG1		019
#DEFINE	ATI3_TXDEP1		020
#DEFINE	ATI3_VORIG2		021
#DEFINE	ATI3_TXDEP2		022
#DEFINE	ATI3_VORIG3		023
#DEFINE	ATI3_TXDEP3		024
#DEFINE	ATI3_VORIG4		025
#DEFINE	ATI3_TXDEP4		026
#DEFINE	ATI3_VORIG5		027
#DEFINE	ATI3_TXDEP5		028
#DEFINE	ATI3_COBAM1		029
#DEFINE	ATI3_DPBAM1		030
#DEFINE	ATI3_CORME1		031
#DEFINE	ATI3_VRDME1		032
#DEFINE	ATI3_COACU1		033
#DEFINE	ATI3_VRDAM1		034
#DEFINE	ATI3_TIPODP		086

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ATFImport³ Autor ³ Fernando Vernier      ³ Data ³14.12.2018³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Importacao de cadastro de ativo fixo atraves de .csv       ³±±
±±³Descri‡…o ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ATFImport()

Private _aDados   := {}
Private _aItens   := {}
Private _cArq1    := ""
Private _cArq2    := ""
Private _cProd   := ""
Private _cTes    := ""
Private _cLinha  := ""
Private _lPrim   := .T.
Private _aCampos := {}
Private _aErro   := {}
Private _cPerg   := "ATFIMPORT"
Private _lOk     := .T.

ValidPerg()

Pergunte(_cPerg,.T.)
_cArq1  := mv_par01
_cArq2  := mv_par02

If !File(_cArq1)
	MsgStop("O arquivo " +_cArq1 + " não foi encontrado!")
	Return
Endif

If !File(_cArq2)
	MsgStop("O arquivo " +_cArq2 + " não foi encontrado!")
	Return
Endif

If !MsgYesNo("Confirma ?")
	Return
EndIf

Processa({|| _pATFImp() })

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ _pATFImp ³ Autor ³ Cesar Padovani        ³ Data ³14.12.2018³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processa importacao do arquivo texto.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function _pATFImp()

FT_FUSE(_cArq1)
ProcRegua(FT_FLASTREC())
nLin := 1
FT_FGOTOP()
While !FT_FEOF()
	
	IncProc("Carregando Arquivo SN1 - "+ Alltrim(Str( nLin )) +"/"+ Alltrim(Str( FT_FLASTREC() )) )
	
	_cLinha := FT_FREADLN()
	
	If _lPrim
		_aCampos := Separa(_cLinha,";",.T.)
		_lPrim := .F.
	Else
		AADD(_aDados,Separa(_cLinha,";",.T.))
	EndIf
	nLin++
	
	FT_FSKIP()
EndDo
FT_FUSE()

// Arquivo SN3

FT_FUSE(_cArq2)
ProcRegua(FT_FLASTREC())
nLin := 1
FT_FGOTOP()
While !FT_FEOF()
	
	IncProc("Carregando Arquivo SN3 - "+ Alltrim(Str( nLin )) +"/"+ Alltrim(Str( FT_FLASTREC() )) )
	
	_cLinha := FT_FREADLN()
	
	If _lPrim
		_aCampos := Separa(_cLinha,";",.T.)
		_lPrim := .F.
	Else
		AADD(_aItens,Separa(_cLinha,";",.T.))
	EndIf
	nLin++
	
	FT_FSKIP()
EndDo
FT_FUSE()


SM0->(dbGoTop())
While SM0->(!Eof())
	cEmpAnt := SM0->M0_CODIGO
	cFilAnt := SM0->M0_CODFIL

	_cMemLog := ""
	If Len(_aDados)<>0
		ProcRegua(Len(_aDados))
		Li := 2 // Inicia na segunda linha
		Do While Li<=Len(_aDados) 
			If _aDados[Li][ATI1_FILIAL] <> xFilial("SN1")
				Li++;Loop
			Endif
	
			_cCodAtf := Alltrim(_aDados[Li][ATI1_CODBEM])
			_cItem   := Alltrim(_aDados[Li][ATI1_ITEBEM])
			_cGrupo	 := _aDados[Li][ATI1_GRUPO]
			
			IncProc("Filial: " + cFilAnt + " Importando ATF "+_cCodAtf)
			_cMemLog += "Importando ATF "+Alltrim(_cCodAtf)+" "+_cItem+Chr(10)+Chr(13)
				
			lNovo := .F.
			If !Empty(_cCodAtf)
				DbSelectArea("SN1")
				DbSetOrder(1)
				If !DbSeek(xFilial("SN1")+Padr(_cCodAtf,TamSx3("N1_CBASE")[1])+Padr(_cItem,TamSx3("N1_ITEM")[1]))
					lNovo := .T.
				Else
					Li++;Loop
				Endif
	
				// Posiciona no cadastro do grupo
				DbSelectArea("SNG")
				DbSetOrder(1)
				DbSeek(xFilial("SNG")+_cGrupo)
					
				// Posiciona no cadastro da moeda na data de aquisição.
				_dDtAq := CTOD(Alltrim(_aDados[Li][ATI1_DTAQUIS]))
				_nTxM2 := 1 
				_nTxM3 := 1 
				_nTxM4 := 1 
				_nTxM5 := 1 
				_nTxM5 := 1 
				DbSelectArea("SM2")
				DbSetOrder(1)
				If DbSeek(DTOS(_dDtAq))
					_nTxM2 := SM2->M2_MOEDA2
					_nTxM3 := SM2->M2_MOEDA3 
					_nTxM4 := SM2->M2_MOEDA4 
					_nTxM5 := SM2->M2_MOEDA5 
				EndIf		
							
				Begin Transaction
					
					DbSelectArea("SN1")
					RecLock("SN1",lNovo)
					SN1->N1_FILIAL  := xFilial("SN1")
					SN1->N1_GRUPO   := _cGrupo
					SN1->N1_PATRIM  := "N"
					SN1->N1_CBASE   := _cCodAtf
					SN1->N1_ITEM    := _cItem
					SN1->N1_QUANTD  := Val(StrTran(StrTran(StrTran(_aDados[Li][ATI1_QUANTID],".",""),",","."),"-",""))
					SN1->N1_AQUISIC := _dDtAq
					SN1->N1_DESCRIC := LEFT(UPPER(Alltrim(_aDados[Li][ATI1_DESCRIC])),60)
					SN1->N1_CHAPA   := Alltrim(_aDados[Li][ATI1_NUMCHAPA])
					SN1->N1_OBS	    := Alltrim(_aDados[Li][ATI1_OBS])
					SN1->N1_STATUS  := "1"
					SN1->N1_CALCPIS := "2"
					SN1->N1_PENHORA := "0" 
					SN1->N1_INIAVP  := _dDtAq
					SN1->N1_TPAVP   := "1"
					SN1->N1_ORIGEM  := "ATFIMPORT"
					SN1->N1_FORNEC  := Alltrim(_aDados[Li][ATI1_CODFORN])
					SN1->N1_LOJA    := Alltrim(_aDados[Li][ATI1_LOJFORN])
					SN1->N1_NFISCAL := Alltrim(_aDados[Li][ATI1_NOTAFIS])
					MsUnLock()
					
					_nSeq := 1      
					
					For nItens := 1 To Len(_aItens)
						If _aItens[nItens][ATI3_CODBEM] <> _cCodAtf
							Loop
						Endif                                      
						If _aItens[nItens][ATI3_FILIAL] <> xFilial("SN3")
							Loop
						Endif
						
						lNovo := .F.
						If !SN3->(dbSetOrder(1), dbSeek(xFilial("SN3")+_aItens[nItens][ATI3_CODBEM]+_aItens[nItens][ATI3_ITEBEM]))
							lNovo := .T.
						Else
							Loop
						Endif 
						
						ccItem := _aItens[nItens][ATI3_ITEBEM] 
						_nVlOrig := Val(StrTran(StrTran(_aItens[nItens][ATI3_VORIG1],".",""),",","."))
						_nTxDepr := Val(StrTran(StrTran(_aItens[nItens][ATI3_TXDEP1],"%",""),",","."))
						_nVlAcum := Val(StrTran(StrTran(StrTran(_aItens[nItens][ATI3_VRDAM1],".",""),",","."),"-",""))
	
						RecLock("SN3",lNovo)
						SN3->N3_FILIAL  := xFilial("SN3")
						SN3->N3_CBASE   := _cCodAtf
						SN3->N3_ITEM    := ccItem
						SN3->N3_TIPO    := _aItens[nItens][ATI3_TIPBEM]
						SN3->N3_BAIXA   := "0"
						SN3->N3_HISTOR  := LEFT(UPPER(Alltrim(_aItens[nItens][ATI3_HISBEM])),40) 
						SN3->N3_TPSALDO := "1"
						SN3->N3_TPDEPR  := "1"
						SN3->N3_CCONTAB := AllTrim(_aItens[nItens][ATI3_CTBBEM])
						SN3->N3_CDEPREC := AllTrim(_aItens[nItens][ATI3_CTDEPR])
						SN3->N3_CCDEPR  := AllTrim(_aItens[nItens][ATI3_CCDEPR])
						SN3->N3_CDESP   := SNG->NG_CDESP
						SN3->N3_CCORREC := Iif(!Empty(SNG->NG_CCORREC),SNG->NG_CCORREC,AllTrim(_aItens[nItens][ATI3_CONCOR]))
						SN3->N3_DINDEPR := _dDtAq
						SN3->N3_VORIG1  := _nVlOrig
						SN3->N3_TXDEPR1 := _nTxDepr
						SN3->N3_VORIG2  := _nVlOrig / _nTxM2
						SN3->N3_TXDEPR2 := _nTxDepr
						SN3->N3_VORIG3  := _nVlOrig / _nTxM3
						SN3->N3_TXDEPR3 := _nTxDepr
						SN3->N3_VORIG4  := _nVlOrig / _nTxM4
						SN3->N3_TXDEPR4 := _nTxDepr
						SN3->N3_VORIG5  := _nVlOrig / _nTxM5
						SN3->N3_TXDEPR5 := _nTxDepr
						SN3->N3_VRDACM1 := _nVlAcum
						SN3->N3_VRDACM2 := _nVlAcum / _nTxM2
						SN3->N3_VRDACM3 := _nVlAcum / _nTxM3
						SN3->N3_VRDACM4 := _nVlAcum / _nTxM4
						SN3->N3_VRDACM5 := _nVlAcum / _nTxM5
						SN3->N3_SEQ     := StrZero(_nSeq,3)
						SN3->N3_FILORIG := xFilial("SN3")
						SN3->N3_CALCDEP := "0"
						SN3->N3_RATEIO  := "2"
						SN3->N3_INTP    := "2"
						SN3->N3_ATFCPR  := "2"
						SN3->N3_AQUISIC := _dDtAq
						SN3->N3_VRDMES1 := Val(StrTran(StrTran(StrTran(_aItens[nItens][ATI3_VRDME1],".",""),",","."),"-",""))
						SN3->N3_VRDACM1 := Val(StrTran(StrTran(StrTran(_aItens[nItens][ATI3_VRDAM1],".",""),",","."),"-",""))
						SN3->(MsUnLock())
					Next		
					
				End Transaction
			EndIf
			Li++
		EndDo
	EndIf
	
	SM0->(dbSkip(1))
Enddo
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ValidPerg  ³Autor³ Cesar Padovani           |Data³23/07/2018³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica as perguntas incluindo-as caso nao existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()

DbSelectArea( "SX1" )
DbSetOrder(1)

_cPerg := PADR(_cPerg,10)
aRegs:={}
aAdd(aRegs,{_cPerg,"01","Arquivo SN1 ?","","","mv_ch1","C",70,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","DIR","S","","","",""})
aAdd(aRegs,{_cPerg,"02","Arquivo SN3 ?","","","mv_ch2","C",70,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","DIR","S","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(_cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
		dbCommit()
	EndIf
Next

Return
