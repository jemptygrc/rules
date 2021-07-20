*================================================================================================================================================
* GRINCOP LDA
*      :: Data Criação:    20/07/2021
*      :: Programador:     João Mendes
*      :: Cliente:     QUEIJARIA SOALHEIRA JDAF
*      :: Objetivo:    CONTROLAR FATURAÇÃO E DIVIDAS DE CLIENTE    
* Histórico de Versões
*      :: 20/07/2021 »» JM :: Criação
*================================================================================================================================================


LOCAL numCliente,numEstab,numEstab
LOCAL msel
msel=''

select ft
numCliente = astr(ft.no)
numEstab = astr(ft.estab)
ln_Total = ft.etotal


TEXT TO msel TEXTMERGE NOSHOW
	SELECT
	CL.esaldo, CL.eplafond, CL.clstamp
	FROM CL (nolock)
	WHERE
	1=1 AND
	CL.no=<<numCliente>> AND CL.estab=<<numEstab>>
    AND cl.eplafond>=1
	AND CL.no<>594
	AND CL.no<>1
	AND CL.no<>567
ENDTEXT
msg(msel)

u_sqlexec(msel,"curs_sel")

select curs_sel
ln_Saldo = curs_sel.esaldo
ln_Plafond = curs_sel.eplafond
lc_ClStamp = curs_sel.clstamp

****************************************************************************************
*
* SE O PLAFOND FOR ULTRAPASSADO, VAMOS ATIVAR A FATURAÇÃO CANCELADA
*
****************************************************************************************
if ln_Plafond > 0 
if ln_Plafond < ln_Saldo + ln_Total

	TEXT TO updt_cl TEXTMERGE NOSHOW
		UPDATE CL SET
		CL.nocredit=1
		WHERE	
		CL.clstamp='<<lc_ClStamp>>'
	ENDTEXT

msg(updt_cl)

	if u_sqlexec ([BEGIN TRANSACTION])
		if u_sqlexec(updt_cl)
			u_sqlexec([COMMIT TRANSACTION])
    		messagebox('O plafond do cliente foi ultrapassado! Estado de faturação alterado para "Faturação Cancelada"',64, 'GRINCOP')
    		return .f.
		else
			u_sqlexec([ROLLBACK])
			Messagebox("Erro - updt_cl - p.f. contracte o seu Administrador de Sistema!!")
			exit
		endif
	endif
endif
endif
return .t.