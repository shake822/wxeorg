<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
sql = "select count(*) as c from (select case when sum(number*flag) is null then 0 else sum(number*flag) end as depotnum,goodscode from s_billdetail group by goodscode) as s left join t_goods as g on s.goodscode=g.goodscode where (depotnum > depotup or depotnum < depotdown)"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
Response.Write rs("c")
Response.End
rs.close
'Response.Write s_account
%>