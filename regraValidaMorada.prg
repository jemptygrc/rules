*================================================================================================================================================
* GRINCOP LDA
*      :: Data Criação:    06/07/2021
*      :: Programador:     João Mendes
*      :: Cliente:     Ambienti D Interni
*      :: Objetivo:    Regra para validar se o local de descarga foi devidamente preenchido    
* Histórico de Versões
*      :: 06/07/2021 »» JM :: Criação
*================================================================================================================================================


****DECLARAR E INICIALIZAR VARIAVEIS
LOCAL nomeCliente,numCliente,nomeDoc
nomeCliente=""
numCliente=0
nomeDoc=""

LOCAL msel
msel=''

LOCAL my_nomeDoc,my_fornecedor
my_nomeDoc=""
my_descarga=""

***************************************************************************************
***************************************************************************************

Set Point To "." && Coloca o ponto na vez da virgula nas casas decimais

***SELECIONAR DADOS PREENCHIDOS NO CABEÇALHO
select ft
nomeCliente = alltrim(ft.nome)
numCliente = astr(ft.No)


***CURSOR msel COM CONDIÇÃO DOS DADOS PREENCHIDOS NO CABEÇALHO
TEXT TO msel TEXTMERGE NOSHOW
	SELECT
        ft.descar as descarga
	FROM ft (nolock)
	WHERE
	1=1 AND
		ft.nome='<<nomeCliente>>' AND
		ft.No=<<numCliente>>
		order by ft.data DESC
ENDTEXT
msg(msel)

u_sqlexec(msel,"curs_sel")

***************************************************************************************
***************************************************************************************

select curs_sel
*my_nomeDoc = alltrim(curs_sel.Adoc)
my_descarga = alltrim(curs_sel.descarga)

DO CASE 
CASE !empty(my_descarga) 
    messagebox("Atenção! Deve preencher a morada de descarga",0+64,"GRINCOP")
CASE my_descarga="Morada do Cliente"
    messagebox("Atenção! Deve preencher corretamente a morada de descarga",0+64,"GRINCOP")
ENDCASE

*IF !empty(my_descarga) 
	**messagebox("Atenção! Já existe o documento: «"+my_nomeDoc+"» para o fornecedor: «"+my_fornecedor+"» com o valor Total em Euros de: «"+my_etotal+"» "+chr(13)+chr(10)+chr(13)+chr(10)+chr(13)+chr(10)+"Clique na tecla OK para continuar.",0+64,"GRINCOP")
    *messagebox("Atenção deve preencher a morada de descarga","GRINCOP")
*ENDIF

*IF my_descarga="Morada do Cliente"
	**messagebox("Atenção! Já existe o documento: «"+my_nomeDoc+"» para o fornecedor: «"+my_fornecedor+"» com o valor Total em Euros de: «"+my_etotal+"» "+chr(13)+chr(10)+chr(13)+chr(10)+chr(13)+chr(10)+"Clique na tecla OK para continuar.",0+64,"GRINCOP")
    *messagebox("Atenção deve preencher a morada de descarga","GRINCOP")
*ENDIF

Set Point To se_pointer && Repoe a virgula nas casas decimais
return .T.
