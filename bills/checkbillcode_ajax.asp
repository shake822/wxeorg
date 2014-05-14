<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_billcode=unescape(request("billcode"))
sql = "select count(*) as c from t_bill where billcode = '" & s_billcode & "'"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
if CInt(rs("c"))>0 then
  Response.Write "False"
else
  Response.Write "True"
end if
Response.End
rs.close
%>