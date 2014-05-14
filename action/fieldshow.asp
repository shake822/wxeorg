<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
conn.begintrans
sql = "select * from t_fieldshow where tablename = '" & Request.QueryString("tablename") & "'"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1

for i = 1 to rs.recordcount
  str = "update t_fieldshow set "
  str = str & "name = '" & Request.Form(rs("id")&"name") & "',"
  str = str & "width = '" & Request.Form(rs("id")&"width") & "',"
  if Request.Form(rs("id")&"show") <> "" then
    str = str & "show = 1,"
  else
    str = str & "show = 0,"
  end if
  str = str & "showid = '" & Request.Form(rs("id")&"showid") & "' "
  str = str & "where id = " & rs("id")
  conn.Execute(str)
rs.movenext
next
if conn.errors.count > 0 then
  conn.errors.clear
  conn.rollbacktrans
close_rs(rs)
endconnection
%>
<script>
alert("保存出错，请检查数据！");
window.close();
</script>
<%
end if
conn.CommitTrans
%>
<script>
alert("保存成功！");
window.close();
</script>