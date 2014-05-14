<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_goodscode=unescape(request.Form("goodscode"))
sql = "select * from t_goods where goodscode = '" & s_goodscode & "'"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
If rs.eof Then
Else
	response.write rs("goodsname")&"|"&rs("goodsunit")&"|"&rs("units")
	rs.close
End If
%>