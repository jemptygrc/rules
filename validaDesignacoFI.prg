*================================================================================================================================================
* GRINCOP LDA
*      :: Data Cria��o:    12/08/2021
*      :: Cliente:     XYZ
*      :: Objetivo:    IMpedir gravacao de faturas com linhas com valores preenchidos e designacao vazia ou inferior a 2 letras     
* Hist�rico de Vers�es
*      :: 13/08/2021 �� JM :: Altera��o de condi��es
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
        msg("Aten��o! A linha nr: �"+nrLinha+"� tem valores de pre�o/total/quant. mas n�o tem designa��o")
        return .f.
    CASE (count_design<=2)
        return .f.
        msg("oiAten��o! A linha nr: �"+nrLinha+"� tem valores de pre�o/total/quant. mas n�o tem designa��o")

    ENDCASE
ENDSCAN
msg("FIM")
return .t.


*msg("Aten��o! A linha nr: �"+nrLinha+"� deve ter tr�s ou mais letras")


*com a designa��o: �"+my_design+"�