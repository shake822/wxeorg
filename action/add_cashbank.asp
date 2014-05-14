<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
if Request.QueryString("type") = "SR" then
  s_billtype = "其他收入"
  i_sign = 1
else
  s_billtype = "其他支出"
  i_sign = -1
end if
conn.BeginTrans
if Request.QueryString("add") = "true" then
  sql = "insert into t_cashbank (billcode,adddate,account,money,billtype,projectname,remark,user,oldbill,sign) values ("
  sql = sql & "'" & Request.Form("billcode") & "',"
  sql = sql & "'" & Request.Form("date") & "',"
  sql = sql & "'" & Request.Form("account") & "',"
  sql = sql & "" & Request.Form("money") & ","
  sql = sql & "'" & s_billtype & "',"
  sql = sql & "'" & Request.Form("projectname") & "',"
  sql = sql & "'" & Request.Form("remark") & "',"
  sql = sql & "'" & Request.Form("user") & "',"
  sql = sql & "'" & Request.Form("oldbill") & "',"
  sql = sql & "'" & i_sign & "'"
  sql = sql & ")"
end if

if Request.QueryString("add") = "false" then
  sql = "update t_cashbank set "
  sql = sql & "adddate = '" & Request.Form("date") & "',"
  sql = sql & "account = '" & Request.Form("account") & "',"
  sql = sql & "money = " & Request.Form("money") & ","
  sql = sql & "billtype = '" & s_billtype & "',"
  sql = sql & "projectname = '" & Request.Form("projectname") & "',"
  sql = sql & "remark = '" & Request.Form("remark") & "',"
  sql = sql & "user = '" & Request.Form("user") & "',"
  sql = sql & "oldbill = '" & Request.Form("oldbill") & "',"
  sql = sql & "sign = " & i_sign 
  sql = sql & " where billcode = '" & Request.Form("billcode") & "'"
end if

conn.execute(sql)

if conn.Errors.Count > 0 then
  conn.Errors.Clear
  conn.RollBackTrans
end if
conn.CommitTrans
endconnection
%>
<script>
alert('保存成功！');
window.close();
</script>