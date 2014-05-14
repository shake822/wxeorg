<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
on error resume next
conn.BeginTrans
sBillCode = Request.QueryString("billcode")
sql = "delete from t_price where billcode = '"& sBillCode &"'"
conn.Execute(sql)
if err <> 0 then
	Response.Write("<script>alert('删除单据时出现错误!');</script>")
	conn.rollbacktrans
else
	Response.Write("<script>alert('删除成功！');</script>")
	conn.CommitTrans
end if
endconnection
%>
<script>
window.opener.location.reload();
window.close();
</script>