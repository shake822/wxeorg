<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
invoicecode=unescape(request("invoicecode"))
sql = "select count(*) as c from t_invoice where invoicecode = '" & invoicecode & "'"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
if CInt(rs("c"))>0 then
  Response.Write "False"
else
  Response.Write "True"
end if
Response.End
rs.close
'Response.Write s_account
%>