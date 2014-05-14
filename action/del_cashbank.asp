<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if left(Request.QueryString("billcode"),2) = "SR" then
  call CheckAuthority("strDelSR")
else
  call CheckAuthority("strDelZC")
end if
conn.BeginTrans
sql = "delete from t_cashbank where billcode = '" & Request.QueryString("billcode") & "'"
conn.execute(sql)
if conn.Errors.Count > 0 then
  conn.Errors.Clear
  conn.RollBackTrans
end if
conn.CommitTrans
endconnection
%>
<script>
window.close();
</script>