'Dim dt As DataRow
'dt = mainFormDataSet.Tables("bo").Rows(0)
'Dim _dataTable As DataTable = cdata.getdatatable($"select bo.no,convert(char(11),bo.dataopen,105),bo.nome,bo.tabela2,bo.vendnm,bi.ref,bi.design,bi.qtt
    'from bo(nolock)
    'inner join
    'bo2 (nolock)
    'on bo.bostamp=bo2.bo2stamp 
    'inner join 
    'bi (nolock) 
    'on bo.bostamp=bi.bostamp
    'where 1=1
    'and bo.bostamp = 'STAMP'
    'and bo.ndos=1
    'and bo.fechada=0
    'and bo.dataobra>='01-01-2018' 
    'order by bo.dataobra ")

    'Definir email de envio
    'Dim emailsend as String=""
    'emailsend+="joao.mendes@grincop.pt"
    'return emailsend

    'Definir assunto do email
    'dim retval as string=""
    'retval="TESTES TEST JM "
    'return retval

    'Definir Corpo do Email
    'Dim body As String
    'body+="TESTE TESTE TESTE"
    'body+="LOREM IPSUM"
    'return body
    MsgBox("EM DESENVOLVIMENTO")

    dim txtemail as webcontrollib.nossocampotextbox
    ' Constrói uma string que vai ser o corpo do email
    txtemail =mpage.master.findcontrol("conteudo").findcontrol("campos").findcontrol("no")
    dim email as string = cdata.getumvalorstring("email", "cl", "cl.no='" & txtemail.value & "'")
    dim mform as mainform=mpage
    'xcutil.GenEmail(xcuser.useremail, email, "", "", "Assunto", xcutil.formatnotification(txtemail))
    xcutil.GenEmail("joao.mendes@grincop.pt", "joao.mendes@grincop.pt", "", "", "Assunto", xcutil.formatnotification(txtemail))