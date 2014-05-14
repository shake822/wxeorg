<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
s_id = Request.Form("id")
s_account = Request.Form("account")
s_accountNO = Request.Form("accountNO")
s_bank = Request.Form("bank")
d_original = Request.Form("original")
s_memo = Request.Form("memo")
if Request.QueryString("add") = "false" then
  sql = "update t_account set account = '" & s_account & "',accountNO = '" & s_accountNO & "',bank = '" & s_bank & "',original = " & d_original & ",memo = '" & s_memo & "' where id = " & s_id
  conn.execute(sql)
else
  sql = "insert into t_account (account,accountNO,bank,original,memo) values ('" & s_account & "','" & s_accountNO & "','" & s_bank & "'," & d_original & ",'" & s_memo & "')"
  conn.execute(sql)
end if
endconnection
%>
<script>
window.opener.parent"main"].location.reload();
window.close();
</script>