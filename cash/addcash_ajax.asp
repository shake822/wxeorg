<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_account=unescape(request("account"))
sql = "select * from t_account where account = '" & s_account & "'"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
If rs.eof Then
Else
	s_bank = rs("bank")
	s_accountNO = rs("accountNO")
	response.write s_bank&"|"&s_accountNO
	response.end
End If
rs.close
'Response.Write s_account
%>