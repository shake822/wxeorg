<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
if Request.QueryString("username") = "admin" then
%>
<script>
alert("admin²»ÄÜ±»É¾³ý£¡");
window.history.go(-1);
</script>
<%
else
s_username=Request.QueryString("username")
sql = "delete from t_user where username='"&s_username&"'"
conn.execute(sql)
sql = "delete from t_power where user='"&s_username&"'"
conn.execute(sql)
endconnection
response.Redirect "../common/user.asp"
end if
%>
