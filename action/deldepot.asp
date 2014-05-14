<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "delete from t_depot where id="&request.QueryString("id")
conn.Execute(sql)
endconnection
%>
<script language=javascript>
window.location='../common/depot.asp'
</script>
