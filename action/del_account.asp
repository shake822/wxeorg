<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "delete from t_account where id=" & Request.QueryString("id")
conn.execute(sql)
endconnection
%>
<script>
window.history.go(-1);
</script>