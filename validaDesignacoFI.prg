*================================================================================================================================================
* GRINCOP LDA
*      :: Data Criação:    12/08/2021
*      :: Cliente:     XYZ
*      :: Objetivo:    IMpedir gravacao de faturas com linhas com valores preenchidos e designacao vazia ou inferior a 2 letras     
* Histórico de Versões
*      :: 13/08/2021 »» JM :: Alteração de condições
*================================================================================================================================================

LOCAL nrLinha,count_design
nrLinha=0
count_design=0

SELECT FI
SCAN
    my_design=alltrim(fi.design)
    count_design=LEN(ALLTRIM(my_design))
    *messagebox(count_design)
    *messagebox(my_design)
    nrLinha=nrLinha+1

    DO CASE
    CASE ((fi.Eslvu>0) or (fi.Esltt>0) or (fi.qtt>0)) AND (count_design<=2)
        msg("Atenção! A linha nr: «"+nrLinha+"» tem valores de preço/total/quant. mas não tem designação")
        return .f.
    CASE (count_design<=2)
        return .f.
        msg("oiAtenção! A linha nr: «"+nrLinha+"» tem valores de preço/total/quant. mas não tem designação")

    ENDCASE
ENDSCAN
msg("FIM")
return .t.


*msg("Atenção! A linha nr: «"+nrLinha+"» deve ter três ou mais letras")


*com a designação: «"+my_design+"»