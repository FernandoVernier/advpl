#INCLUDE "TOPCONN.CH"
#include "rwmake.ch"
#include "ap5mail.ch"
#include "tbiconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AjSucata   บ Autor ณ Fernando Vernier บ Data ณ  17/01/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescri็ใo ณ Ajusta Saldo Sucata na Virada do Mes Para Zerar
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Exclusivo                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function AjProdu()
Local aArea := GetArea()
Local 	aSays      	:= {}
Local 	aButtons   	:= {}
Local 	nOpca    	:= 0    
Local	cCadastro	:=	'Ajuste de Producao'

AADD (aSays, "Este programa tem por objetivo efetuar o processamento de ")
AADD (aSays, "movimentacoes de producao, acrescentando mao de obra")

//AAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. )    }} )
AAdd(aButtons, { 1,.T.,{|| nOpca := 1,FechaBatch() }} )
AAdd(aButtons, { 2,.T.,{|| nOpca := 0,FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )
	
If nOpca == 1
	Processa( {|lEnd| U_fPrcSC(MV_PAR01,PadR(MV_PAR02,TamSX3('B2_COD')[1]),MV_PAR03,.f.)}, "Aguarde...","Aguarde o Processamento...", .T. )
Endif

RestArea(aArea)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  fPrcSC  บ Autor ณ Fernando Vernier    บ Data ณ  06/11/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ  Processamento                                              ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function fPrcSC()
Local aArea := GetArea()

cQry:= " SELECT R_E_C_N_O_ REGI " 
cQry+= " FROM "+RETSQLNAME("SD3")+" D3 "
cQry+= " WHERE LEFT(D3.D3_CF,2) = 'PR'  " 
cQry+= " AND D3.D_E_L_E_T_=''"
cQry+= " AND D3.D3_ESTORNO <> 'S' "
			
If Select("TTMP") > 0
	TRD->(dbCloseArea())
EndIf
			
TCQUERY cQry New Alias "TTMP"
			
Count To nReg

TTMP->(dbGoTop())

begin transaction
ProcRegua(nReg)
While TTMP->(!Eof())           
	IncProc("Aguarde Processando...")

	SD3->(dbGoTo(TTMP->REGI))
	
	lMod := .t.
	lCif := .t.              
	cProduto	:=	SD3->D3_COD
	
	// Localiza Estrutura.
	
	If SG1->(dbSetOrder(1), dbSeek(xFilial("SG1")+cProduto))      
		While SG1->(!Eof()) .And. SG1->G1_FILIAL == xFilial("SG1") .And. SG1->G1_COD == cProduto
			If Left(SG1->G1_COMP,3)$'MOD,CIF'                        
				cNumOP	:=	SD3->D3_OP
				cProd	:=	SG1->G1_COMP
				cLocal  :=  SD3->D3_LOCAL
				nQtde	:=	SG1->G1_QUANT
				
				If SD3->(dbSetOrder(1), dbSeek(xFilial("SD3")+cNumOP+cProd))
					If Left(cProd,3)=='MOD'
						lMod := .F.
					ElseIf Left(cProd,3)=='CIF'
						lCif := .F.
					Endif
				Endif
	
				SD3->(dbGoTo(TTMP->REGI))     

				If !lMod .And. Left(cProd,3) == 'MOD'
					SG1->(dbSkip(1));Loop
				ElseIf !lCif .And. Left(cProd,3) == 'CIF'
					SG1->(dbSkip(1));Loop
				Endif
				
				// Joga os Dados do Registro D3 no Vetor.
				
				aDados := {}
				For nI := 1 To SD3->(FCount())
					AAdd(aDados, {SD3->(FieldName(nI)),SD3->(FieldGet(nI))} )
				Next                    
	
				SB1->(dbSetOrder(1), dbSeek(xFilial("SB1")+cProd))

				/// Efetua Lancamento de Sucata 
					
				For nI := 1 To Len(aDados)    
					If AllTrim(aDados[nI,1])=='D3_TM'
						aDados[nI,2] := '501' 
					ElseIf AllTrim(aDados[nI,1])=='D3_COD'
						aDados[nI,2] := cProd
					ElseIf AllTrim(aDados[nI,1])=='D3_UM'
						aDados[nI,2] := SB1->B1_UM
					ElseIf AllTrim(aDados[nI,1])=='D3_GRUPO'
						aDados[nI,2] := SB1->B1_GRUPO
					ElseIf AllTrim(aDados[nI,1])=='D3_CONTA'
						aDados[nI,2] := SB1->B1_CONTA
					ElseIf AllTrim(aDados[nI,1])=='D3_CC'
						aDados[nI,2] := SB1->B1_CC
					ElseIf AllTrim(aDados[nI,1])=='D3_PARCTOT'
						aDados[nI,2] := ''
					ElseIf AllTrim(aDados[nI,1])=='D3_TIPO'
						aDados[nI,2] := SB1->B1_TIPO
					ElseIf AllTrim(aDados[nI,1])=='D3_QUANT'
						aDados[nI,2] := Round(nQtde * aDados[nI,2],6)
					ElseIf AllTrim(aDados[nI,1])=='D3_CF'
						aDados[nI,2] := 'RE0'
					Endif
				Next
					
				If RecLock("SD3",.t.)
					For nI := 1 To Len(aDados)
						nPos := SD3->(FieldPos(aDados[nI,1]))
						SD3->(FieldPut(nPos,aDados[nI,2]))
					Next
					SD3->(MsUnlock())
				Endif  

				SD3->(dbGoTo(TTMP->REGI))     
			Endif
			
			SG1->(dbSkip(1))
		Enddo
	Endif	           

	TTMP->(dbSkip(1))
	
Enddo
TTMP->(dbCloseArea())

End transaction

RestArea(aArea)
Return .T.


// Substituido pelo assistente de conversao do AP6 IDE em 12/02/05 ==> Function ValidPerg
Static Function ValidPerg()
_aArea := GetArea()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PadR(cPerg,10)

aRegs :={}
Aadd(aRegs,{cPerg,"01","Data Base   ?","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Prod.Sucata ?","mv_ch2","C",TamSX3('B2_COD')[1],0,0,"G","","mv_par02","","","","","","","","","","","","","","","SB1",""})
Aadd(aRegs,{cPerg,"03","Armazem Suc ?","mv_ch3","C",02,0,0,"G","","mv_par03","","","","","","","","","","","","","","","NNR",""})

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
		SX1->X1_VALID	:= aRegs[i,27]
		MsUnlock()
		DbCommit()
	Endif
Next

RestArea(_aArea)

Return()


