<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
goodscode=unescape(request("goodscode"))
set rsDel = Server.CreateObject("adodb.recordset")
sql = "select * from t_goods where goodscode = '" & goodscode & "'"
rsDel.open sql, conn, 1, 3
rsDel.delete
rsDel.update
rsDel.close
set rsDel = nothing
Response.End
'Response.Write s_account
%>