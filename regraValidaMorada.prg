*================================================================================================================================================

*      :: Data Criação:    06/07/2021


*      :: Objetivo:    Regra para validar se o local de descarga foi devidamente preenchido    
* Histórico de Versões
*      :: 07/07/2021 »» JM :: Simplificação codigo sem usar cursores criados e validação para ser implementado em produção
*================================================================================================================================================
SELECT FT 
localDescarga=ft.descar

DO CASE 
CASE empty(localDescarga) 
    messagebox("Atenção! Deve preencher o local de descarga",0+64,"")
	return .F.
CASE localDescarga="Morada do Cliente"
    messagebox("Atenção! Deve preencher corretamente o local de descarga com a morada associada ao cliente na tabela de «Moradas de Carga e Descarga»"+chr(13)+chr(10)+chr(13)+chr(10)+"Clique em OK para continuar",0+64,"GRINCOP")
	return .F.
OTHERWISE 
	return .T.
ENDCASE

