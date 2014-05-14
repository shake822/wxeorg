<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "delete from t_employee where name='"&request.QueryString("id")&"'"
conn.Execute(sql)
endconnection
%>
<script language=javascript>
window.location='../common/employee.asp'
</script>
