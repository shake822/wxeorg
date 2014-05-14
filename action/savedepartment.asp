<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sDepartname = Request.Form("departname")
sContact = Request.Form("contact")
sTel = Request.Form("tel")
sMobile = Request.Form("mobile")
sAddress = Request.Form("address")
sMemo = Request.Form("memo")

If Request.QueryString("add") = "true" Then
    sql = "insert into t_department (name,contact,address,tel,memo,mobile) values ('"&sDepartname&"','"&sContact&"','"&sAddress&"','"&sTel&"','"&sMemo&"','"&sMobile&"')"
Else
    sql = "update t_department set name='"&sDepartname&"',contact='"&sContact&"',address='"&sAddress&"',tel='"&sTel&"',memo='"&sMemo&"',mobile='"&sMobile&"' where id="&Request.Form("Departid")

End If
conn.Execute(sql)
%>
<script language=javascript>
window.location='../common/department.asp'
</script>
