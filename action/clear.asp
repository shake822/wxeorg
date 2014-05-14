<!-- #include file="../inc/connExcel.asp" -->
<!-- #include file="checkuser.asp" -->
<%
dim arr
arr = split(Request.Form("checkbox"),",")
for i = lbound(arr) to ubound(arr)
  if arr(i) = "delete from t_goods" then
  	sql = "delete from t_start"
	conn.execute(sql)
  end if
  conn.execute(arr(i))
next

sql = "insert into t_clearmaker (maker,adddate) values ('"&request.cookies("username")&"','"&date()&"-"&time()&"')"
conn.execute(sql)
endconnection
response.Redirect "../common/clear.asp"
%>