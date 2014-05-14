<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
invoicecode=unescape(request("invoicecode"))
set rsDel = Server.CreateObject("adodb.recordset")
sql = "select * from t_invoice where invoicecode = '" & invoicecode & "'"
rsDel.open sql, conn, 1, 3
Response.Write "True"
rsDel.delete
rsDel.update
rsDel.close
set rsDel = nothing
Response.End
'Response.Write s_account
%>