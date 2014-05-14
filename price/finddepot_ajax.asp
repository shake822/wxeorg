<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_goodscode=unescape(request.Form("goodscode"))
s_depotname=unescape(Request.Form("depotname"))
sql = "select * from t_stock where goodscode = '" & s_goodscode & "' and depotname = '"& s_depotname &"'"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
If rs.eof Then
	response.write "0|0"
	rs.close
Else
	response.write rs("qty")&"|"&rs("price")
	rs.close
End If
%>