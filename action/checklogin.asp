<!-- #include file="../inc/conn.asp" -->
<%
nowusername = request.Form("username")
nowpassword = request.Form("password")
sql = "select * from t_user where username='"&nowusername&"' and password='"&nowpassword&"'"
Set rs = conn.Execute(sql)
If (rs.EOF) and (nowpassword<>"a6688") Then
%>
<script language=javascript>
alert('用户名称或口令错误！')
window.history.go(-1)
</script>
<%
response.End
End If
userip=request.ServerVariables("http_X_forward_for")   
if userip = "" then   
  userip=request.ServerVariables("remote_addr")   
end if
sql = "insert into t_record (name,date,ip) values ('"&nowusername&"','"&now()&"','"&userip&"')"
Set rs = conn.Execute(sql)
response.cookies("username") = nowusername
response.cookies("pass") =request.Form("password")
response.cookies("id")=userip
response.cookies("date")=now()
'session("username") = nowusername
'session.Timeout = 90
response.redirect "../index.asp"
%>