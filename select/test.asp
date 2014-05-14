<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../public/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
nowid=unescape(request.Form("nowid"))
sql = "select * from Dict_Units where 1=1 order by c_Depth asc"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
rs.movefirst
do while not rs.eof
response.Write("["&rs("c_depth") & "|" & cstr(nowid) & "]")
	if trim(cstr(rs("c_Depth"))) = trim(cstr(nowid)) then  
		exit do
	end if
	rs.movenext
loop
nowChildNum = rs("c_ChildNum")
rs.moveprevious 
preChildNum = rs("c_ChildNum")
preid = rs("c_Depth")
sql = "update Dict_Units set c_Depth = "& nowid &" where c_ChildNum = "& preChildNum &" "
response.Write(sql)
conn.execute(sql)
sql = "update dict_cate set c_Depth = "& preid &" where c_ChildNum = "& nowChildNum &""
response.Write(sql)
conn.execute(sql)
Response.End
'rs.close
%>