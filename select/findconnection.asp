<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
sql = "select count(*) as c from [Master].[dbo].[SYSPROCESSES] where (dbid in (select dbid from [Master].[dbo].[SYSDATABASES] where name = 'BSSQLJXC'))"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
Response.Write rs("c")
Response.End
rs.close
%>