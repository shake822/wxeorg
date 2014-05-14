<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
custname=unescape(request("custname"))
set rsDel = Server.CreateObject("adodb.recordset")
sql = "select * from t_custom where custname = '" & custname & "'"
rsDel.open sql, conn, 1, 3
rsDel.delete
rsDel.update
rsDel.close
set rsDel = nothing
Response.End
'Response.Write s_account
%>