<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../public/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
cid=unescape(request.Form("cid"))

q = "delete from Dict_Units where c_ChildNum="&cid&" "
conn.execute q
response.Write(q)


%>