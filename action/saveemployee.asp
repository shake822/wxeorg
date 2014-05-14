<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
s_name = Request("name")
s_sex = Request("sex")
s_address = Request("address")
s_email = Request("email")
s_tel = Request("tel")
s_memo = Request("memo")
s_mobile = Request("mobile")
s_birthday = Request("birthday")
s_xueli = Request("xueli")
If Request.QueryString("add") = "true" Then
    sql = "insert into t_employee (name,sex,address,email,tel,memo,mobile,birthday,xueli) values ('"&s_name&"','"&s_sex&"','"&s_address&"','"&s_email&"','"&s_tel&"','"&s_memo&"','"&s_mobile&"','"&s_birthday&"','"&s_xueli&"')"
Else
    sql = "update t_employee set name='"&s_name&"',sex='"&s_sex&"',address='"&s_address&"',email='"&s_email&"',tel='"&s_tel&"',memo='"&s_memo&"',mobile='"&s_mobile&"',birthday='"&s_birthday&"',xueli='"&s_xueli&"' where id="&request("employeeid")
End If
conn.Execute(sql)
endconnection
%>
<script language=javascript>
window.location='../common/employee.asp'
</script>
