<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_name=unescape(request("name"))
Response.Write isdate(s_name)
Response.End
rs.close
'Response.Write s_account
%>