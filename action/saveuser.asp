<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
if Request.QueryString("add") = "true" then  '--------------添加用户 
s_username = Request("username")
s_password = Request("password")

sql_check = "select * from t_user where username='"&s_username&"'"
set rs = server.CreateObject("adodb.recordset")
rs.Open sql_check, conn, 1, 1

Response.Write(rs.recordcount)
if rs.recordcount > 0 then
%>
<script>
alert('不能保存同一个操作员！')
window.history.go(-1);
</script>
<%
else
	if Request.Form("Rdepot") = "" then
	   b_depot = 0
	else
	   b_depot = 1
	end if
	if Request.Form("Rcust") = "" then
	   b_cust = 0
	else
	   b_cust = 1
	end if
	if Request.Form("Rgoodscode") = "" then
	   b_type = 0
	else
	   b_type = 1
	end if
sql = "insert into t_user (username,password,RDepot,authority) values ('"&s_username&"','"&s_password&"',"&b_depot&",'bad101')"


conn.Execute(sql)


arr = split(Request.Form("depot"),",")

for i = lbound(arr) to ubound(arr)
  sql_depot = sql_depot & trim(arr(i))&","
next
sql_depot = "update t_user set depotname='"&sql_depot&"' where username = '"&s_username&"'"
response.Write(sql_depot)
conn.Execute(sql_depot)





response.Redirect "../common/user.asp"
end if

else   '----------------------编辑用户

s_username = Request("username")
	if Request.Form("Rdepot") = "" then
	   b_depot = 0
	else
	   b_depot = 1
	end if
	if Request.Form("Rcust") = "" then
	   b_cust = 0
	else
	   b_cust = 1
	end if
	if Request.Form("Rgoodscode") = "" then
	   b_type = 0
	else
	   b_type = 1
	end if
sql = "update t_user set username='"&s_username&"',password='"&request("pass")&"',RDepot="&b_depot&" where username = '" & Request.QueryString("user") & "'"
response.Write(sql)
conn.Execute(sql)

arr = split(Request.Form("depot"),",")
'没有选中任何仓库时，则不能保存
for i = lbound(arr) to ubound(arr)
  sql_depot = sql_depot & trim(arr(i))&","
next
sql_depot = "update t_user set depotname='"&sql_depot&"' where username = '"&s_username&"'"
response.Write(sql_depot)
conn.Execute(sql_depot)


endconnection
response.Redirect "../common/user.asp"
end if
%>