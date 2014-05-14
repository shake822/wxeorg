<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "delete from dict_in where id="&request.QueryString("id")
conn.Execute(sql)
endconnection
%>
<script language=javascript>
window.location='../common/in_type.asp'
</script>
