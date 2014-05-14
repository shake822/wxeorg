<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
for j = 1 to 9
	str = str & "," & Request.Form("0"&j)
next
sql = "update t_user set authority='" & str & "' where username='"&request.QueryString("user")&"'"
conn.execute(sql)
endconnection
response.Redirect "../common/power.asp"
%>