<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
employeename=unescape(request("employeename"))
set rsDel = Server.CreateObject("adodb.recordset")
sql = "select * from t_employee where name = '" & employeename & "'"
rsDel.open sql, conn, 1, 3
rsDel.delete
rsDel.update
rsDel.close
set rsDel = nothing
Response.End
'Response.Write s_account
%>