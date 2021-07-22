*================================================================================================================================================
* GRINCOP LDA
*      :: Data Criação:    22/07/2021
*      :: Programador:     João Mendes
*      :: Cliente:     Albimag
*      :: Objetivo:    Calcular preço de venda    
* Histórico de Versões
*      :: 22/07/2021 »» JM :: Criação
*================================================================================================================================================

*set point to "."
fecha("c_pvnovo")

LOCAL my_pvp1,my_precoCusto
LOCAL my_margem1,my_margem2,my_margem3,my_margem4,my_margem5
LOCAL my_ref

my_ref=""

select st
my_ref=st.ref


my_pvp1=st.epv1
my_pvp2=st.epv2
my_pvp3=st.epv3
my_pvp4=st.epv4
my_pvp5=st.epv5

my_precoCusto=st.EPCPOND
If my_precoCusto=0
    messagebox("Atenção! Preço de custo igual a zero. Vou sair")
ENDIF

*my_txj_intr=6.00
my_margem1=st.MARG1
my_margem2=st.MARG2
my_margem3=st.MARG3
my_margem4=st.MARG4
my_margem5=st.MARG5

*****************************
create cursor c_pvnovo (logico l(1),pvold n(16,6),pcpond n(16,6),margem n(16,6), pvnew n(16,6), ref c(25), myno n(16,2))
* coef n(16,10),txj n(16,6),vl_rend n(16,6),coef_intrn n(16,10),vl_c_rend n(16,6))

select c_pvnovo

append blank
Replace c_pvnovo.pvold with my_pvp1
replace c_pvnovo.margem with my_margem1
Replace c_pvnovo.pcpond with my_precoCusto
Replace c_pvnovo.pvnew with my_precoCusto*(1+(my_margem1/100))
Replace c_pvnovo.myno with 1

append blank
Replace c_pvnovo.pvold with my_pvp2
replace c_pvnovo.margem with my_margem2
Replace c_pvnovo.pcpond with my_precoCusto
Replace c_pvnovo.pvnew with my_precoCusto*(1+(my_margem2/100))
Replace c_pvnovo.myno with 2

append blank
Replace c_pvnovo.pvold with my_pvp3
replace c_pvnovo.margem with my_margem3
Replace c_pvnovo.pcpond with my_precoCusto
Replace c_pvnovo.pvnew with my_precoCusto*(1+(my_margem3/100))
Replace c_pvnovo.myno with 3

append blank
Replace c_pvnovo.pvold with my_pvp4
replace c_pvnovo.margem with my_margem4
Replace c_pvnovo.pcpond with my_precoCusto
Replace c_pvnovo.pvnew with my_precoCusto*(1+(my_margem4/100))
Replace c_pvnovo.myno with 4

append blank
Replace c_pvnovo.pvold with my_pvp5
replace c_pvnovo.margem with my_margem5
Replace c_pvnovo.pcpond with my_precoCusto
Replace c_pvnovo.pvnew with my_precoCusto*(1+(my_margem5/100))
Replace c_pvnovo.myno with 5


*****************************


i=5
declare list_tit(i),list_cam(i),list_pic(i),list_tam(i),list_ali(i),list_ronly(i),list_valid(i),list_combo(i)
i=0

i=i+1
list_tit(i) = "Conf?"
list_cam(i) = "c_pvnovo.logico"
list_pic(i) = "LOGIC"
list_ali(i) = 0
list_ronly(i)=.f.
list_tam(i)=8*5
list_valid(i)= ""

i=i+1
list_tit(i) = "PCustoPond do Artigo."
list_cam(i) = "c_pvnovo.pcpond"
list_pic(i) = "999,999,999.99 €"
list_ali(i) = 1
list_ronly(i)=.f.
list_tam(i)=8*5
*list_valid(i)= "my_proc_val_Marg(c_pvnovo.pvold)"
list_valid(i)= ""

i=i+1
list_tit(i) = "Margem"
list_cam(i) = "c_pvnovo.margem"
list_pic(i) = "999.99%"
list_ali(i) = 1
list_ronly(i)=.f.
list_tam(i)=8*5
list_valid(i)= "my_proc_NV_Prec(c_pvnovo.pvnew)"
*list_valid(i)= ""

i=i+1
list_tit(i) = "Novo PV do Artigo."
list_cam(i) = "c_pvnovo.pvnew"
list_pic(i) = "999,999,999.99 €"
list_ali(i) = 1
list_ronly(i)=.f.
list_tam(i)=8*5
list_valid(i)= "my_proc_val_Marg(c_pvnovo.margem)"
*list_valid(i)= ""

i=i+1
list_tit(i) = "Antigo PV do Artigo."
list_cam(i) = "c_pvnovo.pvold"
list_pic(i) = "999,999,999.99 €"
list_ali(i) = 1
list_ronly(i)=.f.
list_tam(i)=8*5
*list_valid(i)= "my_proc_val_Marg(c_pvnovo.pvold)"
list_valid(i)= ""



*****************************
m.escolheu=.f.
=CURSORSETPROP('Buffering',5,"c_pvnovo")

*browlist("Cálculo de Rendas... ","c_pvnovo","c_pvnovo",.t.,.f.,.t.,.T.,.F.,'myprc1_anuid()')
browlist("Cálculo de Novo Preço Venda (EPV)... ","c_pvnovo","c_pvnovo",.t.,.f.,.t.,.T.,.F.)

if .not. m.escolheu
    fecha("c_pvnovo")
    return
Endif


*******************************************************************************************************
*******************************************************************************************************
*********************************************UPDATE***********************************************
Select c_pvnovo
GO top
SCAN
IF c_pvnovo.logico
    *my_updt=[update st set EPV]+astr(c_pvnovo.myno)+[=]+astr(c_pvnovo.pvnew)+[ where ref =']+alltrim(upper(my_ref))+[']
    my_updt=[update st set EPV]+astr(c_pvnovo.myno)+[=]+strtran(astr(c_pvnovo.pvnew),',','.')+[ where ref =']+alltrim(upper(my_ref))+[']
    
    msg(my_updt)

    if u_sqlexec ([BEGIN TRANSACTION])
        If u_sqlexec(my_updt)
            u_sqlexec([COMMIT TRANSACTION])
            WAIT WINDOW "A alterar o preço do artigo "+alltrim(upper(c_pvnovo.ref)) TIMEOUT 1
        else
            u_sqlexec([ROLLBACK])
            Messagebox("O preço do artigo "+alltrim(upper(c_pvnovo.ref))+ " não foi alterado !!")
            exit
        endif
    endif

ENDIF
ENDSCAN

*******************************************************************************************************
*******************************************************************************************************



* volta a repor as decimais da aplicação 
*set point to se_pointer

*******************************************************************************************************
*******************************************************************************************************
*********************************************PROCEDIMENTOS*********************************************
***Procedimento para calcular novo preço venda em função da margem
procedure my_proc_val_Marg()
parameters my_marg,campo_a,campo_b,campo_c
***
    select c_pvnovo
    Replace c_pvnovo.pvnew with c_pvnovo.pcpond*(1+(my_marg/100))
    return .t.
endproc

**********************************************************************

***Procedimento para calcular nova margem em função do novo preço
procedure my_proc_NV_Prec()
parameters my_nvpreco,campo_a,campo_b,campo_c
***
    select c_pvnovo
    Replace c_pvnovo.margem with (((c_pvnovo.pvold-c_pvnovo.pcpond)/c_pvnovo.pcpond)*100)
    *Replace c_pvnovo.margem with (((my_nvpreco-c_pvnovo.pcpond)/c_pvnovo.pcpond)*100)
    *Replace c_pvnovo.margem with (((c_pvnovo.pvnew-c_pvnovo.pcpond)/c_pvnovo.pcpond)*100)
    return .t.
endproc



*****************************************************************************************************
************************
*procedure my_proc_vald_tx()
*parameters txj_n,campo_a,campo_b,campo_c

*local n,capt,my_perd,my_termos2
**
*if c_pvnovo.periodo=''
    *my_perd=1
*endif
*
*if c_pvnovo.periodo='Mensais'
    *my_perd=12
*endif
*
*if c_pvnovo.periodo='Trimestrais'
    *my_perd=4
*endif
**
**********


*************
procedure my_proc_vald_coef()
parameters coefc,campo_a,campo_b,campo_c

local n,my_tj,my_incr,mlnclc2,n,my_tj2,my_tj3,my_term,my_perd,my_tjx
local capt,my_varst
my_tj3=0
my_tj=0
my_incr=0.0001
my_varst=''
my_tjx=0

select c_pvnovo
go top
*n=iif(c_pvnovo.n_t_rend=0,1,c_pvnovo.n_t_rend)

*if c_pvnovo.periodo=''
    *my_perd=1
*endif

*if c_pvnovo.periodo='Mensais'
    *my_perd=12
*endif

*if c_pvnovo.periodo='Trimestrais'
    *my_perd=4
*endif

**
*my_term=c_pvnovo.termos
**
*if c_pvnovo.pvold=0
    *capt=1
    *replace c_pvnovo.pvold with capt
*endif

*if c_pvnovo.pvold>0
    *capt=c_pvnovo.pvold
*endif
**


*************
procedure my_proc_vald_pc_eq()
parameters pcpond,campo_a,campo_b,campo_c
***
select c_pvnovo
replace c_pvnovo.vl_c_rend with round(c_pvnovo.coef_intrn*pcpond,2)

return .t.
endproc