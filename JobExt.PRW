#INCLUDE "FWMVCDEF.CH"
#Include "RWMAKE.CH"
#Include "TOPCONN.CH"
#Include "Protheus.Ch"
#Include "VKEY.Ch"

#DEFINE FS_RELATIVE 1
#DEFINE FS_SET 0
#DEFINE FS_END 2

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ JobExt      บAutor  ณFernando Vernier บ Data ณ  11.08.21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Job Processamento Extrato Bancario Automatico  e DDA       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function JobExt(aFiliais)
Local lRet			:= .T.
Local cPosNum		:= ""
Local cPosData		:= ""
Local cPosValor		:= ""
Local cPosOcor		:= ""
Local cPosDescr		:= ""
Local cPosDif		:= "" 
Local lPosNum		:=.F.
Local lPosData		:=.F.
Local lPosValor		:=.F.
Local lPosOcor		:=.F.
Local lPosDescr		:=.F.
Local lPosDif		:=.F.
Local lPosBco		:=.F.
Local lPosAge		:=.F.
Local lPosCta		:=.f.
Local nLidos		:= 0
Local nLenNum		:= 0
Local nLenData		:= 0
Local nLenValor		:= 0
Local nLenDescr		:= 0
Local nLenOcor		:= 0
Local nLenDif		:= 0
Local nLenBco		:= 0
Local nLenAge		:= 0
Local nLenCta		:= 0
Local cArqConf		:= ""
Local cArqEnt		:= ""
Local xBuffer
Local cDebCred		:= ""
Local nHdlBco		:= 0
Local cDifer		:= ""
Local lPosVSI		:=.F.
Local lPosDSI 		:=.F.
Local lPosDCI 		:=.F.
Local nLenVSI		:= 0
Local nLenDSI		:= 0
Local nLenDCI		:= 0
Local cPosVSI		:= ""
Local cPosDSI		:= ""
Local cPosDCI		:= ""
Local lFebraban		:= .F.
Local lGrava		:= .T.
Local nTipoDat		:= 0
Local lGravaSIF		:= .T.
Local nHdlConf		:= 0
Local nTamArq		:= 0
Local nTamDet		:= 0
Local cPosBco		:= ""
Local cPosAge		:= ""
Local cPosCta		:= ""
Local cNumMov  		:= ""
Local cDataBco		:= ""
Local dDataMov		:= CtoD("")
Local cDataMov		:= ""
Local cValorMov		:= ""
Local cCodMov		:= ""
Local cDescrMov		:= ""
Local cTipoMov 		:= ""
Local cDescMov 		:= ""
Local cChkSum		:= ""
Local nLinha		:= 0
Local nContReg		:= 0
Local aConta		:= {}
Local aLog          := {}
Local aArqExtrato   := {{'341','\nexxera\itau\ext\'       ,'\system\extratos\itau.rec'      ,'\nexxera\itau\extproc\'},;
                        {'237','\nexxera\bradesco\ext\'   ,'\system\extratos\bradesco.rec'  ,'\nexxera\bradesco\extproc\'},;
                        {'033','\nexxera\santander\ext\'  ,'\system\extratos\santander.rec' ,'\nexxera\santander\extproc\'},;
                        {'104','\nexxera\cef\ext\'        ,'\system\extratos\caixa.rec'     ,'\nexxera\cef\extproc\'},;
                        {'707','\nexxera\daycoval\ext\'   ,'\system\extratos\daycoval.rec'  ,'\nexxera\daycoval\extproc\'},;
                        {'246','\nexxera\abc\ext\'        ,'\system\extratos\abc.rec'       ,'\nexxera\abc\extproc\'},;
                        {'001','\nexxera\bb\ext\'         ,'\system\extratos\bb.rec'        ,'\nexxera\bb\extproc\'}}

Local aArquivoDDA   := {{'341','\nexxera\itau\var\'       ,'\nexxera\itau\varproc\'}}

DEFAULT aFiliais := {'01','010101'}
	
lJob := .F.
If Select("SX2") == 0
	RpcSetEnv( aFiliais[01], aFiliais[02],,,,,,,,,)   
	lJob := .T.
Endif

Conout(DtoC(Date()) + ' - ' + Time() + ' - Executando Schedule Importa็ใo Automแtica Extrato Bancแrio - Empresa: ' + aFiliais[01] + ' Filia: ' + aFiliais[02])

cBanco 		    := Space(TamSX3("E5_BANCO")[1])
cAgencia 		:= Space(TamSX3("E5_AGENCIA")[1]) 
cConta 		    := Space(TamSX3("E5_CONTA")[1])
cItem			:= Replicate("0",TamSx3("IG_ITEM")[1])
nTamA6Cod		:= TamSX3( "A6_COD"     )[1]
nTamA6Agn 	    := TamSX3( "A6_AGENCIA" )[1]
nTamA6Num 	    := TamSX3( "A6_NUMCON"  )[1]
lFa473Cta 	    := ExistBlock("FA473CTA")

lTemLacto		:= .F.

dbSelectArea("SA6")
SA6->(DBSetOrder(1))

dbSelectArea("SIG")
SIG->(DBSetOrder(1))

dbSelectArea("SIF")
SIF->(DBSetOrder(1))

// Busca Registros da SEE apenas com EE_OPER = 'EXTRATO'

cQuery := 	 " SELECT * " + CRLF
cQuery +=	 " FROM " + RetSqlName("SEE") + " SEE (NOLOCK) " + CRLF
cQuery +=	 " WHERE SEE.D_E_L_E_T_ = '' " + CRLF
cQuery +=	 " AND SEE.EE_FILIAL = '" + xFilial("SEE") + "' " + CRLF
cQuery +=	 " AND SEE.EE_OPER = 'EXTRATO' " + CRLF
cQuery += 	 " ORDER BY SEE.EE_CODIGO "

TCQUERY cQuery NEW ALIAS "CHK1"

xcArqConf := ''
While CHK1->(!Eof())
    _cBanco      := CHK1->EE_CODIGO
    _cAgencia    := CHK1->EE_AGENCIA
    _cConta      := CHK1->EE_CONTA
    _cSubConta   := CHK1->EE_SUBCTA

    If !SEE->(dbSetOrder(1), dbSeek(xFilial("SEE")+_cBanco+_cAgencia+_cConta+_cSubConta))
        aAdd(aLog,{0,"Filial: " + cFilAnt + " - Registro de Parametro de Banco Nao Localizado para Banco: " + _cBanco + " Agencia: " + _cAgencia + " Conta: " + _cConta + " SubConta: " + _cSubConta }) // 
        CHK1->(dbSkip(1));Loop
    Endif

    nArqBco := Ascan(aArqExtrato,{|x| x[1]==AllTrim(_cBanco)})

    If Empty(nArqBco)
        aAdd(aLog,{0,"Filial: " + cFilAnt + " - Banco Nใo Localizado No Verto de Banco x Nome - [aArqExtrato] - Banco: " + _cBanco }) // 
        CHK1->(dbSkip(1));Loop
    Endif

    aConfig1 := {'',_cBanco,_cAgencia,_cConta,_cSubConta, "Job_EXTRATO" }

	lFebraban := IIF(SEE->EE_BYTESXT > 200 , .t., .f.)
	nTamDet	  := IIF(SEE->EE_BYTESXT > 0, SEE->EE_BYTESXT + 2, 202 )
	nTipoDat  := SEE->EE_TIPODAT

    cDirExt := aArqExtrato[nArqBco,2] // Diretorio dos Extratos
    cArqCfg := aArqExtrato[nArqBco,3] // Arquivo de Configura็ใo de Extrato
    cDirTrf := aArqExtrato[nArqBco,4] // Local de Transferencia para o arquivo

    If Empty(nTipoDat)
        nTipoDat := IIF(nTamDet > 202, 4,1)		//1 = ddmmaa		4= ddmmaaaa
    EndIf

    If cArqConf <> cArqCfg
        //Abre arquivo de configuracao
        cArqConf:=cArqCfg

        If !FILE(cArqConf)
            aAdd(aLog,{0,"Filial: " + cFilAnt + " - Arquivo de Configura็ใo nใo encontrado - " + cArqConf}) // 
            CHK1->(dbSkip(1));Loop
        Else
            nHdlConf:=FOPEN(cArqConf,0+64)
        EndIf

        //Leitura do arquivo de configuracao
        nLidos := 0
        FSEEK(nHdlConf,0,0)
        nTamArq:=FSEEK(nHdlConf,0,2)
        FSEEK(nHdlConf,0,0)

        While nLidos <= nTamArq
            
            //Verifica o tipo de qual registro foi lido
            xBuffer := Space(85)
            FREAD(nHdlConf,@xBuffer,85)
            
            If SubStr(xBuffer,1,1) == CHR(1)  // Header
                nLidos+=85
                Loop
            EndIF
            
            If SubStr(xBuffer,1,1) == CHR(4) // Saldo Final
                nLidos+=85
                Loop
            EndIf
            
            //Dados do Saldo Inicial (Bco/Ag/Cta) 
            If !lPosBco  //Nro do Banco
                cPosBco:=Substr(xBuffer,17,10)
                nLenBco:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosBco:= .T.
                nLidos+=85
                Loop
            EndIf
            If !lPosAge  //Agencia
                cPosAge :=Substr(xBuffer,17,10)
                nLenAge :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosAge :=.T.
                nLidos+=85
                Loop
            EndIf
            If !lPosCta  //Nro Cta Corrente
                cPosCta=Substr(xBuffer,17,10)
                nLenCta=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosCta=.T.
                nLidos+=85
                Loop
            Endif
            If !lPosDif   // Diferencial de Lancamento
                cPosDif  :=Substr(xBuffer,17,10)
                nLenDif  :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosDif  :=.t.
                nLidos+=85
                Loop
            EndIf

            //Os dados abaixo nใo sใo utilizados na reconciliacao.
            //Estao ai apenas p/leitura do arquivo de configuracao.
            If !lPosVSI   // Valor Saldo Inicial
                cPosVSI  :=Substr(xBuffer,17,10)
                nLenVSI  :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosVSI  :=.t.
                nLidos+=85
                Loop
            EndIf
            If !lPosDSI   // Data Saldo Inicial
                cPosDSI  :=Substr(xBuffer,17,10)
                nLenDSI  :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosDSI  :=.t.
                nLidos+=85
                Loop
            EndIf
            If !lPosDCI   // Identificador Deb/Cred do Saldo Inicial
                cPosDCI  :=Substr(xBuffer,17,10)
                nLenDCI  :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosDCI  :=.t.
                nLidos+=85
                Loop
            EndIf
            
            //Dados dos Movimentos 
            If !lPosNum  // Nro do Lancamento no Extrato
                cPosNum:=Substr(xBuffer,17,10)
                nLenNum:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosNum:=.t.
                nLidos+=85
                Loop
            EndIf
            
            If !lPosData  // Data da Movimentacao
                cPosData:=Substr(xBuffer,17,10)
                nLenData:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosData:=.t.
                nLidos+=85
                Loop
            EndIf
            
            If !lPosValor  // Valor Movimentado
                cPosValor=Substr(xBuffer,17,10)
                nLenValor=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosValor=.t.
                nLidos+=85
                Loop
            EndIf
            
            If !lPosOcor // Ocorrencia do Banco
                cPosOcor	:=Substr(xBuffer,17,10)
                nLenOcor :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosOcor	:=.t.
                nLidos+=85
                Loop
            EndIf
            
            If !lPosDescr  // Descricao do Lancamento
                cPosDescr:=Substr(xBuffer,17,10)
                nLenDescr:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosDescr:=.t.
                nLidos+=85
                Loop
            EndIf
            
            If !lPosDif   // Diferencial de Lancamento
                cPosDif  :=Substr(xBuffer,17,10)
                nLenDif  :=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
                lPosDif  :=.t.
                nLidos+=85
                Loop
            EndIf
            
            Exit
        Enddo

        //fecha arquivo de configuracao
        Fclose(nHdlConf)
    Endif

    aArqEnt := Directory(cDirExt+AllTrim(_cConta)+"\*.RET",'D')

    Begin Transaction

    For nArqEnt := 1 To Len(aArqEnt)

        cIdProc	:= F473ProxNum("SIF")
        lGravaSIF:= .T.

        aConfig1[1] := cIdProc

        //Abre arquivo enviado pelo banco
        cArqEnt:= cDirExt+AllTrim(_cConta)+"\"+aArqEnt[nArqEnt,1]
        cArqTrf:= cDirTrf+aArqEnt[nArqEnt,1]
        IF !FILE(cArqEnt)
            aAdd(aLog,{0,"Filial: " + cFilAnt + " - Arquivo do Banco nใo encontrado - " + cArqEnt}) //"Arquivo do Banco nใo encontrado"
//            DisarmTransaction()
//            Return .F.    
            Loop
        Else
            nHdlBco:=FOPEN(cArqEnt,0+64)
        EndIF


        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
        //ณ Ler arquivo enviado pelo banco ณ
        //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
        nLidos:=0
        FSEEK(nHdlBco,0,0)
        nTamArq:=FSEEK(nHdlBco,0,2)
        FSEEK(nHdlBco,0,0)

        cChkSum := F473CHKSUM(nHdlBco)

        SIF->(dbSetOrder(3))//IF_FILIAL + IF_ARQSUM
        If SIF->(dbSeek(xFilial("SIF") + cChkSum ) )
            aAdd(aLog,{0,"Filial: " + cFilAnt + " - Arquivo de Extrato jแ importado - " + cArqEnt + " Arquivos Transferido para " + cDirTrf}) //"Arquivo de Extrato jแ importado"

    		//Caso nao exista, cria o diretorio no servidor
			MontaDir(cDirTrf)

			lRet := __CopyFile(cArqEnt, cArqTrf,,,.F.)
            Fclose(nHdlBco)

			If lRet
                FErase(cArqEnt)
            Endif

            Loop
//            DisarmTransaction()
//            Return .F.
        EndIf

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
        //ณ Desenha o cursor e o salva para poder moviment -lo ณ
        //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
        nLidos 		:= 0

        While nLidos <= nTamArq
            nLinha++
            
            //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
            //ณ Tipo qual registro foi lido ณ
            //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
            xBuffer:=Space(nTamDet)
            FREAD(nHdlBco,@xBuffer,nTamDet)
            
            //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
            //ณ Verifica o diferencial do registro de Lancamento 			ณ
            //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
            If !lFebraban  // 200 posicoes
                cDifer :=Substr(xBuffer,Int(Val(Substr(cPosDif, 1,3))),nLenDif )
            Else
                cDifer := "xx"  // 240 posicoes
            Endif
            
            // Header do arquivo
            IF (SubStr(xBuffer,1,1) == "0" .and. !lFebraban).or. ; // 200 posicoes
                (Substr(xBuffer,8,1) == "0" .and. lFebraban)			// 240 posicoes
                nLidos+=nTamDet
                Loop
            EndIF
            
            //Trailer do arquivo
            IF (SubStr(xBuffer,1,1) == "9" .and. !lFebraban) .or. ; //200 posicoes
                (Substr(xBuffer,8,1) == "9" .and. lFebraban)			 //240 posicoes
                nLidos+=nTamDet
                Exit
            EndIF
            
            // Saldo Inicial
            IF (SubStr(xBuffer,1,1) == "1" .and. cDifer == "0" .and. !lFebraban) .or. ;
                    (SubStr(xBuffer,8,1) == "1" .and. lFebraban)
                cBanco   := Substr(xBuffer,Int(Val(Substr(cPosBco, 1,3))),nLenBco )
                cAgencia := Substr(xBuffer,Int(Val(Substr(cPosAge, 1,3))),nLenAge )
                cConta   := Substr(xBuffer,Int(Val(Substr(cPosCta, 1,3))),nLenCta )
                If lFa473Cta
                    aConta   := ExecBlock("FA473CTA", .F., .F., {cBanco, cAgencia, cConta} )
                    cBanco   := aConta[1]
                    cAgencia := aConta[2]
                    cConta   := aConta[3]
                Endif

                If cBanco != aConfig1[2]
                    lTemLacto := .T.
                    Exit
                EndIf	
                    
                // A473VldBco( @cBanco , @cAgencia , @cConta, @nLinha, @aLog, @lRet )
                        
                cBanco 		:= _cBanco // PadR( cBanco   , nTamA6Cod )
                cAgencia 	:= _cAgencia // PadR( cAgencia , nTamA6Agn )
                cConta 		:= _cConta // PadR( cConta   , nTamA6Num )

                If AllTrim(cBanco)!= AllTrim(aConfig1[2])
                    aADD(aLog,{nLinha, "Filial: " + cFilAnt + " - Banco nใo cadastrado - " + aConfig1[2] } ) //"Banco nใo cadastrado"
                    lRet := .F.
                Endif

                nLidos+=nTamDet
                Loop
            EndIF

            // Saldo Final
            IF (SubStr(xBuffer,1,1) == "1" .and. cDifer == "2" .and. !lFebraban) .or. ;
                    (Substr(xBuffer,8,1) == "5" .and. lFebraban)
                nLidos+=nTamDet
                Loop
            EndIF
            
            // Lancamentos
            IF (SubStr(xBuffer,1,1) == "1" .and. cDifer == "1" .and. !lFebraban) .or. ;
                    (Substr(xBuffer,8,1) == "3" .and. lFebraban)
                
                lTemLacto := .T.	

                cBanco 		:= _cBanco // PadR( cBanco   , nTamA6Cod )
                cAgencia 	:= _cAgencia // PadR( cAgencia , nTamA6Agn )
                cConta 		:= _cConta // PadR( cConta   , nTamA6Num )

                cNumMov  :=Substr(xBuffer,Int(Val(Substr(cPosNum,1,3))),nLenNum)
                cDataBco :=Substr(xBuffer,Int(Val(Substr(cPosData,1,3))),nLenData)
                cDataBco :=ChangDate(cDataBco,nTipoDat)
                dDataMov :=Ctod(Substr(cDataBco,1,2)+"/"+Substr(cDataBco,3,2)+"/"+Substr(cDataBco,5,2),"ddmmyy")
                cDataMov :=dToc(dDataMov)

                cValorMov:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosValor,1,3))),nLenValor))/100,2)
                cCodMov	 :=Substr(xBuffer,Int(Val(Substr(cPosOcor,1,3))),nLenOcor)
                cDescrMov:=Substr(xBuffer,Int(Val(Substr(cPosDescr,1,3))),nLenDescr)
                
                
                dbSelectArea("SEJ")
                If dbSeek(xFilial("SEJ")+cBanco+cCodMov)
                    cTipoMov := SEJ->EJ_OCORSIS
                    cDescMov := SEJ->EJ_DESCR
                    cDebCred := SEJ->EJ_DEBCRE
                Else
                    aADD(aLog,{nLinha ,"Filial: " + cFilAnt + " - Ocorrencia Nใo Encontrada" + " - " + cCodMov + " - Banco: " + _cBanco } ) //"Ocorrencia Nใo Encontrada"
                    lGrava 	:= .F.
                    lRet 	:= .F.
                Endif

                If lGrava

                    If SA6->(DbSeek(xFilial("SA6")+cBanco+cAgencia+cConta))

                        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
                        //ณ Grava dados no arquivo de trabalhoณ
                        //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
                        If lGravaSIF .And. SA6->A6_BLOCKED <> "1"
                            RecLock("SIF",.T.)
                            SIF->IF_FILIAL 	:= xFilial("SIF")
                            SIF->IF_IDPROC  := aConfig1[1 ]
                            SIF->IF_DTPROC  := ctod(cDataMov)
                            SIF->IF_BANCO	:= aConfig1[2]
                            SIF->IF_DESC	:= aConfig1[6]
                            SIF->IF_STATUS 	:= '1'
                            SIF->IF_ARQCFG	:= cArqConf
                            SIF->IF_ARQIMP	:= cArqEnt
                            SIF->IF_ARQSUM	:= cChkSum
                            SIF->(MsUnlock())
                            lGravaSIF:= .F.

                            aAdd(aLog,{0,"Filial: " + cFilAnt + " - Arquivo Processado Com Sucesso " + cArqEnt + " Id Extrato: " + SIF->IF_IDPROC})
                        EndIf

                        //Grava se nใo tiver inconsist๊ncia

                        If SA6->A6_BLOCKED <> "1"//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
                            // Grava SIG
                            RecLock("SIG",.T.)
                            cItem := Soma1(cItem)
                            SIG->IG_FILIAL 	:= xFilial("SIG")
                            SIG->IG_IDPROC	:= aConfig1[1 ]
                            SIG->IG_ITEM	:= cItem
                            SIG->IG_STATUS	:= '1'
                            SIG->IG_DTEXTR	:= CTOD(cDataMov)
                            SIG->IG_DOCEXT	:= cNumMov
                            SIG->IG_SEQMOV  := F473ProxNum("SIG")
                            SIG->IG_VLREXT 	:= Val(str(cValorMov,17,2))
                            SIG->IG_TIPEXT	:= cCodMov
                            SIG->IG_CARTER	:= IIF(cDebCred=="D","2","1")
                            SIG->IG_AGEEXT  := cAgencia
                            SIG->IG_CONEXT  := cConta
                            SIG->IG_HISTEXT := cDescrMov
                            SIG->IG_FILORIG := cFilAnt
                            SIG->(MsUnlock())
                            nContReg++
                        Else
                            aADD(aLog,{nLinha ,"Filial: " + cFilAnt + " - Banco: "  + cBanco + " Agencia: " + cAgencia + " Conta: " + cConta + " Registro Bloqueado " } )//"Banco: "##" Agencia: "##" Conta: "##" nใo existe."
                            lRet := .F.
                        EndIf
                    Endif
                EndIf

            Endif
            nLidos += nTamDet
        Enddo

        If nContReg <= 0
            If !lTemLacto	
                aADD(aLog,{0 ,"Filial: " + cFilAnt + " - Este arquivo de extrato nใo possui lan็amentos. " + cArqEnt } )//"Este arquivo de extrato nใo possui lan็amentos. "
                lRet := .F.
            Else
                aADD(aLog,{0 ,"Filial: " + cFilAnt + " - Arquivo de Extrato Invแlido. Verifique arquivo de configura็ใo e extrato. - " + cArqEnt } )//"Arquivo de Extrato Invแlido. Verifique arquivo de configura็ใo e extrato."
                lRet := .F.
            EndIf
        EndIf

        //Fecha arquivo do Banco 
        Fclose(nHdlBco)

        If nContReg > 0
            aAdd(aLog,{0,"Filial: " + cFilAnt + " - Arquivo Processado Com Sucesso " + cArqEnt + " Id Extrato: " + SIF->IF_IDPROC + " Transferido para " + cDirTrf})

    		//Caso nao exista, cria o diretorio no servidor
			MontaDir(cDirTrf)

			lRet := __CopyFile(cArqEnt, cArqTrf,,,.F.)
			If lRet
                FErase(cArqEnt)
            Endif
        Endif
    Next

    End Transaction

    CHK1->(dbSkip())
Enddo
CHK1->(dbCloseArea())

cTxt := ''
For nLog := 1 To Len(aLog)
    cTxt += 'Log Job_Extrato - ' + aLog[nLog,2] + "<br>"
Next

If !Empty(cTxt)
    U_EMAIL(GetNewPar("MV_XJBEX",'fernando.vernier@grupo3778.com.br;luiz.alves@grupo3778.com.br'),"Job Importa็ใo Extrato Automatico - IMTEP.",cTxt,"")
Endif

// Importa็ใo Arquivos DDA

Conout(DtoC(Date()) + ' - ' + Time() + ' - Executando Schedule Importa็ใo Automแtica DDA - Empresa: ' + aFiliais[01] + ' Filia: ' + aFiliais[02])

aLog := {}

For nDDA := 1 To Len(aArquivoDDA)

    // Busca Registros da SEE apenas com EE_OPER = 'EXTRATO'

    cQuery := 	 " SELECT * " + CRLF
    cQuery +=	 " FROM " + RetSqlName("SEE") + " SEE (NOLOCK) " + CRLF
    cQuery +=	 " WHERE SEE.D_E_L_E_T_ = '' " + CRLF
    cQuery +=	 " AND SEE.EE_FILIAL = '" + xFilial("SEE") + "' " + CRLF
    cQuery +=	 " AND SEE.EE_OPER = 'DDA' " + CRLF
    cQuery +=	 " AND SEE.EE_CODIGO = '" + aArquivoDDA[nDDA,1] + "' " + CRLF
    cQuery += 	 " ORDER BY SEE.EE_CODIGO "

    TCQUERY cQuery NEW ALIAS "CHK1"

    While CHK1->(!Eof())
        _cBanco      := CHK1->EE_CODIGO
        _cAgencia    := CHK1->EE_AGENCIA
        _cConta      := CHK1->EE_CONTA
        _cSubConta   := CHK1->EE_SUBCTA

        If !SEE->(dbSetOrder(1), dbSeek(xFilial("SEE")+_cBanco+_cAgencia+_cConta+_cSubConta))
            aAdd(aLog,{0,"Filial: " + cFilAnt + " - Registro de Parametro de Banco Nao Localizado para Banco: " + _cBanco + " Agencia: " + _cAgencia + " Conta: " + _cConta + " SubConta: " + _cSubConta }) // 
            CHK1->(dbSkip(1));Loop
        Endif

        cDirExt := aArquivoDDA[nDDA,2] // Diretorio dos DDAS
        cDirTrf := aArquivoDDA[nDDA,3] // Local de Transferencia para o arquivo

        aArqEnt := Directory(cDirExt+AllTrim(_cConta)+"\*.RET",'D')

        For nArqEnt := 1 To Len(aArqEnt)

            cArqEnt:= cDirExt+AllTrim(_cConta)+"\"+aArqEnt[nArqEnt,1]
            cArqTrf:= cDirTrf+aArqEnt[nArqEnt,1]

            cArquivo := MemoRead(cArqEnt)

            nLinhas := MlCount(cArquivo,240)

            For nLin := 1 To nLinhas
                cLinha := MemoLine(cArquivo,240,nLin)

                If SubStr(cLinha,14,1) $ "G"    // SEGMENTO G DDA ITAU
                    cCnpjFor    := SubStr(cLinha,64,14)

                    If !SA2->(dbSetOrder(3), dbSeek(xFilial("SA2")+cCnpjFor))
                        Loop
                    Endif

                    cNumTit     := SubStr(cLinha,148,15)
                    cDtVenct    := SubStr(cLinha,108,8)
                    dDtVenct    := CtoD(Left(cDtVenct,2)+'/'+SubStr(cDtVenct,3,2)+'/'+Right(cDtVenct,4))
                    nValoDDA    := Val((SubStr(cLinha,116,15)))/100
                    cOcorren    := SubStr(cLinha,16,2)

                    If cOcorren $ "02" //Entrada de titulo via DDA					
                        cBcoForn    := SubStr(cLinha,18,3)
                        xFatorVc    := SubStr(cLinha,023,04)//Fator de Vencimento
                        cFatorVc    := StrZero(dDtVenct - ctod("07/10/97"), 4)
                        cMoeda	    := "9"					//Moeda do titulo (9 = Real)
                        cDV		    := SubStr(cLinha,22,01)	//Digito verificador do codigo de barras (sera calculado)
                        cCpoLivre   := SubStr(cLinha,37,25)	//Campo Livre
                        cValPgto    := SubStr(cLinha,121,10)

                        cCodBar	 := ""						//Codigo de barras completo
                        
                        //Calculo do digito verificador do codigo de barras
                        cDV := DV_BarCode(cBcoForn + cMoeda + cFatorVc + cValPgto + cCpoLivre)
                        
                        /*Montagem do c๓digo de barras:
                        01-03 - Codigo do banco
                        04-04 - Codigo da moeda
                        05-05 - Digito verificador
                        06-09 - Fator vencimento
                        10-19 - Valor do documento
                        20-44 - Campo Livre
                        XFatorVc := StrZero(ctod(dDtVenct) - ctod("07/10/97"), 4)

                        */
                        cCodBar :=	cBcoForn + cMoeda + cDV + cFatorVc + cValPgto + cCpoLivre

                        //Grava arquivo de concilia็ใo DDA
                        If RecLock("FIG",.T.)
                            FIG->FIG_FILIAL	:= xFilial("FIG")
                            FIG->FIG_DATA	:= dDataBase
                            FIG->FIG_FORNEC	:= SA2->A2_COD
                            FIG->FIG_LOJA	:= SA2->A2_LOJA
                            FIG->FIG_NOMFOR	:= SA2->A2_NREDUZ
                            FIG->FIG_TITULO	:= cNumTit
                            FIG->FIG_TIPO	:= "NF"
                            FIG->FIG_VENCTO	:= dDtVenct
                            FIG->FIG_VALOR	:= nValoDDA
                            FIG->FIG_CONCIL	:= "2"
                            FIG->FIG_CNPJ	:= cCnpjFor
                            FIG->FIG_CODBAR	:= cCodBar
                            FIG->(MsUnlock())
                        Endif
                    Endif
                EndIf
            Next

            aAdd(aLog,{0,"Filial: " + cFilAnt + " - DDA Processado Com Sucesso " + cArqEnt + " Registro FIG: " + StrZero(FIG->(Recno()),10) + " Transferido para " + cDirTrf})

    		//Caso nao exista, cria o diretorio no servidor
			MontaDir(cDirTrf)

			lRet := __CopyFile(cArqEnt, cArqTrf,,,.F.)
			If lRet
                FErase(cArqEnt)
            Endif
        Next

        CHK1->(dbSkip(1))
    Enddo
    CHK1->(dbCloseArea())
Next

cTxt := ''
For nLog := 1 To Len(aLog)
    cTxt += 'Log Job_DDA - ' + aLog[nLog,2] + "<br>"
Next

If !Empty(cTxt)
    U_EMAIL(GetNewPar("MV_XJBEX",'fernando.vernier@grupo3778.com.br;luiz.alves@grupo3778.com.br;tesouraria@grupo3778.com.br'),"Job Importa็ใo DDA Automatico - IMTEP.",cTxt,"")
Endif
Return lRet


//-------------------------------------------------------------------
/*/{Protheus.doc} F473CHKSUM

Retorna o CheckSum do Arquivo.

@author	Alvaro Camillo Neto
@since		01/10/13
@version	MP11.90
		
/*/
//-------------------------------------------------------------------
Static Function F473CHKSUM(nHdlBco)
Local cRet		:= ""
Local cBuffer	:= Space(402)
Local nOffSet	:= fSeek(nHdlBco,0,FS_RELATIVE) // Sera utilizado para retornar o ponteiro do arquivo a posicao original
Local nTamArq	:= fSeek(nHdlBco,0,FS_END) // Obtem o tamanho do arquivo
Local cIdArq    := ""
Local cTrailler := ""

fSeek(nHdlBco,-804,FS_END) // Volta 804 bytes para compor o CheckSum

// Le o arquivo ate final
While fReadLn(nHdlBco,@cBuffer,402)
	cRet += cBuffer
End

fSeek(nHdlBco,nOffSet,FS_SET) // Retorna o ponteiro para a posicao original

cTrailler := cRet+Transform(nTamArq,"")

cIdArq	 := Str(MsCrc32(cTrailler),10) 

Return cIdArq



//-------------------------------------------------------------------
/*/{Protheus.doc} A473VldBco
Valida o banco, agencia e conta 
Funcao retirada do FINA910A
@author	Daniel Mendes
@since		30/05/16
@version	12.1.7
/*/
//-------------------------------------------------------------------
Static Function A473VldBco( cBanco , cAgencia , cConta, nLinha, aLog, lRet )
Local aAreaATU := GetArea()
Local aAreaSA6 := SA6->( GetArea() )
Local cFilSA6  := xFilial( 'SA6' )
Local nSubAge  := 0
Local nSubCon  := 0
Local lStop    := .F.

If !SA6->( MsSeek( cFilSA6 + cBanco + cAgencia + cConta ) )
	SA6->( MsSeek( cFilSA6 + cBanco ) )

	While !SA6->( Eof() ) .And. cFilSA6 == SA6->A6_FILIAL .And. cBanco == SA6->A6_COD .And. !lStop
		
		If SA6->A6_BLOCKED = '1' //Se banco estiver bloqueado ceverแ ser pulado
			SA6->( DbSkip() )
			Loop
		EndIf
			
		nSubAge := At( Alltrim( SA6->A6_AGENCIA ) , cAgencia )
		nSubCon := At( Alltrim( SA6->A6_NUMCON  ) + ' ' + AllTrim(SA6->A6_DVCTA) , cConta   )
		If nSubAge > 0 .And. nSubCon > 0
			If ( SubStr( cAgencia , 1 , nSubAge-1 ) == StrZero( 0 , nSubAge-1 ) .Or. ;// Valida 0 a esquerda: Agencia 
			     Alltrim( SA6->A6_AGENCIA ) == AllTrim( cAgencia ) ) ;
			   .And. ;
			   ( SubStr( cConta   , 1 , nSubCon-1 ) == StrZero( 0 , nSubCon-1 ) .Or. ;// Valida 0 a esquerda: Conta Corrente
			     Alltrim( SA6->A6_NUMCON  ) + ' ' + AllTrim(SA6->A6_DVCTA) == AllTrim( cConta   ) )
				cAgencia := SA6->A6_AGENCIA
				cConta   := SA6->A6_NUMCON
				cBanco   := SA6->A6_COD
				lStop    := .T.
			EndIf
		EndIf
		SA6->( DbSkip() )
	EndDo
	
	If Empty(nSubAge) .or. Empty(nSubCon)  
        aADD(aLog,{nLinha , "Filial: " + cFilAnt + " - Banco: "  + cBanco + " Agencia: " + cAgencia + " Conta: " + cConta + " nโo Existe." } )//"Banco: "##" Agencia: "##" Conta: "##" nใo existe."
		lRet := .F.		
	EndIf?
	
EndIf

RestArea( aAreaSA6 )
RestArea( aAreaATU )
aSize( aAreaSA6 , 0 )
aSize( aAreaATU , 0 )
aAreaSA6 := Nil
aAreaATU := Nil

Return Nil


//-------------------------------------------------------------------
/*/{Protheus.doc} F473ProxNum

Retorna o pr๓ximo n๚mero da chave

@author	Alvaro Camillo Neto
@since		01/10/13
@version	MP11.90
		
/*/
//-------------------------------------------------------------------
Static Function F473ProxNum(cTab)
Local cNovaChave := ""
Local aArea := GetArea()
Local cCampo := ""
Local cChave 
Local nIndex := 0

If cTab == "SIF"
	SIF->(dbSetOrder(1))//IF_FILIAL+IF_IDPROC
	cCampo := "IF_IDPROC"
	nIndex := 1	
Else
	SIG->(dbSetOrder(2))//IG_FILIAL+IG_SEQMOV
	cCampo := "IG_SEQMOV"
	cChave := "IG_SEQMOV"+cEmpAnt
	nIndex := 2
EndIf


While .T.
	(cTab)->(dbSetOrder(nIndex))
	cNovaChave := GetSXEnum(cTab,cCampo,cChave,nIndex)
	ConfirmSX8()
	If cTab == "SIF" 
		If (cTab)->(!dbSeek(xFilial(cTab) + cNovaChave) )
			Exit
		EndIf
	Else
		If (cTab)->(!dbSeek(cNovaChave) )
			Exit
		EndIf
	EndIf
EndDo

RestArea(aArea)
Return cNovaChave



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณDv_BarCodeบAutor  ณClaudio D. de Souza บ Data ณ  14/12/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCalcula o digito verificador de um codigo de barras padrao  บฑฑ
ฑฑบ          ณFebraban.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CodBarVl2                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DV_BarCode( cBarCode )
Local cDig
Local nPos
Local nAux := 0

For nPos := 1 To 43
	nAux += Val(SubStr(cBarCode,nPos,1)) * If( nPos<= 3, ( 5-nPos),     ;
		If( nPos<=11, (13-nPos),     ;
		If( nPos<=19, (21-nPos),     ;
		If( nPos<=27, (29-nPos),     ;
		If( nPos<=35, (37-nPos),     ;
		(45-nPos) )))))
Next
nAux := nAux % 11
cDig := If( (11-nAux)>9, 1, (11-nAux) )

Return Str(cDig,1)
