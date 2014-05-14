<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
sql = "delete from t_invoice where invoicecode='"&Request.QueryString("id")&"'"
conn.Execute(sql)
endconnection
%>
<script>
window.history.go(-1);
</script>
