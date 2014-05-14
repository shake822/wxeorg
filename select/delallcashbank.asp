<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
billcode=unescape(request("billcode"))
set rsDel = Server.CreateObject("adodb.recordset")
sql = "select * from t_cashbank where billcode = '" & billcode & "'"
rsDel.open sql, conn, 1, 3
if left(cashcode, 2) = "SR" then
  power = Authority("strDelSR")
else
  power = Authority("strDelZC")
end if
if power = "False" then
	Response.Write cashcode & ":ÎÞÉ¾³ýÈ¨ÏÞ"
else
	Response.Write "True"
	rsDel.delete
	rsDel.update
end if
rsDel.close
set rsDel = nothing
Response.End
'Response.Write s_account
%>