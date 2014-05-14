<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "delete from dict_out where id="&request.QueryString("id")
conn.Execute(sql)
endconnection
%>
<script language=javascript>
window.location='../common/out_type.asp'
</script>
