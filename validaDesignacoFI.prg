*================================================================================================================================================
* GRINCOP LDA
*      :: Data Cria��o:    12/08/2021
*      :: Cliente:     XYZ
*      :: Objetivo:    IMpedir gravacao de faturas com linhas com valores preenchidos e designacao vazia ou inferior a 2 letras     
* Hist�rico de Vers�es
*      :: 12/08/2021 �� JM :: Cria��o
*================================================================================================================================================


SELECT FI 
GO TOP
SCAN
    MSG("ola")
    if (fi.Eslvu>0) or (fi.Esltt>0) AND empty(fi.desing)
        msg("Aten�ao!Designacao vazia em linha com valores")
    endif
ENDSCAN